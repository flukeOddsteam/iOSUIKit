//
//  DSLottie.swift
//  OneAppDesignSystem
//
//  Created by TTB on 10/4/2567 BE.
//

import Foundation

public protocol DSLottieResource {
    var filename: String { get }
    var bundle: Bundle { get }
}

/**
 Custom token DSLottie for Design System
 Parameter | Description
   --- | ---
   `resource` | ` DSLottieResource` The attribute that contain filename and bundle.

 ## Example
 ```swift
 let resource = DSLottie.something.resource
 let animationView = AnimationView(name: resource.filename, bundle: resource.bundle)
```
 */
public enum DSLottie {
    case lottieWaitingScreenInternalDefault
    case lottieWaitingScreenExternal2C2PtoTTB
    case lottieWaitingScreenExternalTTBto2C2P
    case lottieWaitingScreenExternalTTBtoThirdPartyDefault
    case lottieWaitingScreenExternalThirdPartyDefaultToTTB
}

public extension DSLottie {
    var resource: DSLottieResource {
        switch self {
        case .lottieWaitingScreenInternalDefault:
            return LottieResource(
                filename: "lottieWaitingScreenInternalDefault"
            )
        case .lottieWaitingScreenExternal2C2PtoTTB:
            return LottieResource(
                filename: "lottieWaitingScreenExternal2C2PtoTTB"
            )
        case .lottieWaitingScreenExternalTTBto2C2P:
            return LottieResource(
                filename: "lottieWaitingScreenExternalTTBto2C2P"
            )
        case .lottieWaitingScreenExternalTTBtoThirdPartyDefault:
            return LottieResource(
                filename: "lottieWaitingScreenExternalTTBtoThirdPartyDefault"
            )
        case .lottieWaitingScreenExternalThirdPartyDefaultToTTB:
            return LottieResource(
                filename: "lottieWaitingScreenExternalThirdPartyDefaultToTTB"
            )
        }
    }
}

fileprivate extension DSLottie {
    struct LottieResource: DSLottieResource {
        var filename: String
        var bundle: Bundle

        init(
            filename: String,
            bundle: Bundle = .dsBundle
        ) {
            self.filename = filename
            self.bundle = bundle
        }
    }
}
