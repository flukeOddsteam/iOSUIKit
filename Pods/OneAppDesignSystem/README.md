# Design system iOS

## Link

- [Documentation](https://ttbbank.atlassian.net/wiki/spaces/UXUI/pages/397476473/1.1.1+Document)
- [Changelogs](https://ttbbank.atlassian.net/wiki/spaces/UXUI/pages/383910681/2.1+iOS)
- [Release Guide](https://bitbucket.org/ttbbank/one_oneapp-designsystem-ios/src/release/RELEASE_GUIDE.md)
- [Git Flow](https://bitbucket.org/ttbbank/one_oneapp-designsystem-ios/src/release/GITFLOW.md)

---

## Setup Private Repo

Setup private repo before upload .podspec file

1. Go to project directory
2. Use command

```
pod repo add OneAppDesignSystem https://bitbucket.org/ttbbank/one_oneapp-designsystem-ios-private-pods.git
```

---

## Upload Private Pod

> **WARNING**: Macbook silicon chip (M1/M2) should install cocoapod via [Homebrew](https://formulae.brew.sh/formula/cocoapods)

### Prerequsite

1. [Cocoapods](https://guides.cocoapods.org/using/getting-started.html)
2. [Fastlane](https://fastlane.tools/)
3. [SourceDocs](https://github.com/SourceDocs/SourceDocs)

### Using Makefile

```
make release version=x.x.x
```

---

## Semantic Versioning

Given a version number MAJOR.MINOR.PATCH, increment the:

1. MAJOR version when you make incompatible changes
2. MINOR version when you add functionality in a backwards compatible manner
3. PATCH version when you make backwards compatible bug fixes

## Code convention

### New Component example

```swift
import UIKit
// import list should ordered by name

public final class SomeView: UIView {
    // Start with IBOutlet properites
    @IBOutlet private weak var titleLabel: UILabel!

    // Public properties
    public var title = "Hello"

    // Private properties
    private var world = "world"

    // Constructor
    init(...) {
        ...
    }

    // Public method (overrided first)
    public override func layoutSubviews() {
        // always call super
        super.layoutSubviews()
    }

    // Setup function (require)
    // Group of mendatory attribute
    public func setup(argument: ...) {
        ...
    }
}

// Use extension for conforming protocol
extension SomeView: UITableViewDelegate {
    // Conformed method here
}

// Group of private function
private extension SomeView {
    func comonInit() {
      ...
    }
}

```
