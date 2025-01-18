//
//  UIKitViewController.swift
//  ONE_oneapp-designsystem-ios-UIKit
//
//  Created by flukeInwza on 14/1/25.
//

import Foundation
import UIKit

class UIKitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let controller = KcsLandingViewController()
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(controller, animated: true)
    }
}

