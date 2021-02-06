# CombineXAsync

[![Release](https://img.shields.io/badge/Release-v0.0.1-green)]()
![Install](https://img.shields.io/badge/Install-SPM-orange)
![Platform](https://img.shields.io/badge/Platform-macOS%2010.10%20%7C%20iOS%209.0%20%7C%20tvOS%209.0%20%7C%20watchOS%202.0-lightgrey)

[简体中文](https://github.com/KKLater/CombineAsync/blob/main/README_CN.md)

`CombineXAsync` 'is an encapsulation based on `CombineX Future`. It encapsulates `Future` and provides `async` and `await` API to handle asynchronous events gracefully.

## Requirements

* macOS 10.10 + / iOS 9.0 + / tvOS 9.0 + / watchOS 2.0 +
* Swift 5.0+

If your project is based on the system `Combine` framework, and the project environment is `macOS 10.15 + / iOS 10.0 + / tvOS 10.0 + / watchOS 6.0 + `, then you can choose to use [CombineAsync]( https://github.com/KKLater/CombineAsync ) framework. If your project uses the [OpenCombine](https://github.com/broadwaylamb/OpenCombine) framework, you can choose [OpenCombineAync](https://github.com/KKLater/OpenCombineAsync) framework.

## Installation

### Swift Package Manager (SPM)

Swift Package Manager is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

> Xcode 11+ is required to build `CombineXAsync` using Swift Package Manager.

To integrate `CombineXAsync` into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/KKLater/CombineXAsync.git", .upToNextMajor(from: "0.0.1"))
]
```

## Usage

Asynchronous operations need to be wrapped as `Future` objects of `CombineX`.

```swift
func background1() -> Future<Int, Error> {
    return Future<Int, Error> { promise in
        let i:Int = Int(arc4random() % 10)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.microseconds(i)) {
            promise(.success(1))
        }
    }
}

func background2(c: Int) -> Future<Int, Error> {
    return Future<Int, Error> { promise in
        let i:Int = Int(arc4random() % 10)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.microseconds(i)) {
            promise(.success(c + 10))
        }
    }
}

func background3(c: Int) -> Future<Int, Error> {
    return Future<Int, Error> { promise in
        let i:Int = Int(arc4random() % 10)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.microseconds(i)) {
            promise(.success(c + 100))
        }
    }
}
```

Before use `async` and  `await` api:

```swift
self.background1().sink { (error) in
    print(error)
} receiveValue: { (a) in
    self.background2(c: a).sink { (error) in
        print(error)
    } receiveValue: { (b) in
        self.background3(c: b).sink { (error) in
            print(error)
        } receiveValue: { (c) in
            print(c) // 111
        }.store(in: &self.cancels)

    }.store(in: &self.cancels)
}.store(in: &cancels)

```

After using the `async` and `await` APIs:

```swift
async {
    do {
        let a = try await(self.background1())
        let b = try await(self.background2(c: a))
        let c = try await(self.background3(c: b))
        main {
            print(c) // 111
        }
    } catch {
        throw error
    }
}
```

## License

`CombineXAsync` is released under the `MIT` license. See `LICENSE` for details.


