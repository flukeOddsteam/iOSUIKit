//
//  DSBottomSheetMenuListMultiSectionViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 24/10/24.
//

import UIKit

/**
 ## Description
 This Swift file defines two structs, `DSBottomSheetMenuListMultiSectionViewModel` and `DSBottomSheetMenuListMultiSectionItem`, which are used to represent a multi-section menu list with items that have an image, title, and optional description.
 
 ## Usage
 ### DSBottomSheetMenuListMultiSectionViewModel
 - **Properties**:
   - `header`: A string representing the header of the section.
   - `listItem`: An array of `DSBottomSheetMenuListMultiSectionItem` objects representing the items in the section.
 
 - **Initializer**:
   ```swift
    public init(header: String, listItem: [DSBottomSheetMenuListMultiSectionItem] = [])
   ```
 
 ### DSBottomSheetMenuListMultiSectionItem
 - **Properties**:
   - `image`: An object of type `DSIcons` representing the image associated with the item.
   - `title`: A string representing the title of the item.
   - `description`: An optional string providing additional information about the item.

 - **Initializer**:
   ```swift
   public init(image: DSIcons, title: String, description: String? = nil)
   ```

 ## Parameters
 1. For `DSBottomSheetMenuListMultiSectionViewModel`:
    - `header`: The header text for the section.
    - `listItem`: An array of `DSBottomSheetMenuListMultiSectionItem` objects for the section's items.

 2. For `DSBottomSheetMenuListMultiSectionItem`:
    - `image`: The icon associated with the item.
    - `title`: The title of the item.
    - `description`: Additional description for the item (optional).
 */

public struct DSBottomSheetMenuListMultiSectionViewModel {
    var header: String
    var listItem: [DSBottomSheetMenuListMultiSectionItem] = []
    
    public init(
        header: String,
        listItem: [DSBottomSheetMenuListMultiSectionItem] = []
    ) {
        self.header = header
        self.listItem = listItem
    }
}

public struct DSBottomSheetMenuListMultiSectionItem {
    var image: DSIcons
    var title: String
    var description: String?
    
    public init(
        image: DSIcons,
        title: String,
        description: String? = nil
    ) {
        self.image = image
        self.title = title
        self.description = description
    }
}
