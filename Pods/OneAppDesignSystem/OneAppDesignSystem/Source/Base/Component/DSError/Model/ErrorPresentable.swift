//
//  ErrorPresentable.swift
//  OneAppDesignSystem
//
//  Created by TTB on 15/5/2567 BE.
//

import UIKit
private enum Constants {
    static let iconJSONFileName = "icon"
    static let illustrationJSONFileName = "illustration"
    static let jsonFileExtension = "json"
}

enum ErrorPresentableSubType {
    case bottomSheet(ErrorData.ErrorBottomSheetSubType)
    case fullPage
}

enum ErrorPresentableImageType {
    case illustration
    case icon
    
    func value<T>(illustration: T, icon: T) -> T {
        switch self {
        case .illustration:
            return illustration
        case .icon:
            return icon
        }
    }
}

struct ErrorPresentable {
    var type: ErrorData.ErrorType
    var subType: ErrorPresentableSubType
    var imageType: ErrorPresentableImageType
    var title: String
    var description: String
    var primaryButtonTitle: String
    var ghostButtonTitle: String?
    var image: UIImage
    var multipleConditionData: [MultipleConditionData]?
    
    init(
        errorData: ErrorData,
        params: DSErrorContentParameter?,
        configuration: [String: Bool]?
    ) {
        if let typeString = errorData.type, let type = ErrorData.ErrorType(rawValue: typeString) {
            self.type = type
        } else {
            self.type = .fullPage
        }
        
        subType = type.value(
            bottomSheet: {
                if let subTypeString = errorData.subType,
                   subTypeString.isNotEmpty,
                   let subType = ErrorData.ErrorBottomSheetSubType(rawValue: subTypeString) {
                    return .bottomSheet(subType)
                } else {
                    return .bottomSheet(.block)
                }
            }(),
            fullPage: .fullPage
        )
        
        self.image = UIImage()
        self.imageType = .icon
        if let iconName = errorData.icon, iconName.isNotEmpty {
            self.image = UIImage(
                named: iconName,
                in: .dsBundle,
                compatibleWith: nil
            ) ?? UIImage()
            imageType = .icon
        }
        
        if let illustration = errorData.illustration, illustration.isNotEmpty {
            self.image = UIImage(
                named: illustration,
                in: .dsBundle,
                compatibleWith: nil
            ) ?? UIImage()
            imageType = .illustration
        }
        
        self.title = errorData.title.unwrapped.localize(
            params: params?.title
        )
        
        self.description = errorData.desc.unwrapped.localize(
            params: params?.description
        )
        
        self.primaryButtonTitle = errorData.primaryButton.unwrapped.localize()
        
        if let ghostButton = errorData.ghostButton, ghostButton.isNotEmpty {
            self.ghostButtonTitle = ghostButton.localize()
        }
        
        self.multipleConditionData = errorData.multipleCondition?.compactMap { data in
            let localizedTitle = data.phrase.unwrapped.localize(params: params?.description)
            
            guard let configuration = configuration,
                  let isCorrect = configuration[data.param.unwrapped] else {
                return nil
            }
            
            let state: DSKeyHighlightConditionState = isCorrect ? .correct : .incorrect
            
            return MultipleConditionData(title: localizedTitle, state: state)
        }
    }
}
