//
//  DSIcons.swift
//  OneApp
//
//  Created by TTB on 5/9/2565 BE.
//  Copyright © 2565 BE TTB. All rights reserved.
//
import UIKit
// swiftlint:disable all
public enum DSIcons: String, CaseIterable {
    case icon16Alert
    case icon16BahtSign
    case icon16Bookbank
    case icon16Bookmark
    case icon16Bulb
    case icon16Calendar
    case icon16Camera
    case icon16Car
    case icon16Check
    case icon16CheckCircle
    case icon16ChevronDown
    case icon16ChevronLeft
    case icon16ChevronRight
    case icon16ChevronUp
    case icon16Close
    case icon16CloseCircle
    case icon16Copy
    case icon16CreditCard
    case icon16Edit
    case icon16Eye
    case icon16EyeOff
    case icon16File
    case icon16Filter
    case icon16Gift
    case icon16Globe
    case icon16Graph
    case icon16Heart
    case icon16Heart2
    case icon16Heart3
    case icon16Heart4
    case icon16Help
    case icon16Info
    case icon16Loan
    case icon16Location
    case icon16Lock
    case icon16LockOpen
    case icon16Mail
    case icon16Message
    case icon16Minus
    case icon16MinusCircle
    case icon16More
    case icon16Movie
    case icon16Percent
    case icon16Phone
    case icon16Pin
    case icon16PinCode
    case icon16PlaceHolder
    case icon16Plane
    case icon16PlusCircle
    case icon16Print
    case icon16Privilege
    case icon16ProductAssetInsurance
    case icon16ProductHealthInsurance
    case icon16ProductHouse
    case icon16ProductIllness
    case icon16ProductLifeInsurance
    case icon16ProductWealthInsurance
    case icon16ReceiptTax
    case icon16Records
    case icon16ReservedCard
    case icon16Save
    case icon16Search
    case icon16Share
    case icon16Shield
    case icon16ShieldCheck
    case icon16Star
    case icon16StarHalf
    case icon16ThumbDown
    case icon16ThumbUp
    case icon16Time
    case icon16Trash
    case icon16Upload
    case icon16User
    case icon16UserCircle
    case icon16InfoNoFill
    case icon16WarningNoFill
    case icon16CheckStepProgressBar
    case icon16Coupon
    case icon16Apply
    case icon16CheckSmall
    case icon16Notification
    case icon16OutlineDoubleDown
    case icon16Point
    case icon24ChevronLeft
    case icon24Close
    case icon24OutlineAccount
    case icon24OutlineAddressBook
    case icon24OutlineAlarm
    case icon24OutlineAlert
    case icon24OutlineApplicationTracking
    case icon24OutlineBackspace
    case icon24OutlineBahtSign
    case icon24OutlineBank
    case icon24OutlineBarcode
    case icon24OutlineBillStatement
    case icon24OutlineBiometricFaceId
    case icon24OutlineBiometricFingerprint
    case icon24OutlineBookbank
    case icon24OutlineBookmark
    case icon24OutlineCalculator
    case icon24OutlineCar
    case icon24OutlineCart
    case icon24OutlineCaseTracking
    case icon24OutlineCash
    case icon24OutlineCertificate
    case icon24OutlineChartBar
    case icon24OutlineChartPie
    case icon24OutlineCheck
    case icon24OutlineCheckCircle
    case icon24OutlineCheckSmall
    case icon24OutlineCheque
    case icon24OutlineChevronDown
    case icon24OutlineChevronLeft
    case icon24OutlineChevronRight
    case icon24OutlineChevronUp
    case icon24OutlineClose
    case icon24OutlineCloseCircle
    case icon24OutlineCopy
    case icon24OutlineCoupon
    case icon24OutlineCreditCard
    case icon24OutlineCustomerSupport
    case icon24OutlineDeposit
    case icon24OutlineDiscover
    case icon24OutlineDonation
    case icon24OutlineDownload
    case icon24OutlineDocuments
    case icon24OutlineEdit
    case icon24OutlineExchangeRate
    case icon24OutlineExternalLink
    case icon24OutlineEye
    case icon24OutlineFaceScan
    case icon24OutlineFileAnalytic
    case icon24OutlineFileCheck
    case icon24OutlineFileDownload
    case icon24OutlineFileReport
    case icon24OutlineFileUpload
    case icon24OutlineFileX
    case icon24OutlineFiles
    case icon24OutlineFilter
    case icon24OutlineFlash
    case icon24OutlineFlashOff
    case icon24OutlineGlobe
    case icon24OutlineGoodsAndServices
    case icon24OutlineGraph
    case icon24OutlineHealth
    case icon24OutlineHelp
    case icon24OutlineHistory
    case icon24OutlineHome
    case icon24OutlineHomeAppliances
    case icon24OutlineHospital
    case icon24OutlineIDCard
    case icon24OutlineIdCard
    case icon24OutlineInfo
    case icon24OutlineLanguage
    case icon24OutlineLimit
    case icon24OutlineLink
    case icon24OutlineLips
    case icon24OutlineLoan
    case icon24OutlineLocation
    case icon24OutlineLock
    case icon24OutlineLockOpen
    case icon24OutlineLogin
    case icon24OutlineLogout
    case icon24OutlineMail
    case icon24OutlineMailOpen
    case icon24OutlineMainMenuAccount
    case icon24OutlineMainMenuDiscover
    case icon24OutlineMainMenuHealth
    case icon24OutlineMainMenuHome
    case icon24OutlineMainMenuService
    case icon24OutlineMenu
    case icon24OutlineMessage
    case icon24OutlineMinus
    case icon24OutlineMinusCircle
    case icon24OutlineMobilePhone
    case icon24OutlineMore
    case icon24OutlineMoreVertical
    case icon24OutlineMotorcycle
    case icon24OutlineMovie
    case icon24OutlineMusic
    case icon24OutlineNcbReport
    case icon24OutlineNdid
    case icon24OutlineNews
    case icon24OutlineNoEyeglasses
    case icon24OutlineNote
    case icon24OutlineNotification
    case icon24OutlinePercent
    case icon24OutlinePhone
    case icon24OutlinePhoto
    case icon24OutlinePhotoCopy
    case icon24OutlinePig
    case icon24OutlinePin
    case icon24OutlinePlaceholder
    case icon24OutlinePlane
    case icon24OutlinePlayer
    case icon24OutlinePlus
    case icon24OutlinePlusCircle
    case icon24OutlinePrinter
    case icon24OutlinePrivilege
    case icon24OutlineProductAssetInsurance
    case icon24OutlineProductHealthInsurance
    case icon24OutlineProductLifeInsurance
    case icon24OutlineProductWealthInsurance
    case icon24OutlinePromptpay
    case icon24OutlineQRcode
    case icon24OutlineReceipt
    case icon24OutlineReceiptRefund
    case icon24OutlineReceiptTax
    case icon24OutlineRefresh
    case icon24OutlineReservedCard
    case icon24OutlineRewards
    case icon24OutlineSave
    case icon24OutlineScan
    case icon24OutlineSearch
    case icon24OutlineService
    case icon24OutlineSetting
    case icon24OutlineShareAndroid
    case icon24OutlineShareIOs
    case icon24OutlineShieldCheck
    case icon24OutlineShield
    case icon24OutlineShop
    case icon24OutlineSofa
    case icon24OutlineSort
    case icon24OutlineSpeakerphone
    case icon24OutlineStar
    case icon24OutlineStarHalf
    case icon24OutlineSunlight
    case icon24OutlineThumbDown
    case icon24OutlineThumbUp
    case icon24OutlineTime
    case icon24OutlineTrash
    case icon24OutlineUnlink
    case icon24OutlineUpgradeAccount
    case icon24OutlineUpload
    case icon24OutlineUser
    case icon24OutlineUserCircle
    case icon24OutlineUtensils
    case icon24OutlineUtility
    case icon24OutlineWifi
    case icon24OutlineWifiOff
    case icon24OutlineWowPoint
    case icon24Outlinebulb
    case icon24Outlinecalendar
    case icon24OutlineeyeOff
    case icon24Outlinefile
    case icon24Outlineheart
    case icon24OutlineBalanceLimit
    case icon24OutlineAdjustCredit
    case icon24OutlineTransfer
    case icon24OutlineInternationalTransfer
    case icon24OutlineGiftBox
    case icon24OutlineTagDivide
    case icon24OutlineTagCheck
    case icon24SolidBookmark
    case icon24SolidCloseCircle
    case icon24SolidHeart
    case icon24SolidPlaceholder
    case icon24SolidUser
    case icon24OutlineSmallBiz
    case icon24OutlineHomeLoan
    case icon24OutlineCamera
    case icon24OutlineATS
    case icon24OutlineBriefcase
    case icon24OutlineBuy
    case icon24OutlineCarLoan
    case icon24OutlineChild
    case icon24OutlineCreditPoint
    case icon24OutlineDepositDebit
    case icon24OutlineDisabledPerson
    case icon24OutlineHeartSparkling
    case icon24OutlineHurtPerson
    case icon24OutlineInProgress
    case icon24OutlineInsurer
    case icon24OutlineLabor
    case icon24OutlineLeaveGeneral
    case icon24OutlineLuck
    case icon24OutlineManageSchedule
    case icon24OutlineMarried
    case icon24OutlineMyFavorite
    case icon24OutlinePersonalLoan
    case icon24OutlinePregnant
    case icon24OutlineProtect
    case icon24OutlinePayroll
    case icon24OutlinePointExchange
    case icon24OutlineReactivateAccount
    case icon24OutlineSchedule
    case icon24OutlineSell
    case icon24OutlineSport
    case icon24OutlineSwitchfund
    case icon24OutlineUnitholder
    case icon24OutlinePayWithWow
    case icon24OutlineBuyHome
    case icon24OutlineHomeRefinance
    case icon24OutlineCashback
    case icon24OutlineMyAccountMenu
    case icon24OutlineServiceMenu
    case icon24OutlinePromotion
    case icon24OutlineDocumentEdit
    case icon24OutlineBackdateTimeEntry
    case icon24OutlineBasicAccount
    case icon24OutlineCloseBookBank
    case icon24OutlineContinueAccountOnTouch
    case icon24OutlineDreamSaving
    case icon24OutlineMeSAVE
    case icon24OutlineNCB
    case icon24OutlinePhotoOff
    case icon24OutlinePinCode
    case icon24OutlineReadMore
    case icon24OutlineTable
    case icon24OutlineALCarRegistration
    case icon24MustKnowDisableLock
    case icon24MustKnowDisableNotification
    case icon24MustKnowDisablePlaceholder
    case icon24MustKnowInformationApply
    case icon24MustKnowInformationBahtSign
    case icon24MustKnowInformationBookbank
    case icon24MustKnowInformationCreditCard
    case icon24MustKnowInformationEdit
    case icon24MustKnowInformationFile
    case icon24MustKnowInformationGift
    case icon24MustKnowInformationInfo
    case icon24MustKnowInformationLoan
    case icon24MustKnowInformationLocation
    case icon24MustKnowInformationMail
    case icon24MustKnowInformationMessage
    case icon24MustKnowInformationPlaceholder
    case icon24MustKnowInformationPrivilege
    case icon24MustKnowInformationProductHealthInsurance
    case icon24MustKnowInformationProductHouse
    case icon24MustKnowInformationProductLifeInsurance
    case icon24MustKnowInformationProductWealthInsurance
    case icon24MustKnowInformationReceiptTax
    case icon24MustKnowInformationReservedCard
    case icon24MustKnowInformationUser
    case icon24MustKnowInformativePercent
    case icon24MustKnowInformativeShieldCheck
    case icon24MustKnowSuccessCheck
    case icon24MustKnowSuccessPlaceholder
    case icon24MustKnowUrgentAlert2
    case icon24MustKnowUrgentClose
    case icon24MustKnowUrgentMail
    case icon24MustKnowUrgentPhone
    case icon24MustKnowUrgentPlaceholder
    case icon24MustKnowWarningAlert
    case icon24MustKnowWarningApply
    case icon24MustKnowWarningCalendar
    case icon24MustKnowWarningCar
    case icon24MustKnowWarningNotification
    case icon24MustKnowWarningPlaceholder
    case icon24MustKnowWarningReceiptTax
    case icon24MustKnowWarningTime
    case icon36ErrorAssetBlock
    case icon36ErrorBiometric
    case icon36ErrorByInput
    case icon36ErrorCircuitBreak
    case icon36ErrorConnectionFail
    case icon36ErrorConnectionLost
    case icon36ErrorDataMismatch
    case icon36ErrorDataNotFound
    case icon36ErrorDuplicateRequest
    case icon36ErrorExceedAmountMax
    case icon36ErrorExceededLimit
    case icon36ErrorFileFormatNotSupport
    case icon36ErrorGenericSystemError
    case icon36ErrorIncompleteFileUpload
    case icon36ErrorIncompleteInputText
    case icon36ErrorInform
    case icon36ErrorInsufficient
    case icon36ErrorLessThanMinAmount
    case icon36ErrorNonServiceHour
    case icon36ErrorNotConsent
    case icon36ErrorQualification
    case icon36ErrorRunBatch
    case icon36ErrorScheduleUnavailable
    case icon36ErrorServerDown
    case icon36ErrorSessionExpire
    case icon36ErrorSessionTimeout
    case icon36ErrorSystemMaintenance
    case icon36ErrorSystemTimeout
    case icon36HeroOutlineEditMF
    case icon36HeroOutlineHeroAddCoverage
    case icon36HeroOutlineHeroAdjustCreditLimit
    case icon36HeroOutlineHeroApply
    case icon36HeroOutlineHeroAvatarCircle
    case icon36HeroOutlineHeroBillPayment
    case icon36HeroOutlineHeroBookBank
    case icon36HeroOutlineHeroCalendarTime
    case icon36HeroOutlineHeroCar
    case icon36HeroOutlineHeroCard
    case icon36HeroOutlineHeroCardlessWithdraw
    case icon36HeroOutlineHeroCashback
    case icon36HeroOutlineHeroCloseBookBank
    case icon36HeroOutlineHeroConversation
    case icon36HeroOutlineHeroGift
    case icon36HeroOutlineHeroHistory
    case icon36HeroOutlineHeroHomeLoan
    case icon36HeroOutlineHeroInsuranceCareCard
    case icon36HeroOutlineHeroInvest
    case icon36HeroOutlineHeroLifeHealthInsurance
    case icon36HeroOutlineHeroLoan
    case icon36HeroOutlineHeroLockCard
    case icon36HeroOutlineHeroMathSymbols
    case icon36HeroOutlineHeroMore
    case icon36HeroOutlineHeroPinCode
    case icon36HeroOutlineHeroPointExchange
    case icon36HeroOutlineHeroPrivilege
    case icon36HeroOutlineHeroReceipt
    case icon36HeroOutlineHeroTransfer
    case icon36HeroOutlineHeroTransferRequest
    case icon36HeroOutlineHeroWelfare
    case icon36HeroOutlinePlaceholder
    case icon36HeroOutlineATS
    case icon36HeroOutlineHeroMenuDiscover
    case icon36HeroOutlineShoppingBags
    case icon36HeroOutlineHeroScan
    case icon36HeroOutlineHeroTopUp
    case icon36HeroOutlineApply
    case icon36HeroOutlineDocuments
    case icon36HeroOutlineAlert
    case icon36HeroOutlineDCA
    case icon36HeroOutlineFXAlert
    case icon36HeroOutlineHeroClaim
    case icon36HeroOutlineHeroEdit
    case icon36HeroOutlineHeroEditAccount
    case icon36HeroOutlineHeroEditAddress
    case icon36HeroOutlineHeroPolicyDelete
    case icon36HeroOutlineHeroReceiptTax
    case icon36HeroOutlineHeroSmallBiz
    case icon36HeroOutlineHeroStatement
    case icon36HeroOutlineHeroStopCheque
    case icon36HeroOutlineHeroStore
    case icon36HeroOutlineHeroTax
    case icon36HeroOutlineHeroTaxSavingFunds
    case icon36HeroOutlineSetting
    case icon36HeroOutlineSoGood
    case icon36HeroOutlineUnlockAccount
    case icon36HeroOutlineWowPoint
    case icon36HeroOutlineALBuyCar
    case icon36HeroOutlineALCarRegistration
    case icon36HeroOutlineALPayInstallment
    case icon36HeroOutlineALSellCar
    case icon36HeroOutlineALTaxLabel
    case icon36HeroOutlineALTransferForm
    case icon36HeroOutlinePromo
    case icon36OutlineAddCoverage
    case icon36OutlineAlert
    case icon36OutlineAvatar
    case icon36OutlineApply
    case icon36OutlineAvatarCircle
    case icon36OutlineBillPayment
    case icon36OutlineBiometricBackspace
    case icon36OutlineBiometricFaceId
    case icon36OutlineBiometricFingerprintAndroid
    case icon36OutlineBiometricTouchId
    case icon36OutlineBook
    case icon36OutlineCalendar
    case icon36OutlineCamera
    case icon36OutlineCarInsurance
    case icon36OutlineCardlessWithdraw
    case icon36OutlineCheckCircle
    case icon36OutlineCelebration
    case icon36OutlineConversation
    case icon36OutlineDocumentsError
    case icon36OutlineDownload
    case icon36OutlineEdit
    case icon36OutlineFamily
    case icon36OutlineFileDownload
    case icon36OutlineGift
    case icon36OutlineHeart
    case icon36OutlineHelp
    case icon36OutlineInfo
    case icon36OutlineInsuranceCareCard
    case icon36OutlineMathSymbols
    case icon36OutlineMenuAccounts
    case icon36OutlineMenuDiscover
    case icon36OutlineMenuHealth
    case icon36OutlineMenuHome
    case icon36OutlineMenuService
    case icon36OutlineMobilePhone
    case icon36OutlineMore
    case icon36OutlineNotification
    case icon36OutlineOnlineTransaction
    case icon36OutlineParents
    case icon36OutlinePhoto
    case icon36OutlinePlaceholder
    case icon36OutlinePlane
    case icon36OutlinePrivilege
    case icon36OutlineProductAllFree
    case icon36OutlineProductCar
    case icon36OutlineProductCurrentAccount
    case icon36OutlineProductFundByFund
    case icon36OutlineProductHomeLoan
    case icon36OutlineProductLifeHealthInsurance
    case icon36OutlineProductLoan
    case icon36OutlineProductNoFixed
    case icon36OutlineProductOtherInsurance
    case icon36OutlineProductSmallBiz
    case icon36OutlineProductSmartPort
    case icon36OutlineProductTermDeposit
    case icon36OutlineProductWelfare
    case icon36OutlineRefresh
    case icon36OutlineScan
    case icon36OutlineSearchCircle
    case icon36OutlineShareAndriod
    case icon36OutlineShareIOs
    case icon36OutlineStore
    case icon36OutlineTopUp
    case icon36OutlineTransfer
    case icon36OutlineWifi
    case icon36OutlineWifiOff
    case icon36OutlineWowPoint
    case icon36OutlineBackdatetimeentry
    case icon36OutlineAccidentCar
    case icon36OutlineAmbulance
    case icon36OutlineAngel
    case icon36OutlineArt
    case icon36OutlineAUD
    case icon36OutlineBasicAccount
    case icon36OutlineBTHPlus
    case icon36OutlineCAD
    case icon36OutlineCarAppraisal
    case icon36OutlineCarFix
    case icon36OutlineCart
    case icon36OutlineCashBackTTBTouch
    case icon36OutlineCheckHealth
    case icon36OutlineCHF
    case icon36OutlineCNY
    case icon36OutlineCreditCard
    case icon36OutlineDKK
    case icon36OutlineDocuments
    case icon36OutlineDreamSaving
    case icon36OutlineElectronicDamage
    case icon36OutlineEUR
    case icon36OutlineFileDownload2
    case icon36OutlineGBP
    case icon36OutlineHomeLoan
    case icon36OutlineHomeRefinance
    case icon36OutlineHomeAccident
    case icon36OutlineHurtPerson
    case icon36OutlineInProgress
    case icon36OutlineInsurer
    case icon36OutlineIPD
    case icon36OutlineJPY
    case icon36OutlineLatePlane
    case icon36OutlineLeaveGeneral
    case icon36OutlineLocation
    case icon36OutlineLuggage
    case icon36OutlineMeSAVE
    case icon36OutlineMovie
    case icon36OutlineOtherInsurance
    case icon36OutlinePolicy
    case icon36OutlinePregnant
    case icon36OutlineProductAssetInsurance
    case icon36OutlineProductHealthInsurance
    case icon36OutlineProductLifeInsurance
    case icon36OutlineProductSmartPort2
    case icon36OutlineProductWealthInsurance
    case icon36OutlineReactivateAccount
    case icon36OutlineSGD
    case icon36OutlineShield
    case icon36OutlineSocialMedia
    case icon36OutlineSport
    case icon36OutlineStoreCheck
    case icon36OutlineSunlight
    case icon36OutlineThief
    case icon36OutlineTravelInsurance
    case icon36OutlineUSD
    case icon36OutlineUtensils
    case icon36OutlineWashingMachine
    case icon36OutlineWrongPlane
    case icon36OutlineProductCurrentAccountAUD
    case icon36OutlineProductCurrentAccountCAD
    case icon36OutlineProductCurrentAccountCHF
    case icon36OutlineProductCurrentAccountCNY
    case icon36OutlineProductCurrentAccountDKK
    case icon36OutlineProductCurrentAccountEUR
    case icon36OutlineProductCurrentAccountFCD
    case icon36OutlineProductCurrentAccountGBP
    case icon36OutlineProductCurrentAccountJPY
    case icon36OutlineProductCurrentAccountSGD
    case icon36OutlineProductCurrentAccountUSD
    case icon36OutlineCreditPoint
    case icon48ConnectionLost
    case icon48GenericSystemError
    case icon48MRTAHomeLoanRefinance
    case icon48MRTAPersonalLoan
    case icon36OutlineProductSavingAccount
    case icon36OutlineProductCurrentMultiCurrency
    case icon36OutlineProductSavingAccountMultiCurrency
    case icon36OutlineProductSavingAccountFCD
    case icon36OutlineCheckNcb
    case icon36OutlineContinueAccountOnTouch
    case icon36OutlineSummaryInsurance
    case icon36OutlineSignDocument
    case icon36OutlineBTH
    case icon36OutlineTax
    case icon36OutlineDCA
    case icon36OutlineSendDocument
    case icon36MeSave
    case icon36BasicAccount
    case icon36DreamSaving
    case icon36OutlineSelectObj
    case icon36OutlineStructuredNote
    case icon36SolidAccountSumOverview
    case icon36OutlineDocumentEdit
    case icon36WarningBillPaymentBlock
    case icon36WarningCalendarBlock
    case icon36WarningCardlessWithdrawBlock
    case icon36WarningTopUpBlock
    case icon36WarningTransferBlock
    case icon48OfferingPlaceholder
    case icon48OfferingCarLoan
    case icon48OfferingCashYourCar
    case icon48OfferingHomeLoan
    case icon48OfferingCashYourHome
    case icon48OfferingPersonalLoan
    case icon48OfferingCreditCard
    case icon48OfferingHomeLoanRefinance
    case vector56NoDataPreviewFile
    case vector56NoMCA
    case vector56ProductODI
    case vector56Empty
    case vector56NoData
    case vector56NoProduct
    case vector56Maintenance
    case vector56DocumentProtected
    case vector240ConnectionIostByUser
    case vector240GenericSystemErrorInternal
    case iconDataMismatch03
    case illusDataMismatch02
    case icon36SuccessBranch
    case icon36SuccessIncome
    case icon36SuccessStatement
    case icon36SuccessWithdraw
    case icon36WarningExpenseBlock
    case icon24OutlineApply
    case icon24OutlineESlip
    case icon24OutlinePasscodeLock
    case icon24OutlinePasscode
    case icon24OutlineRestaurant
    case icon24OutlinePercentage
    case icon24OutlineTag
    case icon36OutlineCashback
    case icon36OutlineESlip
    case icon36OutlineExchangeRate
    case icon36OutlineRestaurant
    case icon36OutlineShop
    case icon36OutlineSmallBiz
    case icon36OutlineSoGood
    case icon36OutlineVirtualDebitCredit
    case icon36OutlineVirtualCreditCredit
    
