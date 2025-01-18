//
//  DSListExpandImageType.swift
//  OneAppDesignSystem
//
//  Created by TTB on 22/3/2566 BE.
//

import UIKit

public enum DSListExpandImageType {
    case icon(DSIcons?)
    case spot(DSIllusIcons?)
    case url(url: URL?, placeholder: UIImage?, cacheable: Bool)
}
