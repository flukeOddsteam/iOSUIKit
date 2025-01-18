//
//  PreviewFilePhrase.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/3/2567 BE.
//

import Foundation
// swiftlint:disable all
enum PreviewFilePhrase {
    case saveButton
    case shareButton
    case previewNavigationBarTitle
    case prefixHeaderFile
    case confirmButton
    case cancelButton
    case deleteFileBottomSheetTitle
    case deleteFileBottomSheetSubTitle
    case fileTypeBottomSheetTitle
    case fileTypeBottomSheetItemPDF
    case fileTypeBottomSheetItemPhoto
    case errorLoadingFullScreenTitle
    case errorLoadingFullScreenSubTitle
    case okButton
    case errorLoadingFileTitle
    case errorLoadingFileRetryButton
    case editFileNameNavigationBarTitle
    case editFileNameSaveButtonTitle
    case editFileNamePlaceholder
    case passwordDescriptionTitle
    case passwordTextFieldTitle
    case passwordBottomSheetTitle

    func localize(params: [String]? = nil) -> String {
        switch self {
        case .saveButton:
            return PreviewFilePhrase.value(th: "บันทึกไฟล์", en: "Save File")
        case .shareButton:
            return PreviewFilePhrase.value(th: "แชร์ไฟล์", en: "Share File")
        case .previewNavigationBarTitle:
            return PreviewFilePhrase.value(th: "เอกสาร", en: "Document")
        case .prefixHeaderFile:
            return PreviewFilePhrase.value(th: "ไฟล์", en: "File")
        case .confirmButton:
            return PreviewFilePhrase.value(th: "ยืนยัน", en: "Confirm")
        case .cancelButton:
            return PreviewFilePhrase.value(th: "ยกเลิก", en: "Cancel")
        case .deleteFileBottomSheetTitle:
            return PreviewFilePhrase.value(th: "ต้องการลบไฟล์", en: "Delete File")
        case .deleteFileBottomSheetSubTitle:
            return PreviewFilePhrase.value(th: "เอกสารของคุณจะถูกลบออกจาก ttb touch ถาวร", en: "File will be permanently deleted")
        case .fileTypeBottomSheetTitle:
            return PreviewFilePhrase.value(th: "ประเภทไฟล์", en: "File Type")
        case .fileTypeBottomSheetItemPDF:
            return PreviewFilePhrase.value(th: "PDF", en: "PDF")
        case .fileTypeBottomSheetItemPhoto:
            return PreviewFilePhrase.value(th: "รูปภาพ", en: "Photo")
        case .errorLoadingFullScreenTitle:
            return PreviewFilePhrase.value(th: "คุณทำรายการ เกินจำนวนครั้งที่กำหนด", en: "You Have Reached Limit of Attempts")
        case .errorLoadingFullScreenSubTitle:
            return PreviewFilePhrase.value(th: "โปรดลองใหม่อีกครั้งภายหลัง", en: "Please try again later.")
        case .okButton:
            return PreviewFilePhrase.value(th: "ตกลง", en: "OK")
        case .errorLoadingFileTitle:
            return PreviewFilePhrase.value(th: "ไม่สามารถแสดงเอกสารได้เนื่องจากการเชื่อมต่อขัดข้อง", en: "Document cannot be displayed due to connection error.")
        case .errorLoadingFileRetryButton:
            return PreviewFilePhrase.value(th: "ลองอีกครั้ง", en: "Try Again")
        case .editFileNameNavigationBarTitle:
            return PreviewFilePhrase.value(th: "แก้ไขชื่อไฟล์", en: "Edit File Name")
        case .editFileNameSaveButtonTitle:
            return PreviewFilePhrase.value(th: "บันทึก", en: "Save")
        case .editFileNamePlaceholder:
            return PreviewFilePhrase.value(th: "ชื่อไฟล์", en: "File name")
        case .passwordDescriptionTitle:
            return PreviewFilePhrase.value(th: "โปรดใส่รหัสผ่านเพื่อเปิดเอกสาร", en: "Please enter password to open document.")
        case .passwordTextFieldTitle:
            return PreviewFilePhrase.value(th: "รหัสผ่าน", en: "Password")
        case .passwordBottomSheetTitle:
            return PreviewFilePhrase.value(th: "เอกสารป้องกันด้วยรหัสผ่าน", en: "Password Protected Document")
        }
    }

    static func value<T>(th: T, en: T) -> T {
        switch DSLanguageManager.shared.currentLanguage {
        case .thai:
            return th
        case .english:
            return en
        }
    }
}
// swiftlint:enable all