    public var image: UIImage {
        switch self {
        case .icon16Alert: return SvgIcons.icon16Alert.image
        case .icon16BahtSign: return SvgIcons.icon16BahtSign.image
        case .icon16Bookbank: return SvgIcons.icon16Bookbank.image
        case .icon16Bookmark: return SvgIcons.icon16Bookmark.image
        case .icon16Bulb: return SvgIcons.icon16Bulb.image
        case .icon16Calendar: return SvgIcons.icon16Calendar.image
        case .icon16Camera: return SvgIcons.icon16Camera.image
        case .icon16Car: return SvgIcons.icon16Car.image
        case .icon16Check: return SvgIcons.icon16Check.image
        case .icon16CheckCircle: return SvgIcons.icon16CheckCircle.image
        case .icon16ChevronDown: return SvgIcons.icon16ChevronDown.image
        case .icon16ChevronLeft: return SvgIcons.icon16ChevronLeft.image
        case .icon16ChevronRight: return SvgIcons.icon16ChevronRight.image
        case .icon16ChevronUp: return SvgIcons.icon16ChevronUp.image
        case .icon16Close: return SvgIcons.icon16Close.image
        case .icon16CloseCircle: return SvgIcons.icon16CloseCircle.image
        case .icon16Copy: return SvgIcons.icon16Copy.image
        case .icon16CreditCard: return SvgIcons.icon16CreditCard.image
        case .icon16Edit: return SvgIcons.icon16Edit.image
        case .icon16Eye: return SvgIcons.icon16Eye.image
        case .icon16EyeOff: return SvgIcons.icon16EyeOff.image
        case .icon16File: return SvgIcons.icon16File.image
        case .icon16Filter: return SvgIcons.icon16Filter.image
        case .icon16Gift: return SvgIcons.icon16Gift.image
        case .icon16Globe: return SvgIcons.icon16Globe.image
        case .icon16Graph: return SvgIcons.icon16Graph.image
        case .icon16Heart: return SvgIcons.icon16Heart.image
        case .icon16Heart2: return SvgIcons.icon16Heart2.image
        case .icon16Heart3: return SvgIcons.icon16Heart3.image
        case .icon16Heart4: return SvgIcons.icon16Heart4.image
        case .icon16Help: return SvgIcons.icon16Help.image
        case .icon16Info: return SvgIcons.icon16Info.image
        case .icon16Loan: return SvgIcons.icon16Loan.image
        case .icon16Location: return SvgIcons.icon16Location.image
        case .icon16Lock: return SvgIcons.icon16Lock.image
        case .icon16LockOpen: return SvgIcons.icon16LockOpen.image
        case .icon16Mail: return SvgIcons.icon16Mail.image
        case .icon16Message: return SvgIcons.icon16Message.image
        case .icon16Minus: return SvgIcons.icon16Minus.image
        case .icon16MinusCircle: return SvgIcons.icon16MinusCircle.image
        case .icon16More: return SvgIcons.icon16More.image
        case .icon16Movie: return SvgIcons.icon16Movie.image
        case .icon16Percent: return SvgIcons.icon16Percent.image
        case .icon16Phone: return SvgIcons.icon16Phone.image
        case .icon16Pin: return SvgIcons.icon16Pin.image
        case .icon16PinCode: return SvgIcons.icon16PinCode.image
        case .icon16PlaceHolder: return SvgIcons.icon16PlaceHolder.image
        case .icon16Plane: return SvgIcons.icon16Plane.image
        case .icon16PlusCircle: return SvgIcons.icon16PlusCircle.image
        case .icon16Print: return SvgIcons.icon16Print.image
        case .icon16Privilege: return SvgIcons.icon16Privilege.image
        case .icon16ProductAssetInsurance: return SvgIcons.icon16ProductAssetInsurance.image
        case .icon16ProductHealthInsurance: return SvgIcons.icon16ProductHealthInsurance.image
        case .icon16ProductHouse: return SvgIcons.icon16ProductHouse.image
        case .icon16ProductIllness: return SvgIcons.icon16ProductIllness.image
        case .icon16ProductLifeInsurance: return SvgIcons.icon16ProductLifeInsurance.image
        case .icon16ProductWealthInsurance: return SvgIcons.icon16ProductWealthInsurance.image
        case .icon16ReceiptTax: return SvgIcons.icon16ReceiptTax.image
        case .icon16Records: return SvgIcons.icon16Records.image
        case .icon16ReservedCard: return SvgIcons.icon16ReservedCard.image
        case .icon16Save: return SvgIcons.icon16Save.image
        case .icon16Search: return SvgIcons.icon16Search.image
        case .icon16Share: return SvgIcons.icon16Share.image
        case .icon16Shield: return SvgIcons.icon16Shield.image
        case .icon16ShieldCheck: return SvgIcons.icon16ShieldCheck.image
        case .icon16Star: return SvgIcons.icon16Star.image
        case .icon16StarHalf: return SvgIcons.icon16StarHalf.image
        case .icon16ThumbDown: return SvgIcons.icon16ThumbDown.image
        case .icon16ThumbUp: return SvgIcons.icon16ThumbUp.image
        case .icon16Time: return SvgIcons.icon16Time.image
        case .icon16Trash: return SvgIcons.icon16Trash.image
        case .icon16Upload: return SvgIcons.icon16Upload.image
        case .icon16User: return SvgIcons.icon16User.image
        case .icon16UserCircle: return SvgIcons.icon16UserCircle.image
        case .icon16InfoNoFill: return SvgIcons.icon16InfoNoFill.image
        case .icon16WarningNoFill: return SvgIcons.icon16WarningNoFill.image
        case .icon16CheckStepProgressBar: return SvgIcons.icon16CheckStepProgressBar.image
        case .icon16Coupon: return SvgIcons.icon16Coupon.image
        case .icon16Apply: return SvgIcons.icon16Apply.image
        case .icon16CheckSmall: return SvgIcons.icon16CheckSmall.image
        case .icon16Notification: return SvgIcons.icon16Notification.image
        case .icon16Point: return SvgIcons.icon16Point.image
        case .icon16OutlineDoubleDown: return SvgIcons.icon16OutlineDoubleDown.image
        case .icon24ChevronLeft: return SvgIcons.icon24ChevronLeft.image
        case .icon24Close: return SvgIcons.icon24Close.image
        case .icon24OutlineAccount: return SvgIcons.icon24OutlineAccount.image
        case .icon24OutlineAddressBook: return SvgIcons.icon24OutlineAddressBook.image
        case .icon24OutlineAlarm: return SvgIcons.icon24OutlineAlarm.image
        case .icon24OutlineAlert: return SvgIcons.icon24OutlineAlert.image
        case .icon24OutlineApplicationTracking: return SvgIcons.icon24OutlineApplicationTracking.image
        case .icon24OutlineBackspace: return SvgIcons.icon24OutlineBackspace.image
        case .icon24OutlineBahtSign: return SvgIcons.icon24OutlineBahtSign.image
        case .icon24OutlineBank: return SvgIcons.icon24OutlineBank.image
        case .icon24OutlineBarcode: return SvgIcons.icon24OutlineBarcode.image
        case .icon24OutlineBillStatement: return SvgIcons.icon24OutlineBillStatement.image
        case .icon24OutlineBiometricFaceId: return SvgIcons.icon24OutlineBiometricFaceId.image
        case .icon24OutlineBiometricFingerprint: return SvgIcons.icon24OutlineBiometricFingerprint.image
        case .icon24OutlineBookbank: return SvgIcons.icon24OutlineBookbank.image
        case .icon24OutlineBookmark: return SvgIcons.icon24OutlineBookmark.image
        case .icon24OutlineCalculator: return SvgIcons.icon24OutlineCalculator.image
        case .icon24OutlineCar: return SvgIcons.icon24OutlineCar.image
        case .icon24OutlineCart: return SvgIcons.icon24OutlineCart.image
        case .icon24OutlineCaseTracking: return SvgIcons.icon24OutlineCaseTracking.image
        case .icon24OutlineCash: return SvgIcons.icon24OutlineCash.image
        case .icon24OutlineCertificate: return SvgIcons.icon24OutlineCertificate.image
        case .icon24OutlineChartBar: return SvgIcons.icon24OutlineChartBar.image
        case .icon24OutlineChartPie: return SvgIcons.icon24OutlineChartPie.image
        case .icon24OutlineCheck: return SvgIcons.icon24OutlineCheck.image
        case .icon24OutlineCheckCircle: return SvgIcons.icon24OutlineCheckCircle.image
        case .icon24OutlineCheckSmall: return SvgIcons.icon24OutlineCheckSmall.image
        case .icon24OutlineCheque: return SvgIcons.icon24OutlineCheque.image
        case .icon24OutlineChevronDown: return SvgIcons.icon24OutlineChevronDown.image
        case .icon24OutlineChevronLeft: return SvgIcons.icon24OutlineChevronLeft.image
        case .icon24OutlineChevronRight: return SvgIcons.icon24OutlineChevronRight.image
        case .icon24OutlineChevronUp: return SvgIcons.icon24OutlineChevronUp.image
        case .icon24OutlineClose: return SvgIcons.icon24OutlineClose.image
        case .icon24OutlineCloseCircle: return SvgIcons.icon24OutlineCloseCircle.image
        case .icon24OutlineCopy: return SvgIcons.icon24OutlineCopy.image
        case .icon24OutlineCoupon: return SvgIcons.icon24OutlineCoupon.image
        case .icon24OutlineCreditCard: return SvgIcons.icon24OutlineCreditCard.image
        case .icon24OutlineCustomerSupport: return SvgIcons.icon24OutlineCustomerSupport.image
        case .icon24OutlineDeposit: return SvgIcons.icon24OutlineDeposit.image
        case .icon24OutlineDiscover: return SvgIcons.icon24OutlineDiscover.image
        case .icon24OutlineDonation: return SvgIcons.icon24OutlineDonation.image
        case .icon24OutlineDownload: return SvgIcons.icon24OutlineDownload.image
        case .icon24OutlineDocuments: return SvgIcons.icon24OutlineDocuments.image
        case .icon24OutlineEdit: return SvgIcons.icon24OutlineEdit.image
        case .icon24OutlineExchangeRate: return SvgIcons.icon24OutlineExchangeRate.image
        case .icon24OutlineExternalLink: return SvgIcons.icon24OutlineExternalLink.image
        case .icon24OutlineEye: return SvgIcons.icon24OutlineEye.image
        case .icon24OutlineFaceScan: return SvgIcons.icon24OutlineFaceScan.image
        case .icon24OutlineFileAnalytic: return SvgIcons.icon24OutlineFileAnalytic.image
        case .icon24OutlineFileCheck: return SvgIcons.icon24OutlineFileCheck.image
        case .icon24OutlineFileDownload: return SvgIcons.icon24OutlineFileDownload.image
        case .icon24OutlineFileReport: return SvgIcons.icon24OutlineFileReport.image
        case .icon24OutlineFileUpload: return SvgIcons.icon24OutlineFileUpload.image
        case .icon24OutlineFileX: return SvgIcons.icon24OutlineFileX.image
        case .icon24OutlineFiles: return SvgIcons.icon24OutlineFiles.image
        case .icon24OutlineFilter: return SvgIcons.icon24OutlineFilter.image
        case .icon24OutlineFlash: return SvgIcons.icon24OutlineFlash.image
        case .icon24OutlineFlashOff: return SvgIcons.icon24OutlineFlashOff.image
        case .icon24OutlineGlobe: return SvgIcons.icon24OutlineGlobe.image
        case .icon24OutlineGoodsAndServices: return SvgIcons.icon24OutlineGoodsAndServices.image
        case .icon24OutlineGraph: return SvgIcons.icon24OutlineGraph.image
        case .icon24OutlineHealth: return SvgIcons.icon24OutlineHealth.image
        case .icon24OutlineHelp: return SvgIcons.icon24OutlineHelp.image
        case .icon24OutlineHistory: return SvgIcons.icon24OutlineHistory.image
        case .icon24OutlineHome: return SvgIcons.icon24OutlineHome.image
        case .icon24OutlineHomeAppliances: return SvgIcons.icon24OutlineHomeAppliances.image
        case .icon24OutlineHospital: return SvgIcons.icon24OutlineHospital.image
        case .icon24OutlineIDCard: return SvgIcons.icon24OutlineIDCard.image
        case .icon24OutlineIdCard: return SvgIcons.icon24OutlineIdCard.image
        case .icon24OutlineInfo: return SvgIcons.icon24OutlineInfo.image
        case .icon24OutlineLanguage: return SvgIcons.icon24OutlineLanguage.image
        case .icon24OutlineLimit: return SvgIcons.icon24OutlineLimit.image
        case .icon24OutlineLink: return SvgIcons.icon24OutlineLink.image
        case .icon24OutlineLips: return SvgIcons.icon24OutlineLips.image
        case .icon24OutlineLoan: return SvgIcons.icon24OutlineLoan.image
        case .icon24OutlineLocation: return SvgIcons.icon24OutlineLocation.image
        case .icon24OutlineLock: return SvgIcons.icon24OutlineLock.image
        case .icon24OutlineLockOpen: return SvgIcons.icon24OutlineLockOpen.image
        case .icon24OutlineLogin: return SvgIcons.icon24OutlineLogin.image
        case .icon24OutlineLogout: return SvgIcons.icon24OutlineLogout.image
        case .icon24OutlineMail: return SvgIcons.icon24OutlineMail.image
        case .icon24OutlineMailOpen: return SvgIcons.icon24OutlineMailOpen.image
        case .icon24OutlineMainMenuAccount: return SvgIcons.icon24OutlineMainMenuAccount.image
        case .icon24OutlineMainMenuDiscover: return SvgIcons.icon24OutlineMainMenuDiscover.image
        case .icon24OutlineMainMenuHealth: return SvgIcons.icon24OutlineMainMenuHealth.image
        case .icon24OutlineMainMenuHome: return SvgIcons.icon24OutlineMainMenuHome.image
        case .icon24OutlineMainMenuService: return SvgIcons.icon24OutlineMainMenuService.image
        case .icon24OutlineMenu: return SvgIcons.icon24OutlineMenu.image
        case .icon24OutlineMessage: return SvgIcons.icon24OutlineMessage.image
        case .icon24OutlineMinus: return SvgIcons.icon24OutlineMinus.image
        case .icon24OutlineMinusCircle: return SvgIcons.icon24OutlineMinusCircle.image
        case .icon24OutlineMobilePhone: return SvgIcons.icon24OutlineMobilePhone.image
        case .icon24OutlineMore: return SvgIcons.icon24OutlineMore.image
        case .icon24OutlineMoreVertical: return SvgIcons.icon24OutlineMoreVertical.image
        case .icon24OutlineMotorcycle: return SvgIcons.icon24OutlineMotorcycle.image
        case .icon24OutlineMovie: return SvgIcons.icon24OutlineMovie.image
        case .icon24OutlineMusic: return SvgIcons.icon24OutlineMusic.image
        case .icon24OutlineNcbReport: return SvgIcons.icon24OutlineNcbReport.image
        case .icon24OutlineNdid: return SvgIcons.icon24OutlineNdid.image
        case .icon24OutlineNews: return SvgIcons.icon24OutlineNews.image
        case .icon24OutlineNoEyeglasses: return SvgIcons.icon24OutlineNoEyeglasses.image
        case .icon24OutlineNote: return SvgIcons.icon24OutlineNote.image
        case .icon24OutlineNotification: return SvgIcons.icon24OutlineNotification.image
        case .icon24OutlinePercent: return SvgIcons.icon24OutlinePercent.image
        case .icon24OutlinePhone: return SvgIcons.icon24OutlinePhone.image
        case .icon24OutlinePhoto: return SvgIcons.icon24OutlinePhoto.image
        case .icon24OutlinePhotoCopy: return SvgIcons.icon24OutlinePhotoCopy.image
        case .icon24OutlinePig: return SvgIcons.icon24OutlinePig.image
        case .icon24OutlinePin: return SvgIcons.icon24OutlinePin.image
        case .icon24OutlinePlaceholder: return SvgIcons.icon24OutlinePlaceholder.image
        case .icon24OutlinePlane: return SvgIcons.icon24OutlinePlane.image
        case .icon24OutlinePlayer: return SvgIcons.icon24OutlinePlayer.image
        case .icon24OutlinePlus: return SvgIcons.icon24OutlinePlus.image
        case .icon24OutlinePlusCircle: return SvgIcons.icon24OutlinePlusCircle.image
        case .icon24OutlinePrinter: return SvgIcons.icon24OutlinePrinter.image
        case .icon24OutlinePrivilege: return SvgIcons.icon24OutlinePrivilege.image
        case .icon24OutlineProductAssetInsurance: return SvgIcons.icon24OutlineProductAssetInsurance.image
        case .icon24OutlineProductHealthInsurance: return SvgIcons.icon24OutlineProductHealthInsurance.image
        case .icon24OutlineProductLifeInsurance: return SvgIcons.icon24OutlineProductLifeInsurance.image
        case .icon24OutlineProductWealthInsurance: return SvgIcons.icon24OutlineProductWealthInsurance.image
        case .icon24OutlinePromptpay: return SvgIcons.icon24OutlinePromptpay.image
        case .icon24OutlinePayroll: return SvgIcons.icon24OutlinePayroll.image
        case .icon24OutlinePointExchange: return SvgIcons.icon24OutlinePointExchange.image
        case .icon24OutlineQRcode: return SvgIcons.icon24OutlineQRcode.image
        case .icon24OutlineReceipt: return SvgIcons.icon24OutlineReceipt.image
        case .icon24OutlineReceiptRefund: return SvgIcons.icon24OutlineReceiptRefund.image
        case .icon24OutlineReceiptTax: return SvgIcons.icon24OutlineReceiptTax.image
        case .icon24OutlineRefresh: return SvgIcons.icon24OutlineRefresh.image
        case .icon24OutlineReservedCard: return SvgIcons.icon24OutlineReservedCard.image
        case .icon24OutlineRewards: return SvgIcons.icon24OutlineRewards.image
        case .icon24OutlineSave: return SvgIcons.icon24OutlineSave.image
        case .icon24OutlineScan: return SvgIcons.icon24OutlineScan.image
        case .icon24OutlineSearch: return SvgIcons.icon24OutlineSearch.image
        case .icon24OutlineService: return SvgIcons.icon24OutlineService.image
        case .icon24OutlineSetting: return SvgIcons.icon24OutlineSetting.image
        case .icon24OutlineShareAndroid: return SvgIcons.icon24OutlineShareAndroid.image
        case .icon24OutlineShareIOs: return SvgIcons.icon24OutlineShareIOs.image
        case .icon24OutlineShieldCheck: return SvgIcons.icon24OutlineShieldCheck.image
        case .icon24OutlineShield: return SvgIcons.icon24OutlineShield.image
        case .icon24OutlineShop: return SvgIcons.icon24OutlineShop.image
        case .icon24OutlineSofa: return SvgIcons.icon24OutlineSofa.image
        case .icon24OutlineSort: return SvgIcons.icon24OutlineSort.image
        case .icon24OutlineSpeakerphone: return SvgIcons.icon24OutlineSpeakerphone.image
        case .icon24OutlineStar: return SvgIcons.icon24OutlineStar.image
        case .icon24OutlineStarHalf: return SvgIcons.icon24OutlineStarHalf.image
        case .icon24OutlineSunlight: return SvgIcons.icon24OutlineSunlight.image
        case .icon24OutlineThumbDown: return SvgIcons.icon24OutlineThumbDown.image
        case .icon24OutlineThumbUp: return SvgIcons.icon24OutlineThumbUp.image
        case .icon24OutlineTime: return SvgIcons.icon24OutlineTime.image
        case .icon24OutlineTrash: return SvgIcons.icon24OutlineTrash.image
        case .icon24OutlineUnlink: return SvgIcons.icon24OutlineUnlink.image
        case .icon24OutlineUpgradeAccount: return SvgIcons.icon24OutlineUpgradeAccount.image
        case .icon24OutlineUpload: return SvgIcons.icon24OutlineUpload.image
        case .icon24OutlineUser: return SvgIcons.icon24OutlineUser.image
        case .icon24OutlineUserCircle: return SvgIcons.icon24OutlineUserCircle.image
        case .icon24OutlineUtensils: return SvgIcons.icon24OutlineUtensils.image
        case .icon24OutlineUtility: return SvgIcons.icon24OutlineUtility.image
        case .icon24OutlineWifi: return SvgIcons.icon24OutlineWifi.image
        case .icon24OutlineWifiOff: return SvgIcons.icon24OutlineWifiOff.image
        case .icon24OutlineWowPoint: return SvgIcons.icon24OutlineWowPoint.image
        case .icon24Outlinebulb: return SvgIcons.icon24Outlinebulb.image
        case .icon24Outlinecalendar: return SvgIcons.icon24Outlinecalendar.image
        case .icon24OutlineeyeOff: return SvgIcons.icon24OutlineeyeOff.image
        case .icon24Outlinefile: return SvgIcons.icon24Outlinefile.image
        case .icon24Outlineheart: return SvgIcons.icon24Outlineheart.image
        case .icon24SolidBookmark: return SvgIcons.icon24SolidBookmark.image
        case .icon24SolidCloseCircle: return SvgIcons.icon24SolidCloseCircle.image
        case .icon24SolidHeart: return SvgIcons.icon24SolidHeart.image
        case .icon24SolidPlaceholder: return SvgIcons.icon24SolidPlaceholder.image
        case .icon24SolidUser: return SvgIcons.icon24SolidUser.image
        case .icon24OutlineSmallBiz: return SvgIcons.icon24OutlineSmallBiz.image
        case .icon24OutlineHomeLoan: return SvgIcons.icon24OutlineHomeLoan.image
        case .icon24OutlineCamera: return SvgIcons.icon24OutlineCamera.image
        case .icon24OutlineATS: return SvgIcons.icon24OutlineATS.image
        case .icon24OutlineBriefcase: return SvgIcons.icon24OutlineBriefcase.image
        case .icon24OutlineBuy: return SvgIcons.icon24OutlineBuy.image
        case .icon24OutlineCarLoan: return SvgIcons.icon24OutlineCarLoan.image
        case .icon24OutlineChild: return SvgIcons.icon24OutlineChild.image
        case .icon24OutlineCreditPoint: return SvgIcons.icon24OutlineCreditPoint.image
        case .icon24OutlineDepositDebit: return SvgIcons.icon24OutlineDepositDebit.image
        case .icon24OutlineDisabledPerson: return SvgIcons.icon24OutlineDisabledPerson.image
        case .icon24OutlineHeartSparkling: return SvgIcons.icon24OutlineHeartSparkling.image
        case .icon24OutlineHurtPerson: return SvgIcons.icon24OutlineHurtPerson.image
        case .icon24OutlineInProgress: return SvgIcons.icon24OutlineInProgress.image
        case .icon24OutlineInsurer: return SvgIcons.icon24OutlineInsurer.image
        case .icon24OutlineLabor: return SvgIcons.icon24OutlineLabor.image
        case .icon24OutlineLeaveGeneral: return SvgIcons.icon24OutlineLeaveGeneral.image
        case .icon24OutlineLuck: return SvgIcons.icon24OutlineLuck.image
        case .icon24OutlineManageSchedule: return SvgIcons.icon24OutlineManageSchedule.image
        case .icon24OutlineMarried: return SvgIcons.icon24OutlineMarried.image
        case .icon24OutlineMyFavorite: return SvgIcons.icon24OutlineMyFavorite.image
        case .icon24OutlinePersonalLoan: return SvgIcons.icon24OutlinePersonalLoan.image
        case .icon24OutlinePregnant: return SvgIcons.icon24OutlinePregnant.image
        case .icon24OutlineProtect: return SvgIcons.icon24OutlineProtect.image
        case .icon24OutlineReactivateAccount: return SvgIcons.icon24OutlineReactivateAccount.image
        case .icon24OutlineSchedule: return SvgIcons.icon24OutlineSchedule.image
        case .icon24OutlineSell: return SvgIcons.icon24OutlineSell.image
        case .icon24OutlineSport: return SvgIcons.icon24OutlineSport.image
        case .icon24OutlineSwitchfund: return SvgIcons.icon24OutlineSwitchfund.image
        case .icon24OutlineUnitholder: return SvgIcons.icon24OutlineUnitholder.image
        case .icon24OutlineBalanceLimit: return SvgIcons.icon24OutlineBalanceLimit.image
        case .icon24OutlineAdjustCredit: return SvgIcons.icon24OutlineAdjustCredit.image
        case .icon24OutlineTransfer: return SvgIcons.icon24OutlineTransfer.image
        case .icon24OutlineInternationalTransfer: return SvgIcons.icon24OutlineInternationalTransfer.image
        case .icon24OutlinePayWithWow: return SvgIcons.icon24OutlinePayWithWow.image
        case .icon24OutlineBuyHome: return SvgIcons.icon24OutlineBuyHome.image
        case .icon24OutlineHomeRefinance: return SvgIcons.icon24OutlineHomeRefinance.image
        case .icon24OutlineCashback: return SvgIcons.icon24OutlineCashback.image
        case .icon24OutlineMyAccountMenu: return SvgIcons.icon24OutlineMyAccountMenu.image
        case .icon24OutlineServiceMenu: return SvgIcons.icon24OutlineServiceMenu.image
        case .icon24OutlinePromotion: return SvgIcons.icon24OutlinePromotion.image
        case .icon24OutlineDocumentEdit: return SvgIcons.icon24OutlineDocumentEdit.image
        case .icon24OutlineGiftBox: return SvgIcons.icon24OutlineGiftBox.image
        case .icon24OutlineTagDivide: return SvgIcons.icon24OutlineTagDivide.image
        case .icon24OutlineTagCheck: return SvgIcons.icon24OutlineTagCheck.image
        case .icon24OutlineBackdateTimeEntry: return SvgIcons.icon24OutlineBackdateTimeEntry.image
        case .icon24OutlineBasicAccount: return SvgIcons.icon24OutlineBasicAccount.image
        case .icon24OutlineCloseBookBank: return SvgIcons.icon24OutlineCloseBookBank.image
        case .icon24OutlineContinueAccountOnTouch: return SvgIcons.icon24OutlineContinueAccountOnTouch.image
        case .icon24OutlineDreamSaving: return SvgIcons.icon24OutlineDreamSaving.image
        case .icon24OutlineMeSAVE: return SvgIcons.icon24OutlineMeSAVE.image
        case .icon24OutlineNCB: return SvgIcons.icon24OutlineNCB.image
        case .icon24OutlinePhotoOff: return SvgIcons.icon24OutlinePhotoOff.image
        case .icon24OutlinePinCode: return SvgIcons.icon24OutlinePinCode.image
        case .icon24OutlineReadMore: return SvgIcons.icon24OutlineReadMore.image
        case .icon24OutlineTable: return SvgIcons.icon24OutlineTable.image
        case .icon24OutlineALCarRegistration: return SvgIcons.icon24OutlineALCarRegistration.image
        case .icon24MustKnowDisableLock: return SvgIcons.icon24MustKnowDisableLock.image
        case .icon24MustKnowDisableNotification: return SvgIcons.icon24MustKnowDisableNotification.image
        case .icon24MustKnowDisablePlaceholder: return SvgIcons.icon24MustKnowDisablePlaceholder.image
        case .icon24MustKnowInformationApply: return SvgIcons.icon24MustKnowInformationApply.image
        case .icon24MustKnowInformationBahtSign: return SvgIcons.icon24MustKnowInformationBahtSign.image
        case .icon24MustKnowInformationBookbank: return SvgIcons.icon24MustKnowInformationBookbank.image
        case .icon24MustKnowInformationCreditCard: return SvgIcons.icon24MustKnowInformationCreditCard.image
        case .icon24MustKnowInformationEdit: return SvgIcons.icon24MustKnowInformationEdit.image
        case .icon24MustKnowInformationFile: return SvgIcons.icon24MustKnowInformationFile.image
        case .icon24MustKnowInformationGift: return SvgIcons.icon24MustKnowInformationGift.image
        case .icon24MustKnowInformationInfo: return SvgIcons.icon24MustKnowInformationInfo.image
        case .icon24MustKnowInformationLoan: return SvgIcons.icon24MustKnowInformationLoan.image
        case .icon24MustKnowInformationLocation: return SvgIcons.icon24MustKnowInformationLocation.image
        case .icon24MustKnowInformationMail: return SvgIcons.icon24MustKnowInformationMail.image
        case .icon24MustKnowInformationMessage: return SvgIcons.icon24MustKnowInformationMessage.image
        case .icon24MustKnowInformationPlaceholder: return SvgIcons.icon24MustKnowInformationPlaceholder.image
        case .icon24MustKnowInformationPrivilege: return SvgIcons.icon24MustKnowInformationPrivilege.image
        case .icon24MustKnowInformationProductHealthInsurance: return SvgIcons.icon24MustKnowInformationProductHealthInsurance.image
        case .icon24MustKnowInformationProductHouse: return SvgIcons.icon24MustKnowInformationProductHouse.image
        case .icon24MustKnowInformationProductLifeInsurance: return SvgIcons.icon24MustKnowInformationProductLifeInsurance.image
        case .icon24MustKnowInformationProductWealthInsurance: return SvgIcons.icon24MustKnowInformationProductWealthInsurance.image
        case .icon24MustKnowInformationReceiptTax: return SvgIcons.icon24MustKnowInformationReceiptTax.image
        case .icon24MustKnowInformationReservedCard: return SvgIcons.icon24MustKnowInformationReservedCard.image
        case .icon24MustKnowInformationUser: return SvgIcons.icon24MustKnowInformationUser.image
        case .icon24MustKnowInformativePercent: return SvgIcons.icon24MustKnowInformativePercent.image
        case .icon24MustKnowInformativeShieldCheck: return SvgIcons.icon24MustKnowInformativeShieldCheck.image
        case .icon24MustKnowSuccessCheck: return SvgIcons.icon24MustKnowSuccessCheck.image
        case .icon24MustKnowSuccessPlaceholder: return SvgIcons.icon24MustKnowSuccessPlaceholder.image
        case .icon24MustKnowUrgentAlert2: return SvgIcons.icon24MustKnowUrgentAlert2.image
        case .icon24MustKnowUrgentClose: return SvgIcons.icon24MustKnowUrgentClose.image
        case .icon24MustKnowUrgentMail: return SvgIcons.icon24MustKnowUrgentMail.image
        case .icon24MustKnowUrgentPhone: return SvgIcons.icon24MustKnowUrgentPhone.image
        case .icon24MustKnowUrgentPlaceholder: return SvgIcons.icon24MustKnowUrgentPlaceholder.image
        case .icon24MustKnowWarningAlert: return SvgIcons.icon24MustKnowWarningAlert.image
        case .icon24MustKnowWarningApply: return SvgIcons.icon24MustKnowWarningApply.image
        case .icon24MustKnowWarningCalendar: return SvgIcons.icon24MustKnowWarningCalendar.image
        case .icon24MustKnowWarningCar: return SvgIcons.icon24MustKnowWarningCar.image
        case .icon24MustKnowWarningNotification: return SvgIcons.icon24MustKnowWarningNotification.image
        case .icon24MustKnowWarningPlaceholder: return SvgIcons.icon24MustKnowWarningPlaceholder.image
        case .icon24MustKnowWarningReceiptTax: return SvgIcons.icon24MustKnowWarningReceiptTax.image
        case .icon24MustKnowWarningTime: return SvgIcons.icon24MustKnowWarningTime.image
        case .icon36HeroOutlineEditMF: return
            SvgIcons.icon36HeroOutlineEditMF.image
        case .icon36HeroOutlineHeroAddCoverage: return SvgIcons.icon36HeroOutlineHeroAddCoverage.image
        case .icon36HeroOutlineHeroAdjustCreditLimit: return SvgIcons.icon36HeroOutlineHeroAdjustCreditLimit.image
        case .icon36HeroOutlineHeroApply: return SvgIcons.icon36HeroOutlineHeroApply.image
        case .icon36HeroOutlineHeroAvatarCircle: return SvgIcons.icon36HeroOutlineHeroAvatarCircle.image
        case .icon36HeroOutlineHeroBillPayment: return SvgIcons.icon36HeroOutlineHeroBillPayment.image
        case .icon36HeroOutlineHeroBookBank: return SvgIcons.icon36HeroOutlineHeroBookBank.image
        case .icon36HeroOutlineHeroCalendarTime: return SvgIcons.icon36HeroOutlineHeroCalendarTime.image
        case .icon36HeroOutlineHeroCar: return SvgIcons.icon36HeroOutlineHeroCar.image
        case .icon36HeroOutlineHeroCard: return SvgIcons.icon36HeroOutlineHeroCard.image
        case .icon36HeroOutlineHeroCardlessWithdraw: return SvgIcons.icon36HeroOutlineHeroCardlessWithdraw.image
        case .icon36HeroOutlineHeroCashback: return SvgIcons.icon36HeroOutlineHeroCashback.image
        case .icon36HeroOutlineHeroCloseBookBank: return SvgIcons.icon36HeroOutlineHeroCloseBookBank.image
        case .icon36HeroOutlineHeroConversation: return SvgIcons.icon36HeroOutlineHeroConversation.image
        case .icon36HeroOutlineHeroGift: return SvgIcons.icon36HeroOutlineHeroGift.image
        case .icon36HeroOutlineHeroHistory: return SvgIcons.icon36HeroOutlineHeroHistory.image
        case .icon36HeroOutlineHeroHomeLoan: return SvgIcons.icon36HeroOutlineHeroHomeLoan.image
        case .icon36HeroOutlineHeroInsuranceCareCard: return SvgIcons.icon36HeroOutlineHeroInsuranceCareCard.image
        case .icon36HeroOutlineHeroInvest: return SvgIcons.icon36HeroOutlineHeroInvest.image
        case .icon36HeroOutlineHeroLifeHealthInsurance: return SvgIcons.icon36HeroOutlineHeroLifeHealthInsurance.image
        case .icon36HeroOutlineHeroLoan: return SvgIcons.icon36HeroOutlineHeroLoan.image
        case .icon36HeroOutlineHeroLockCard: return SvgIcons.icon36HeroOutlineHeroLockCard.image
        case .icon36HeroOutlineHeroMathSymbols: return SvgIcons.icon36HeroOutlineHeroMathSymbols.image
        case .icon36HeroOutlineHeroMore: return SvgIcons.icon36HeroOutlineHeroMore.image
        case .icon36HeroOutlineHeroPinCode: return SvgIcons.icon36HeroOutlineHeroPinCode.image
        case .icon36HeroOutlineHeroPointExchange: return SvgIcons.icon36HeroOutlineHeroPointExchange.image
        case .icon36HeroOutlineHeroPrivilege: return SvgIcons.icon36HeroOutlineHeroPrivilege.image
        case .icon36HeroOutlineHeroReceipt: return SvgIcons.icon36HeroOutlineHeroReceipt.image
        case .icon36HeroOutlineHeroTransfer: return SvgIcons.icon36HeroOutlineHeroTransfer.image
        case .icon36HeroOutlineHeroTransferRequest: return SvgIcons.icon36HeroOutlineHeroTransferRequest.image
        case .icon36HeroOutlineHeroWelfare: return SvgIcons.icon36HeroOutlineHeroWelfare.image
        case .icon36HeroOutlinePlaceholder: return SvgIcons.icon36HeroOutlinePlaceholder.image
        case .icon36HeroOutlineATS: return SvgIcons.icon36HeroOutlineATS.image
        case .icon36HeroOutlineHeroMenuDiscover: return SvgIcons.icon36HeroOutlineHeroMenuDiscover.image
        case .icon36HeroOutlineShoppingBags: return SvgIcons.icon36HeroOutlineShoppingBags.image
        case .icon36HeroOutlineHeroScan: return SvgIcons.icon36HeroOutlineHeroScan.image
        case .icon36HeroOutlineHeroTopUp: return SvgIcons.icon36HeroOutlineHeroTopUp.image
        case .icon36HeroOutlineApply: return SvgIcons.icon36HeroOutlineApply.image
        case .icon36HeroOutlineDocuments: return SvgIcons.icon36HeroOutlineDocuments.image
        case .icon36HeroOutlineAlert: return SvgIcons.icon36HeroOutlineAlert.image
        case .icon36HeroOutlineDCA: return SvgIcons.icon36HeroOutlineDCA.image
        case .icon36HeroOutlineFXAlert: return SvgIcons.icon36HeroOutlineFXAlert.image
        case .icon36HeroOutlineHeroClaim: return SvgIcons.icon36HeroOutlineHeroClaim.image
        case .icon36HeroOutlineHeroEdit: return SvgIcons.icon36HeroOutlineHeroEdit.image
        case .icon36HeroOutlineHeroEditAccount: return SvgIcons.icon36HeroOutlineHeroEditAccount.image
        case .icon36HeroOutlineHeroEditAddress: return SvgIcons.icon36HeroOutlineHeroEditAddress.image
        case .icon36HeroOutlineHeroPolicyDelete: return SvgIcons.icon36HeroOutlineHeroPolicyDelete.image
        case .icon36HeroOutlineHeroReceiptTax: return SvgIcons.icon36HeroOutlineHeroReceiptTax.image
        case .icon36HeroOutlineHeroSmallBiz: return SvgIcons.icon36HeroOutlineHeroSmallBiz.image
        case .icon36HeroOutlineHeroStatement: return SvgIcons.icon36HeroOutlineHeroStatement.image
        case .icon36HeroOutlineHeroStopCheque: return SvgIcons.icon36HeroOutlineHeroStopCheque.image
        case .icon36HeroOutlineHeroStore: return SvgIcons.icon36HeroOutlineHeroStore.image
        case .icon36HeroOutlineHeroTax: return SvgIcons.icon36HeroOutlineHeroTax.image
        case .icon36HeroOutlineHeroTaxSavingFunds: return SvgIcons.icon36HeroOutlineHeroTaxSavingFunds.image
        case .icon36HeroOutlineSetting: return SvgIcons.icon36HeroOutlineSetting.image
        case .icon36HeroOutlineSoGood: return SvgIcons.icon36HeroOutlineSoGood.image
        case .icon36HeroOutlineUnlockAccount: return SvgIcons.icon36HeroOutlineUnlockAccount.image
        case .icon36HeroOutlineWowPoint: return SvgIcons.icon36HeroOutlineWowPoint.image
        case .icon36HeroOutlineALBuyCar: return SvgIcons.icon36HeroOutlineALBuyCar.image
        case .icon36HeroOutlineALCarRegistration: return SvgIcons.icon36HeroOutlineALCarRegistration.image
        case .icon36HeroOutlineALPayInstallment: return SvgIcons.icon36HeroOutlineALPayInstallment.image
        case .icon36HeroOutlineALSellCar: return SvgIcons.icon36HeroOutlineALSellCar.image
        case .icon36HeroOutlineALTaxLabel: return SvgIcons.icon36HeroOutlineALTaxLabel.image
        case .icon36HeroOutlineALTransferForm: return SvgIcons.icon36HeroOutlineALTransferForm.image
        case .icon36HeroOutlinePromo: return SvgIcons.icon36HeroOutlinePromo.image
        case .icon36OutlineAddCoverage: return SvgIcons.icon36OutlineAddCoverage.image
        case .icon36OutlineAlert: return SvgIcons.icon36OutlineAlert.image
        case .icon36OutlineAvatar: return SvgIcons.icon36OutlineAvatar.image
        case .icon36OutlineApply: return
            SvgIcons.icon36OutlineApply.image
        case .icon36OutlineAvatarCircle: return SvgIcons.icon36OutlineAvatarCircle.image
        case .icon36OutlineBillPayment: return SvgIcons.icon36OutlineBillPayment.image
        case .icon36OutlineBiometricBackspace: return SvgIcons.icon36OutlineBiometricBackspace.image
        case .icon36OutlineBiometricFaceId: return SvgIcons.icon36OutlineBiometricFaceId.image
        case .icon36OutlineBiometricFingerprintAndroid: return SvgIcons.icon36OutlineBiometricFingerprintAndroid.image
        case .icon36OutlineBiometricTouchId: return SvgIcons.icon36OutlineBiometricTouchId.image
        case .icon36OutlineBook: return SvgIcons.icon36OutlineBook.image
        case .icon36OutlineCalendar: return SvgIcons.icon36OutlineCalendar.image
        case .icon36OutlineCamera: return SvgIcons.icon36OutlineCamera.image
        case .icon36OutlineCarInsurance: return SvgIcons.icon36OutlineCarInsurance.image
        case .icon36OutlineCardlessWithdraw: return SvgIcons.icon36OutlineCardlessWithdraw.image
        case .icon36OutlineCheckCircle: return SvgIcons.icon36OutlineCheckCircle.image
        case .icon36OutlineConversation: return SvgIcons.icon36OutlineConversation.image
        case .icon36OutlineDocumentsError: return SvgIcons.icon36OutlineDocumentsError.image
        case .icon36OutlineDownload: return SvgIcons.icon36OutlineDownload.image
        case .icon36OutlineEdit: return SvgIcons.icon36OutlineEdit.image
        case .icon36OutlineFamily: return SvgIcons.icon36OutlineFamily.image
        case .icon36OutlineFileDownload: return SvgIcons.icon36OutlineFileDownload.image
        case .icon36OutlineGift: return SvgIcons.icon36OutlineGift.image
        case .icon36OutlineHeart: return SvgIcons.icon36OutlineHeart.image
        case .icon36OutlineHelp: return SvgIcons.icon36OutlineHelp.image
        case .icon36OutlineInfo: return SvgIcons.icon36OutlineInfo.image
        case .icon36OutlineInsuranceCareCard: return SvgIcons.icon36OutlineInsuranceCareCard.image
        case .icon36OutlineMathSymbols: return SvgIcons.icon36OutlineMathSymbols.image
        case .icon36OutlineMenuAccounts: return SvgIcons.icon36OutlineMenuAccounts.image
        case .icon36OutlineMenuDiscover: return SvgIcons.icon36OutlineMenuDiscover.image
        case .icon36OutlineMenuHealth: return SvgIcons.icon36OutlineMenuHealth.image
        case .icon36OutlineMenuHome: return SvgIcons.icon36OutlineMenuHome.image
        case .icon36OutlineMenuService: return SvgIcons.icon36OutlineMenuService.image
        case .icon36OutlineMobilePhone: return SvgIcons.icon36OutlineMobilePhone.image
        case .icon36OutlineMore: return SvgIcons.icon36OutlineMore.image
        case .icon36OutlineNotification: return SvgIcons.icon36OutlineNotification.image
        case .icon36OutlineOnlineTransaction: return
            SvgIcons.icon36OutlineOnlineTransaction.image
        case .icon36OutlineParents: return SvgIcons.icon36OutlineParents.image
        case .icon36OutlinePhoto: return SvgIcons.icon36OutlinePhoto.image
        case .icon36OutlinePlaceholder: return SvgIcons.icon36OutlinePlaceholder.image
        case .icon36OutlinePlane: return SvgIcons.icon36OutlinePlane.image
        case .icon36OutlinePrivilege: return SvgIcons.icon36OutlinePrivilege.image
        case .icon36OutlineProductAllFree: return SvgIcons.icon36OutlineProductAllFree.image
        case .icon36OutlineProductCar: return SvgIcons.icon36OutlineProductCar.image
        case .icon36OutlineProductCurrentAccount: return SvgIcons.icon36OutlineProductCurrentAccount.image
        case .icon36OutlineProductFundByFund: return SvgIcons.icon36OutlineProductFundByFund.image
        case .icon36OutlineProductHomeLoan: return SvgIcons.icon36OutlineProductHomeLoan.image
        case .icon36OutlineProductLifeHealthInsurance: return SvgIcons.icon36OutlineProductLifeHealthInsurance.image
        case .icon36OutlineProductLoan: return SvgIcons.icon36OutlineProductLoan.image
        case .icon36OutlineProductNoFixed: return SvgIcons.icon36OutlineProductNoFixed.image
        case .icon36OutlineProductOtherInsurance: return SvgIcons.icon36OutlineProductOtherInsurance.image
        case .icon36OutlineProductSmallBiz: return SvgIcons.icon36OutlineProductSmallBiz.image
        case .icon36OutlineProductSmartPort: return SvgIcons.icon36OutlineProductSmartPort.image
        case .icon36OutlineProductTermDeposit: return SvgIcons.icon36OutlineProductTermDeposit.image
        case .icon36OutlineProductWelfare: return SvgIcons.icon36OutlineProductWelfare.image
        case .icon36OutlineRefresh: return SvgIcons.icon36OutlineRefresh.image
        case .icon36OutlineScan: return SvgIcons.icon36OutlineScan.image
        case .icon36OutlineSearchCircle: return SvgIcons.icon36OutlineSearchCircle.image
        case .icon36OutlineShareAndriod: return SvgIcons.icon36OutlineShareAndriod.image
        case .icon36OutlineShareIOs: return SvgIcons.icon36OutlineShareIOs.image
        case .icon36OutlineStore: return SvgIcons.icon36OutlineStore.image
        case .icon36OutlineTopUp: return SvgIcons.icon36OutlineTopUp.image
        case .icon36OutlineTransfer: return SvgIcons.icon36OutlineTransfer.image
        case .icon36OutlineWifi: return SvgIcons.icon36OutlineWifi.image
        case .icon36OutlineWifiOff: return SvgIcons.icon36OutlineWifiOff.image
        case .icon36OutlineWowPoint: return SvgIcons.icon36OutlineWowPoint.image
        case .icon48ConnectionLost: return SvgIcons.icon48ConnectionLost.image
        case .icon48GenericSystemError: return SvgIcons.icon48GenericSystemError.image
        case .icon36OutlineProductSavingAccount: return SvgIcons.icon36OutlineProductSavingAccount.image
        case .icon36OutlineProductCurrentMultiCurrency: return SvgIcons.icon36OutlineProductCurrentMultiCurrency.image
        case .icon36OutlineProductSavingAccountMultiCurrency: return SvgIcons.icon36OutlineProductSavingAccountMultiCurrency.image
        case .icon36OutlineProductSavingAccountFCD: return SvgIcons.icon36OutlineProductSavingAccountFCD.image
        case .icon36OutlineCheckNcb: return SvgIcons.icon36OutlineCheckNcb.image
        case .icon36OutlineContinueAccountOnTouch: return SvgIcons.icon36OutlineContinueAccountOnTouch.image
        case .icon36OutlineSummaryInsurance: return SvgIcons.icon36OutlineSummaryInsurance.image
        case .icon36OutlineSignDocument: return SvgIcons.icon36OutlineSignDocument.image
        case .icon36OutlineBTH: return SvgIcons.icon36OutlineBTH.image
        case .icon36OutlineTax: return SvgIcons.icon36OutlineTax.image
        case .icon36OutlineDCA: return SvgIcons.icon36OutlineDCA.image
        case .icon36OutlineSendDocument: return SvgIcons.icon36OutlineSendDocument.image
        case .icon36OutlineBackdatetimeentry: return SvgIcons.icon36OutlineBackdatetimeentry.image
        case .icon36OutlineAccidentCar: return SvgIcons.icon36OutlineAccidentCar.image
        case .icon36OutlineAmbulance: return SvgIcons.icon36OutlineAmbulance.image
        case .icon36OutlineAngel: return SvgIcons.icon36OutlineAngel.image
        case .icon36OutlineArt: return SvgIcons.icon36OutlineArt.image
        case .icon36OutlineAUD: return SvgIcons.icon36OutlineAUD.image
        case .icon36OutlineBasicAccount: return SvgIcons.icon36OutlineBasicAccount.image
        case .icon36OutlineBTHPlus: return SvgIcons.icon36OutlineBTHPlus.image
        case .icon36OutlineCAD: return SvgIcons.icon36OutlineCAD.image
        case .icon36OutlineCarAppraisal: return SvgIcons.icon36OutlineCarAppraisal.image
        case .icon36OutlineCarFix: return SvgIcons.icon36OutlineCarFix.image
        case .icon36OutlineCart: return SvgIcons.icon36OutlineCart.image
        case .icon36OutlineCashBackTTBTouch: return SvgIcons.icon36OutlineCashBackTTBTouch.image
        case .icon36OutlineCheckHealth: return SvgIcons.icon36OutlineCheckHealth.image
        case .icon36OutlineCHF: return SvgIcons.icon36OutlineCHF.image
        case .icon36OutlineCNY: return SvgIcons.icon36OutlineCNY.image
        case .icon36OutlineCreditCard: return SvgIcons.icon36OutlineCreditCard.image
        case .icon36OutlineDKK: return SvgIcons.icon36OutlineDKK.image
        case .icon36OutlineDocuments: return SvgIcons.icon36OutlineDocuments.image
        case .icon36OutlineDreamSaving: return SvgIcons.icon36OutlineDreamSaving.image
        case .icon36OutlineElectronicDamage: return SvgIcons.icon36OutlineElectronicDamage.image
        case .icon36OutlineEUR: return SvgIcons.icon36OutlineEUR.image
        case .icon36OutlineFileDownload2: return SvgIcons.icon36OutlineFileDownload2.image
        case .icon36OutlineGBP: return SvgIcons.icon36OutlineGBP.image
        case .icon36OutlineHomeLoan: return SvgIcons.icon36OutlineHomeLoan.image
        case .icon36OutlineHomeRefinance: return SvgIcons.icon36OutlineHomeRefinance.image
        case .icon36OutlineHomeAccident: return SvgIcons.icon36OutlineHomeAccident.image
        case .icon36OutlineHurtPerson: return SvgIcons.icon36OutlineHurtPerson.image
        case .icon36OutlineInProgress: return SvgIcons.icon36OutlineInProgress.image
        case .icon36OutlineInsurer: return SvgIcons.icon36OutlineInsurer.image
        case .icon36OutlineIPD: return SvgIcons.icon36OutlineIPD.image
        case .icon36OutlineJPY: return SvgIcons.icon36OutlineJPY.image
        case .icon36OutlineLatePlane: return SvgIcons.icon36OutlineLatePlane.image
        case .icon36OutlineLeaveGeneral: return SvgIcons.icon36OutlineLeaveGeneral.image
        case .icon36OutlineLocation: return SvgIcons.icon36OutlineLocation.image
        case .icon36OutlineLuggage: return SvgIcons.icon36OutlineLuggage.image
        case .icon36OutlineSunlight: return SvgIcons.icon36OutlineSunlight.image
        case .icon36OutlineMeSAVE: return SvgIcons.icon36OutlineMeSAVE.image
        case .icon36OutlineMovie: return SvgIcons.icon36OutlineMovie.image
        case .icon36OutlineOtherInsurance: return SvgIcons.icon36OutlineOtherInsurance.image
        case .icon36OutlinePolicy: return SvgIcons.icon36OutlinePolicy.image
        case .icon36OutlinePregnant: return SvgIcons.icon36OutlinePregnant.image
        case .icon36OutlineProductAssetInsurance: return SvgIcons.icon36OutlineProductAssetInsurance.image
        case .icon36OutlineProductHealthInsurance: return SvgIcons.icon36OutlineProductHealthInsurance.image
        case .icon36OutlineProductLifeInsurance: return SvgIcons.icon36OutlineProductLifeInsurance.image
        case .icon36OutlineProductSmartPort2: return SvgIcons.icon36OutlineProductSmartPort2.image
        case .icon36OutlineProductWealthInsurance: return SvgIcons.icon36OutlineProductWealthInsurance.image
        case .icon36OutlineReactivateAccount: return SvgIcons.icon36OutlineReactivateAccount.image
        case .icon36OutlineSGD: return SvgIcons.icon36OutlineSGD.image
        case .icon36OutlineShield: return SvgIcons.icon36OutlineShield.image
        case .icon36OutlineSocialMedia: return SvgIcons.icon36OutlineSocialMedia.image
        case .icon36OutlineSport: return SvgIcons.icon36OutlineSport.image
        case .icon36OutlineStoreCheck: return SvgIcons.icon36OutlineStoreCheck.image
        case .icon36OutlineThief: return SvgIcons.icon36OutlineThief.image
        case .icon36OutlineTravelInsurance: return SvgIcons.icon36OutlineTravelInsurance.image
        case .icon36OutlineUSD: return SvgIcons.icon36OutlineUSD.image
        case .icon36OutlineUtensils: return SvgIcons.icon36OutlineUtensils.image
        case .icon36OutlineWashingMachine: return SvgIcons.icon36OutlineWashingMachine.image
        case .icon36OutlineWrongPlane: return SvgIcons.icon36OutlineWrongPlane.image
        case .icon36OutlineProductCurrentAccountAUD: return SvgIcons.icon36OutlineProductCurrentAccountAUD.image
        case .icon36OutlineProductCurrentAccountCAD: return SvgIcons.icon36OutlineProductCurrentAccountCAD.image
        case .icon36OutlineProductCurrentAccountCHF: return SvgIcons.icon36OutlineProductCurrentAccountCHF.image
        case .icon36OutlineProductCurrentAccountCNY: return SvgIcons.icon36OutlineProductCurrentAccountCNY.image
        case .icon36OutlineProductCurrentAccountDKK: return SvgIcons.icon36OutlineProductCurrentAccountDKK.image
        case .icon36OutlineProductCurrentAccountEUR: return SvgIcons.icon36OutlineProductCurrentAccountEUR.image
        case .icon36OutlineProductCurrentAccountFCD: return SvgIcons.icon36OutlineProductCurrentAccountFCD.image
        case .icon36OutlineProductCurrentAccountGBP: return SvgIcons.icon36OutlineProductCurrentAccountGBP.image
        case .icon36OutlineProductCurrentAccountJPY: return SvgIcons.icon36OutlineProductCurrentAccountJPY.image
        case .icon36OutlineProductCurrentAccountSGD: return SvgIcons.icon36OutlineProductCurrentAccountSGD.image
        case .icon36OutlineProductCurrentAccountUSD: return SvgIcons.icon36OutlineProductCurrentAccountUSD.image
        case .icon36OutlineCreditPoint: return SvgIcons.icon36OutlineCreditPoint.image
        case .icon36BasicAccount: return SvgIcons.icon36BasicAccount.image
        case .icon36MeSave: return SvgIcons.icon36MeSave.image
        case .icon36DreamSaving: return SvgIcons.icon36DreamSaving.image
        case .vector56NoMCA: return SvgIcons.vector56NoMCA.image
        case .vector56ProductODI: return SvgIcons.vector56ProductODI.image
        case .vector56Empty: return SvgIcons.vector56Empty.image
        case .vector56NoData: return SvgIcons.vector56NoData.image
        case .vector56NoProduct: return SvgIcons.vector56NoProduct.image
        case .vector56Maintenance: return SvgIcons.vector56Maintenance.image
        case .vector56DocumentProtected: return SvgIcons.vector56DocumentProtected.image
        case .icon36ErrorAssetBlock:
            return SvgIcons.icon36ErrorAssetBlock.image
        case .icon36ErrorBiometric:
            return SvgIcons.icon36ErrorBiometric.image
        case .icon36ErrorByInput:
            return SvgIcons.icon36ErrorByInput.image
        case .icon36ErrorCircuitBreak:
            return SvgIcons.icon36ErrorCircuitBreak.image
        case .icon36ErrorConnectionFail:
            return SvgIcons.icon36ErrorConnectionFail.image
        case .icon36ErrorConnectionLost:
            return SvgIcons.icon36ErrorConnectionLost.image
        case .icon36ErrorDataMismatch:
            return SvgIcons.icon36ErrorDataMismatch.image
        case .icon36ErrorDataNotFound:
            return SvgIcons.icon36ErrorDataNotFound.image
        case .icon36ErrorDuplicateRequest:
            return SvgIcons.icon36ErrorDuplicateRequest.image
        case .icon36ErrorExceedAmountMax:
            return SvgIcons.icon36ErrorExceedAmountMax.image
        case .icon36ErrorExceededLimit:
            return SvgIcons.icon36ErrorExceededLimit.image
        case .icon36ErrorFileFormatNotSupport:
            return SvgIcons.icon36ErrorFileFormatNotSupport.image
        case .icon36ErrorGenericSystemError:
            return SvgIcons.icon36ErrorGenericSystemError.image
        case .icon36ErrorIncompleteFileUpload:
            return SvgIcons.icon36ErrorIncompleteFileUpload.image
        case .icon36ErrorIncompleteInputText:
            return SvgIcons.icon36ErrorIncompleteInputText.image
        case .icon36ErrorInform:
            return SvgIcons.icon36ErrorInform.image
        case .icon36ErrorInsufficient:
            return SvgIcons.icon36ErrorInsufficient.image
        case .icon36ErrorLessThanMinAmount:
            return SvgIcons.icon36ErrorLessThanMinAmount.image
        case .icon36ErrorNonServiceHour:
            return SvgIcons.icon36ErrorNonServiceHour.image
        case .icon36ErrorNotConsent:
            return SvgIcons.icon36ErrorNotConsent.image
        case .icon36ErrorQualification:
            return SvgIcons.icon36ErrorQualification.image
        case .icon36ErrorRunBatch:
            return SvgIcons.icon36ErrorRunBatch.image
        case .icon36ErrorScheduleUnavailable:
            return SvgIcons.icon36ErrorScheduleUnavailable.image
        case .icon36ErrorServerDown:
            return SvgIcons.icon36ErrorServerDown.image
        case .icon36ErrorSessionExpire:
            return SvgIcons.icon36ErrorSessionExpire.image
        case .icon36ErrorSessionTimeout:
            return SvgIcons.icon36ErrorSessionTimeout.image
        case .icon36ErrorSystemMaintenance:
            return SvgIcons.icon36ErrorSystemMaintenance.image
        case .icon36ErrorSystemTimeout:
            return SvgIcons.icon36ErrorSystemTimeout.image
        case .icon36OutlineCelebration:
            return SvgIcons.icon36OutlineCelebration.image
        case .icon36OutlineSelectObj:
            return SvgIcons.icon36OutlineSelectObj.image
        case .icon36OutlineStructuredNote:
            return SvgIcons.icon36OutlineStructuredNote.image
        case .icon36SolidAccountSumOverview:
            return SvgIcons.icon36SolidAccountSumOverview.image
        case .icon36OutlineDocumentEdit:
            return SvgIcons.icon36OutlineDocumentEdit.image
        case .icon48OfferingPlaceholder:
            return SvgIcons.icon48OfferingPlaceholder.image
        case .icon48OfferingCarLoan:
            return SvgIcons.icon48OfferingCarLoan.image
        case .icon48OfferingCashYourCar:
            return SvgIcons.icon48OfferingCashYourCar.image
        case .icon48OfferingHomeLoan:
            return SvgIcons.icon48OfferingHomeLoan.image
        case .icon48OfferingCashYourHome:
            return SvgIcons.icon48OfferingCashYourHome.image
        case .icon48OfferingPersonalLoan:
            return SvgIcons.icon48OfferingPersonalLoan.image
        case .icon48OfferingCreditCard:
            return SvgIcons.icon48OfferingCreditCard.image
        case .icon48OfferingHomeLoanRefinance:
            return SvgIcons.icon48OfferingHomeLoanRefinance.image
        case .vector240ConnectionIostByUser:
            return SvgIcons.vector240ConnectionIostByUser.image
        case .vector240GenericSystemErrorInternal:
            return SvgIcons.vector240GenericSystemErrorInternal.image
        case .vector56NoDataPreviewFile:
            return SvgIcons.vector56NoDataPreviewFile.image
        case .icon48MRTAHomeLoanRefinance:
            return SvgIcons.icon48MRTAHomeLoanRefinance.image
        case .icon48MRTAPersonalLoan:
            return SvgIcons.icon48MRTAPersonalLoan.image
        case .icon36WarningBillPaymentBlock:
            return SvgIcons.icon36WarningBillPaymentBlock.image
        case .icon36WarningCalendarBlock:
            return SvgIcons.icon36WarningCalendarBlock.image
        case .icon36WarningCardlessWithdrawBlock:
            return SvgIcons.icon36WarningCardlessWithdrawBlock.image
        case .icon36WarningTopUpBlock:
            return SvgIcons.icon36WarningTopUpBlock.image
        case .icon36WarningTransferBlock:
            return SvgIcons.icon36WarningTransferBlock.image
        case .iconDataMismatch03:
            return SvgIcons.iconDataMismatch03.image
        case .illusDataMismatch02:
            return SvgIcons.illusDataMismatch02.image
        case .icon36SuccessBranch:
            return SvgIcons.icon36SuccessBranch.image
        case .icon36SuccessIncome:
            return SvgIcons.icon36SuccessIncome.image
        case .icon36SuccessStatement:
            return SvgIcons.icon36SuccessStatement.image
        case .icon36SuccessWithdraw:
            return SvgIcons.icon36SuccessWithdraw.image
        case .icon36WarningExpenseBlock:
            return SvgIcons.icon36WarningExpenseBlock.image
        case .icon24OutlineApply:
            return SvgIcons.icon24OutlineApply.image
        case .icon24OutlineESlip:
            return SvgIcons.icon24OutlineESlip.image
        case .icon24OutlinePasscodeLock:
            return SvgIcons.icon24OutlinePasscodeLock.image
        case .icon24OutlinePasscode:
            return SvgIcons.icon24OutlinePasscode.image
        case .icon24OutlineRestaurant:
            return SvgIcons.icon24OutlineRestaurant.image
        case .icon24OutlinePercentage:
            return SvgIcons.icon24OutlinePercentage.image
        case .icon24OutlineTag:
            return SvgIcons.icon24OutlineTag.image
        case .icon36OutlineCashback:
            return SvgIcons.icon36OutlineCashback.image
        case .icon36OutlineESlip:
            return SvgIcons.icon36OutlineESlip.image
        case .icon36OutlineExchangeRate:
            return SvgIcons.icon36OutlineExchangeRate.image
        case .icon36OutlineRestaurant:
            return SvgIcons.icon36OutlineRestaurant.image
        case .icon36OutlineShop:
            return SvgIcons.icon36OutlineShop.image
        case .icon36OutlineSmallBiz:
            return SvgIcons.icon36OutlineSmallBiz.image
        case .icon36OutlineSoGood:
            return SvgIcons.icon36OutlineSoGood.image
        case .icon36OutlineVirtualDebitCredit:
            return SvgIcons.icon36OutlineVirtualDebitCredit.image
        case .icon36OutlineVirtualCreditCredit:
            return SvgIcons.icon36OutlineVirtualCreditCredit.image
        }
    }
}
// swiftlint:enable all
