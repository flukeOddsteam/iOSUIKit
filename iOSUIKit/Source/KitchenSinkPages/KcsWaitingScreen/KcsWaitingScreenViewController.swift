//
//  KcsWaitingScreenViewController.swift
//  OneAppDesignSystem
//
//  Created by TTB on 15/2/2567 BE.
//

import UIKit
import OneAppDesignSystem

enum WaitingScreenMenu: Int, CaseIterable {
    case `default`
    case external2c2p
    case internal2c2p
    case ttbToThirdPartyExternalDefault
    case thirdPartyToTTBDefault

    var title: String {
        switch self {
        case .default:
            return "Default"
        case .external2c2p:
            return "ttb to 2c2p"
        case .internal2c2p:
            return "2c2p to ttb"
        case .ttbToThirdPartyExternalDefault:
            return "ttb to third party default"
        case .thirdPartyToTTBDefault:
            return "third party to ttb default"
        }
    }

    var mediaType: DSWaitingScreenViewModel.ScreenMediaType {
        switch self {
        case .default:
            let resource = DSLottie.lottieWaitingScreenInternalDefault.resource
            return .lottie(filename: resource.filename, bundle: resource.bundle)

        case .external2c2p:
            let resource = DSLottie.lottieWaitingScreenExternal2C2PtoTTB.resource
            return .lottie(filename: resource.filename, bundle: resource.bundle)

        case .internal2c2p:
            let resource = DSLottie.lottieWaitingScreenExternalTTBto2C2P.resource
            return .lottie(filename: resource.filename, bundle: resource.bundle)

        case .ttbToThirdPartyExternalDefault:
            let resource = DSLottie.lottieWaitingScreenExternalTTBtoThirdPartyDefault.resource
            return .lottie(filename: resource.filename, bundle: resource.bundle)

        case .thirdPartyToTTBDefault:
            let resource = DSLottie.lottieWaitingScreenExternalThirdPartyDefaultToTTB.resource
            return .lottie(filename: resource.filename, bundle: resource.bundle)
        }
    }

    var screenPhrase: DSWaitingScreenViewModel.ScreenPhrase {
        let defaultTitle = "โปรดอยู่ในหน้านี้\nจนกว่าจะทำรายการสำเร็จ"
        let defaultGhostButton = "กลับหน้าหลัก"
        switch self {
        case .default:
            return DSWaitingScreenViewModel.ScreenPhrase(
                title: defaultTitle,
                subtitle: "ระบบกำลังประมวลผลการอนุมัติสินเชื่อ อาจใช้เวลา 1-2 นาที",
                ghostButtonTitle: defaultGhostButton
            )
        case .external2c2p:
            return DSWaitingScreenViewModel.ScreenPhrase(
                title: defaultTitle,
                subtitle: "ระบบกำลังนำคุณไปหน้าชำระเงินผ่าน 2C2P",
                ghostButtonTitle: defaultGhostButton
            )
        case .internal2c2p:
            return DSWaitingScreenViewModel.ScreenPhrase(
                title: defaultTitle,
                subtitle: "ระบบกำลังตรวจสอบสถานะการชำระเงิน อาจใช้เวลา 1-2 นาที",
                ghostButtonTitle: defaultGhostButton
            )
        case .ttbToThirdPartyExternalDefault:
            return DSWaitingScreenViewModel.ScreenPhrase(
                title: defaultTitle,
                subtitle: "ระบบกำลังนำคุณไปหน้าชำระเงินผ่าน  {$Destination}",
                ghostButtonTitle: defaultGhostButton
            )
        case .thirdPartyToTTBDefault:
            return DSWaitingScreenViewModel.ScreenPhrase(
                title: defaultTitle,
                subtitle: "ระบบกำลังตรวจสอบสถานะการชำระเงิน อาจใช้เวลา 1-2 นาที",
                ghostButtonTitle: defaultGhostButton
            )
        }
    }
}

final class KcsWaitingScreenViewController: UIViewController {

    @IBOutlet weak var navBar: DSNavBar!
    @IBOutlet weak var listAction: DSListActionView!

    var entryPointMenu: KcsWaitingScreenEntryPointMenu = .internal
    var menus = WaitingScreenMenu.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupListAction()
    }

}

extension KcsWaitingScreenViewController: DSWaitingScreenDelegate {
    func waitingScreenDidClosed() {

    }

    func waitingScreenBottomSheetPrimaryButtonDidTapped() {

    }

    func waitingScreenBottomSheetGhostButtonDidTapped() {
        DSWaitingScreen.hide()
    }
}

// MARK: - ListActionViewDelegate
extension KcsWaitingScreenViewController: ListActionViewDelegate {
    func listActionView(_ view: DSListActionView, didSelectRowAt index: Int) {

        let expectedIndex = entryPointMenu == .internal ? index : index + 1
        let menu = menus[expectedIndex]

        let bottomSheetPhrase = DSWaitingScreenViewModel.BottomSheetPhrase(
            title: "ต้องการออกจากหน้านี้",
            description: "รายการที่คุณกำลังดำเนินการจะไม่เสร็จสมบูรณ์",
            primaryButtonTitle: "ทำรายการต่อ",
            ghostButtonTitle: "ออกจากหน้านี้"
        )

        let viewModel = DSWaitingScreenViewModel(
            screenPhrase: menu.screenPhrase,
            bottomSheetPhrase: bottomSheetPhrase,
            mediaType: menu.mediaType
        )

        DSWaitingScreen.show(viewModel: viewModel, delegate: self)
    }
}


// MARK: - DSNavBarDelegate
extension KcsWaitingScreenViewController: DSNavBarDelegate {
    func navBarBackButtonDidTapped(_ view: DSNavBar) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Private
private extension KcsWaitingScreenViewController {
    func setupNavigationBar() {
        navBar.setup(title: entryPointMenu.title, style: .backButtonOnly, theme: .light)
        navBar.delegate = self
    }

    func setupListAction() {

        let viewModels = menus.filter {
            return entryPointMenu == .internal ? $0 == .default: $0 != .default
        }.map {
            return ListActionIconViewModel(
                text: $0.title,
                rightIcon: DSIcons.icon24OutlineChevronRight
            )
        }

        listAction.setup(style: .listActionIcons(viewModels: viewModels))
        listAction.delegate = self
    }
}
