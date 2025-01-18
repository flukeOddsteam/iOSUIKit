import UIKit

// swiftlint:disable:next type_body_length
public enum DSColor {
    static func dynamicColor(day: UIColor, night: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return day }
        return UIColor { $0.userInterfaceStyle == .dark ? night : day }
    }
    
    public static var pageLightBackground: UIColor {
        dynamicColor(day: UIColor.primaryHonestWhite, night: UIColor.primaryHonestWhite)
    }
    
    public static var pageLightTextDefault: UIColor {
        dynamicColor(day: UIColor.primaryTrustedNavy, night: UIColor.primaryTrustedNavy)
    }
    
    public static var pageLightDesc: UIColor {
        dynamicColor(day: UIColor.secondaryGrey70, night: UIColor.secondaryGrey70)
    }
    
    public static var pageLightError: UIColor {
        dynamicColor(day: UIColor.utilityRedError100, night: UIColor.utilityRedError100)
    }
    
    public static var pageLightSuccess: UIColor {
        dynamicColor(day: UIColor.utilityGreenSuccess100, night: UIColor.utilityGreenSuccess100)
    }
    
    public static var pageDarkBackground: UIColor {
        dynamicColor(day: UIColor.primaryConfidentBlue, night: UIColor.primaryConfidentBlue)
    }
    
    public static var pageDarkDefault: UIColor {
        dynamicColor(day: UIColor.primaryHonestWhite, night: UIColor.primaryHonestWhite)
    }
    
    public static var pageDarkDesc: UIColor {
        dynamicColor(day: UIColor.secondaryGrey70, night: UIColor.secondaryGrey70)
    }
    
    public static var pageDarkComponentGhostBackground: UIColor {
        dynamicColor(day: UIColor.customPrimaryHonestWhiteOpacity1, night: UIColor.customPrimaryHonestWhiteOpacity1)
    }
    
    public static var pageDarkComponentGhostDefault: UIColor {
        dynamicColor(day: UIColor.primaryHonestWhite, night: UIColor.primaryHonestWhite)
    }
    
    public static var pageDarkComponentGhostOnPress: UIColor {
        dynamicColor(day: UIColor.customSecondarySkyBlue100Opacity30, night: UIColor.customSecondarySkyBlue100Opacity30)
    }
    
    public static var pageDarkComponentGhostActive: UIColor {
        dynamicColor(day: UIColor.primaryRefreshingOrange, night: UIColor.primaryRefreshingOrange)
    }
    
    public static var componentGhostBackground: UIColor {
        dynamicColor(day: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.00), night: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.00))
    }
    
    public static var componentGhostBackgroundOnPress: UIColor {
        dynamicColor(day: UIColor.secondaryDarkOrange10, night: UIColor.secondaryDarkOrange10)
    }
    
    public static var componentGhostDefault: UIColor {
        dynamicColor(day: UIColor.primaryRefreshingOrange, night: UIColor.primaryRefreshingOrange)
    }
    
    public static var componentGhostLabel: UIColor {
        dynamicColor(day: UIColor.primaryTrustedNavy, night: UIColor.primaryTrustedNavy)
    }
    
    public static var componentSummaryBackground: UIColor {
        dynamicColor(day: UIColor.secondaryGrey10, night: UIColor.secondaryGrey10)
    }
    
    public static var componentSummaryDefault: UIColor {
        dynamicColor(day: UIColor.primaryTrustedNavy, night: UIColor.primaryTrustedNavy)
    }
    
    public static var componentSummaryOutline: UIColor {
        dynamicColor(day: UIColor.secondaryGrey20, night: UIColor.secondaryGrey20)
    }
    
    public static var componentSummaryDesc: UIColor {
        dynamicColor(day: UIColor.secondaryGrey70, night: UIColor.secondaryGrey70)
    }
    
    public static var componentSummaryPrimaryActive: UIColor {
        dynamicColor(day: UIColor.primaryConfidentBlue, night: UIColor.primaryConfidentBlue)
    }
    
    public static var componentSummarySecondaryActive: UIColor {
        dynamicColor(day: UIColor.primaryRefreshingOrange, night: UIColor.primaryRefreshingOrange)
    }
    
    public static var componentSummaryBackgrondOpacity60: UIColor {
        dynamicColor(day: UIColor.customSecondaryGrey20Opacity60, night: UIColor.customSecondaryGrey20Opacity60)
    }
    
    public static var componentLightBackground: UIColor {
        dynamicColor(day: UIColor.primaryHonestWhite, night: UIColor.primaryHonestWhite)
    }
    
    public static var componentLightBackgroundOnPress: UIColor {
        dynamicColor(day: UIColor.secondaryGrey10, night: UIColor.secondaryGrey10)
    }
    
    public static var componentLightDefault: UIColor {
        dynamicColor(day: UIColor.primaryTrustedNavy, night: UIColor.primaryTrustedNavy)
    }
    
    public static var componentLightPlaceholder: UIColor {
        dynamicColor(day: UIColor.secondaryGrey50, night: UIColor.secondaryGrey50)
    }
    
    public static var componentLightOutline: UIColor {
        dynamicColor(day: UIColor.secondaryGrey50, night: UIColor.secondaryGrey50)
    }
    
    public static var componentLightOutlinePrimary: UIColor {
        dynamicColor(day: UIColor.secondaryGrey50, night: UIColor.secondaryGrey50)
    }
    
    public static var componentLightOutlineSecondary: UIColor {
        dynamicColor(day: UIColor.secondaryGrey20, night: UIColor.secondaryGrey20)
    }
    
    public static var componentLightOutlineClickable: UIColor {
        dynamicColor(day: UIColor.secondaryGrey20, night: UIColor.secondaryGrey20)
    }
    
    public static var componentLightOutlineActive: UIColor {
        dynamicColor(day: UIColor.primaryRefreshingOrange, night: UIColor.primaryRefreshingOrange)
    }
    
    public static var componentLightOutlineActiveOnPress: UIColor {
        dynamicColor(day: UIColor.customPrimaryRefreshingOrangeShade10, night: UIColor.customPrimaryRefreshingOrangeShade10)
    }
    
    public static var componentLightOutlineTertiary: UIColor {
        dynamicColor(day: UIColor.secondaryGrey10, night: UIColor.secondaryGrey10)
    }
    
    public static var componentLightError: UIColor {
        dynamicColor(day: UIColor.utilityRedError100, night: UIColor.utilityRedError100)
    }
    
    public static var componentLightDesc: UIColor {
        dynamicColor(day: UIColor.secondaryGrey70, night: UIColor.secondaryGrey70)
    }
    
    public static var componentLightSuccess: UIColor {
        dynamicColor(day: UIColor.utilityGreenSuccess100, night: UIColor.utilityGreenSuccess100)
    }
    
    public static var componentLightOutlineInputFocus: UIColor {
        dynamicColor(day: UIColor.primaryConfidentBlue, night: UIColor.primaryConfidentBlue)
    }
    
    public static var componentLightLabel: UIColor {
        dynamicColor(day: UIColor.secondaryGrey100, night: UIColor.secondaryGrey100)
    }
    
    public static var componentLightLabelXSoft: UIColor {
        dynamicColor(day: UIColor.secondaryGrey70Tint30, night: UIColor.secondaryGrey70Tint30)
    }
    
    public static var componentLightLabelSoft: UIColor {
        dynamicColor(day: UIColor.secondaryGrey70, night: UIColor.secondaryGrey70)
    }
    
    public static var componentLightIncome: UIColor {
        dynamicColor(day: UIColor.utilityGreenSuccess100, night: UIColor.utilityGreenSuccess100)
    }
    
    public static var componentLightOutcome: UIColor {
        dynamicColor(day: UIColor.utilityRedError100, night: UIColor.utilityRedError100)
    }
    
    public static var componentLightOutlineSoft: UIColor {
        dynamicColor(day: UIColor.secondaryGrey70Tint30, night: UIColor.secondaryGrey70Tint30)
    }
    
    public static var componentLightIconOnDark: UIColor {
        dynamicColor(day: UIColor.primaryHonestWhite, night: UIColor.primaryHonestWhite)
    }
    
    public static var componentLightOutlineOnDark: UIColor {
        dynamicColor(day: UIColor.primaryHonestWhite, night: UIColor.primaryHonestWhite)
    }
    
    public static var componentLightBackgroundXSoftOnDark: UIColor {
        dynamicColor(day: UIColor.secondaryGrey70Tint70, night: UIColor.secondaryGrey70Tint70)
    }
    
    public static var componentLightOutlineXSoftOnDark: UIColor {
        dynamicColor(day: UIColor.secondaryGrey70Tint70, night: UIColor.secondaryGrey70Tint70)
    }
    
    public static var componentLightBackgroundActive: UIColor {
        dynamicColor(day: UIColor.primaryRefreshingOrange, night: UIColor.primaryRefreshingOrange)
    }
    
    public static var componentDisableBackgroundSecondary: UIColor {
        dynamicColor(day: UIColor.secondaryGrey20, night: UIColor.secondaryGrey20)
    }
    
    public static var componentDisableBackgroundPrimaryOnDark: UIColor {
        dynamicColor(day: UIColor.secondaryGrey10, night: UIColor.secondaryGrey10)
    }
    
    public static var componentDisableBackgroundSecondaryOnDark: UIColor {
        dynamicColor(day: UIColor.secondaryGrey50, night: UIColor.secondaryGrey50)
    }
    
    public static var componentDisableDefaultOnDark: UIColor {
        dynamicColor(day: UIColor.secondaryGrey50, night: UIColor.secondaryGrey50)
    }
    
    public static var componentDisableOutlineOnDark: UIColor {
        dynamicColor(day: UIColor.secondaryGrey50, night: UIColor.secondaryGrey50)
    }
    
    public static var componentDarkBackground: UIColor {
        dynamicColor(day: UIColor.primaryTrustedNavy, night: UIColor.primaryTrustedNavy)
    }
    
    public static var componentDarkDefault: UIColor {
        dynamicColor(day: UIColor.primaryHonestWhite, night: UIColor.primaryHonestWhite)
    }
    
    public static var componentPrimaryBackground: UIColor {
        dynamicColor(day: UIColor.primaryRefreshingOrange, night: UIColor.primaryRefreshingOrange)
    }
    
    public static var componentPrimaryBackgroundOnPress: UIColor {
        dynamicColor(day: UIColor.customPrimaryRefreshingOrangeShade10, night: UIColor.customPrimaryRefreshingOrangeShade10)
    }
    
    public static var componentPrimaryDefault: UIColor {
        dynamicColor(day: UIColor.primaryHonestWhite, night: UIColor.primaryHonestWhite)
    }
    
    public static var componentSecondaryBackground: UIColor {
        dynamicColor(day: UIColor.primaryHonestWhite, night: UIColor.primaryHonestWhite)
    }
    
    public static var componentSecondaryBackgroundOnPress: UIColor {
        dynamicColor(day: UIColor.secondaryDarkOrange10, night: UIColor.secondaryDarkOrange10)
    }
    
    public static var componentSecondaryDefault: UIColor {
        dynamicColor(day: UIColor.primaryRefreshingOrange, night: UIColor.primaryRefreshingOrange)
    }
    
    public static var componentSecondaryOutline: UIColor {
        dynamicColor(day: UIColor.primaryRefreshingOrange, night: UIColor.primaryRefreshingOrange)
    }
    
    public static var componentDisableBackground: UIColor {
        dynamicColor(day: UIColor.secondaryGrey10, night: UIColor.secondaryGrey10)
    }
    
    public static var componentDisableBackgroundPrimary: UIColor {
        dynamicColor(day: UIColor.secondaryGrey10, night: UIColor.secondaryGrey10)
    }
    
    public static var componentDisableOutline: UIColor {
        dynamicColor(day: UIColor.secondaryGrey20, night: UIColor.secondaryGrey20)
    }
    
    public static var componentDisableDefault: UIColor {
        dynamicColor(day: UIColor.secondaryGrey50, night: UIColor.secondaryGrey50)
    }
    
    public static var componentDisableIcon: UIColor {
        dynamicColor(day: UIColor.primaryHonestWhite, night: UIColor.primaryHonestWhite)
    }
    
    public static var componentWarningBackground: UIColor {
        dynamicColor(day: UIColor.utilityYellowWarning10, night: UIColor.utilityYellowWarning10)
    }
    
    public static var componentWarningDefault: UIColor {
        dynamicColor(day: UIColor.primaryTrustedNavy, night: UIColor.primaryTrustedNavy)
    }
    
    public static var componentWarningOutlineIcon: UIColor {
        dynamicColor(day: UIColor.utilityYellowWarning100, night: UIColor.utilityYellowWarning100)
    }
    
    public static var componentWarningDesc: UIColor {
        dynamicColor(day: UIColor.secondaryGrey100, night: UIColor.secondaryGrey100)
    }
    
    public static var componentErrorBackground: UIColor {
        dynamicColor(day: UIColor.utilityRedError10, night: UIColor.utilityRedError10)
    }
    
    public static var componentErrorDefault: UIColor {
        dynamicColor(day: UIColor.primaryTrustedNavy, night: UIColor.primaryTrustedNavy)
    }
    
    public static var componentErrorDesc: UIColor {
        dynamicColor(day: UIColor.secondaryGrey100, night: UIColor.secondaryGrey100)
    }
    
    public static var componentErrorOutlineIcon: UIColor {
        dynamicColor(day: UIColor.utilityRedError100, night: UIColor.utilityRedError100)
    }
    
    public static var componentinformativeBackground: UIColor {
        dynamicColor(day: UIColor.secondarySkyBlue10, night: UIColor.secondarySkyBlue10)
    }
    
    public static var componentinformativeDefault: UIColor {
        dynamicColor(day: UIColor.primaryTrustedNavy, night: UIColor.primaryTrustedNavy)
    }
    
    public static var componentinformativeOutlineIcon: UIColor {
        dynamicColor(day: UIColor.secondarySkyBlue100, night: UIColor.secondarySkyBlue100)
    }
    
    public static var componentinformativeDesc: UIColor {
        dynamicColor(day: UIColor.secondaryGrey100, night: UIColor.secondaryGrey100)
    }
    
    public static var componentSuccessBackground: UIColor {
        dynamicColor(day: UIColor.utilityGreenSuccess10, night: UIColor.utilityGreenSuccess10)
    }
    
    public static var componentSuccessDefault: UIColor {
        dynamicColor(day: UIColor.primaryTrustedNavy, night: UIColor.primaryTrustedNavy)
    }
    
    public static var componentOfferBackground: UIColor {
        dynamicColor(day: UIColor.secondaryDarkOrange10, night: UIColor.secondaryDarkOrange10)
    }
    
    public static var componentOfferGraphic: UIColor {
        dynamicColor(day: UIColor.tertiaryOrange40, night: UIColor.tertiaryOrange40)
    }
    
    public static var componentOfferDefault: UIColor {
        dynamicColor(day: UIColor.primaryTrustedNavy, night: UIColor.primaryTrustedNavy)
    }
    
    public static var componentOfferDesc: UIColor {
        dynamicColor(day: UIColor.secondaryGrey100, night: UIColor.secondaryGrey100)
    }
    
    public static var componentOfferOutline: UIColor {
        dynamicColor(day: UIColor.primaryRefreshingOrange, night: UIColor.primaryRefreshingOrange)
    }
    
    public static var componentDividerBackgroundSmall: UIColor {
        dynamicColor(day: UIColor.secondaryGrey20, night: UIColor.secondaryGrey20)
    }
    
    public static var componentDividerBackgroundBig: UIColor {
        dynamicColor(day: UIColor.secondaryGrey10, night: UIColor.secondaryGrey10)
    }
    
    public static var componentCustomBackgroundBackgroundInformative: UIColor {
        dynamicColor(day: UIColor.secondaryGrey100, night: UIColor.secondaryGrey100)
    }
    
    public static var componentCustomBackgroundBackgroundDefault: UIColor {
        dynamicColor(day: UIColor.secondaryGrey50, night: UIColor.secondaryGrey50)
    }
    
    public static var componentCustomBackgroundBackgroundInformativeSpecial: UIColor {
        dynamicColor(day: UIColor.primaryTrustedNavy, night: UIColor.primaryTrustedNavy)
    }
    
    public static var componentCustomBackgroundBackgroundSuccess: UIColor {
        dynamicColor(day: UIColor.utilityGreenSuccess100, night: UIColor.utilityGreenSuccess100)
    }
    
    public static var componentCustomBackgroundBackgroundError: UIColor {
        dynamicColor(day: UIColor.utilityRedError100, night: UIColor.utilityRedError100)
    }
    
    public static var componentCustomBackgroundBackgroundWarning: UIColor {
        dynamicColor(day: UIColor.utilityYellowWarning100, night: UIColor.utilityYellowWarning100)
    }
    
    public static var ComponentCustomBackgroundBackgroundSpecial1: UIColor {
        dynamicColor(day: UIColor.customPrimaryRefreshingOrangeShade10, night: UIColor.customPrimaryRefreshingOrangeShade10)
    }
    
    public static var componentCustomBackgroundDefault: UIColor {
        dynamicColor(day: UIColor.primaryHonestWhite, night: UIColor.primaryHonestWhite)
    }
    
    public static var componentDatavisualizeTrustNavy: UIColor {
        dynamicColor(day: UIColor.primaryTrustedNavy, night: UIColor.primaryTrustedNavy)
    }
    
    public static var componentDatavisualizeRefreshingOrange: UIColor {
        dynamicColor(day: UIColor.primaryRefreshingOrange, night: UIColor.primaryRefreshingOrange)
    }
    
    public static var componentDatavisualizeConfidentblue: UIColor {
        dynamicColor(day: UIColor.primaryConfidentBlue, night: UIColor.primaryConfidentBlue)
    }
    
    public static var componentDatavisualizeGrey50: UIColor {
        dynamicColor(day: UIColor.secondaryGrey50, night: UIColor.secondaryGrey50)
    }
    
    public static var componentDatavisualizeYellowLight100: UIColor {
        dynamicColor(day: UIColor.tertiaryLightYellow100, night: UIColor.tertiaryLightYellow100)
    }
    
    public static var componentDatavisualizeTurquoise100: UIColor {
        dynamicColor(day: UIColor.tertiaryTurquoise100, night: UIColor.tertiaryTurquoise100)
    }
    
    public static var componentDatavisualizePeach100: UIColor {
        dynamicColor(day: UIColor.tertiaryPeach100, night: UIColor.tertiaryPeach100)
    }
    
    public static var componentDatavisualizeGreen70: UIColor {
        dynamicColor(day: UIColor.utilityGreenSuccess70, night: UIColor.utilityGreenSuccess70)
    }
    
    public static var componentDatavisualizeBrown70: UIColor {
        dynamicColor(day: UIColor.tertiaryBrown70, night: UIColor.tertiaryBrown70)
    }
    
    public static var componentDatavisualizePink100: UIColor {
        dynamicColor(day: UIColor.tertiaryPink100, night: UIColor.tertiaryPink100)
    }
    
    public static var componentDatavisualizeYellowWarning70: UIColor {
        dynamicColor(day: UIColor.utilityYellowWarning70, night: UIColor.utilityYellowWarning70)
    }
    
    public static var componentDatavisualizeTertiary70: UIColor {
        dynamicColor(day: UIColor.tertiaryBlue70, night: UIColor.tertiaryBlue70)
    }
    
    public static var componentDatavisualizeGrey70: UIColor {
        dynamicColor(day: UIColor.secondaryGrey70, night: UIColor.secondaryGrey70)
    }
    
    public static var componentDatavisualizeDarkOranfe70: UIColor {
        dynamicColor(day: UIColor.secondaryDarkOrange70, night: UIColor.secondaryDarkOrange70)
    }
    
    public static var componentDatavisualizeSkyblue70: UIColor {
        dynamicColor(day: UIColor.secondarySkyBlue70, night: UIColor.secondarySkyBlue70)
    }
    
    public static var otherBackgroundOverlayScreen: UIColor {
        dynamicColor(day: UIColor.customPrimaryTrustedNavyOpacity50, night: UIColor.customPrimaryTrustedNavyOpacity50)
    }
    
    public static var otherBackgroundOverlayImage: UIColor {
        dynamicColor(day: UIColor.customPrimaryTrustedNavyOpacity20, night: UIColor.customPrimaryTrustedNavyOpacity20)
    }
    
    public static var otherBackgroundOverlayWhiteLoading: UIColor {
        dynamicColor(day: UIColor.customPrimaryHonestWhiteOpacity1, night: UIColor.customPrimaryHonestWhiteOpacity1)
    }
    
    public static var otherBackgroundLoadingDefault: UIColor {
        dynamicColor(day: UIColor.secondaryGrey10, night: UIColor.secondaryGrey10)
    }
    
    public static var otherBackgroundLoadingIcon: UIColor {
        dynamicColor(day: UIColor.secondaryGrey20, night: UIColor.secondaryGrey20)
    }
    
    public static var otherWatermark: UIColor {
        dynamicColor(day: UIColor.secondaryGrey10, night: UIColor.secondaryGrey10)
    }
    
    public static var otherDefault: UIColor {
        dynamicColor(day: UIColor.primaryHonestWhite, night: UIColor.primaryHonestWhite)
    }
    
    public static var componentDatavisualizePrimaryValue: UIColor {
        dynamicColor(day: UIColor.primaryTrustedNavy, night: UIColor.primaryTrustedNavy)
    }
    
    public static var componentDatavisualizeSecondaryValue: UIColor {
        dynamicColor(day: UIColor.primaryRefreshingOrange, night: UIColor.primaryRefreshingOrange)
    }
    
    public static var componentDatavisualizeTertiaryValue: UIColor {
        dynamicColor(day: UIColor.primaryConfidentBlue, night: UIColor.primaryConfidentBlue)
    }
    
    public static var componentDatavisualizeTotal: UIColor {
        dynamicColor(day: UIColor.secondaryGrey20, night: UIColor.secondaryGrey20)
    }
    
    public static var componentDatavisualizeCustomValueGrey: UIColor {
        dynamicColor(day: UIColor.secondaryGrey70, night: UIColor.secondaryGrey70)
    }
    
    public static var componentDatavisualizeCustomValueBrown: UIColor {
        dynamicColor(day: UIColor.tertiaryBrown70, night: UIColor.tertiaryBrown70)
    }
    
    public static var componentDatavisualizeCustomValuePeach: UIColor {
        dynamicColor(day: UIColor.tertiaryPeach100, night: UIColor.tertiaryPeach100)
    }
    
    public static var componentDatavisualizeCustomValuePink: UIColor {
        dynamicColor(day: UIColor.tertiaryPink100, night: UIColor.tertiaryPink100)
    }
    
    public static var componentDatavisualizeCustomValueYellow: UIColor {
        dynamicColor(day: UIColor.tertiaryLightYellow100, night: UIColor.tertiaryLightYellow100)
    }
    
    public static var componentDatavisualizeCustomValueSkyBlue: UIColor {
        dynamicColor(day: UIColor.secondarySkyBlue70, night: UIColor.secondarySkyBlue70)
    }
    
    public static var componentDatavisualizeCustomValueBlue: UIColor {
        dynamicColor(day: UIColor.tertiaryBlue70, night: UIColor.tertiaryBlue70)
    }
    
    public static var componentDatavisualizeCustomValueTurquoise: UIColor {
        dynamicColor(day: UIColor.tertiaryTurquoise100, night: UIColor.tertiaryTurquoise100)
    }
    
    public static var componentDatavisualizeCustomValueGreen: UIColor {
        dynamicColor(day: UIColor.utilityGreenSuccess100, night: UIColor.utilityGreenSuccess100)
    }
    
    public static var otherBackgroundSkeleton: UIColor {
        dynamicColor(day: UIColor.otherBackgroundSkeleton, night: UIColor.otherBackgroundSkeleton)
    }
    
    public static var componentDatavisualizeGraphPrimaryHover: UIColor {
        dynamicColor(day: UIColor.customPrimaryTrustedNavyTint20, night: UIColor.customPrimaryTrustedNavyTint20)
    }
    
    public static var componentDatavisualizeGraphSecondaryHover: UIColor {
        dynamicColor(day: UIColor.customPrimaryRefreshingOrangeTint20, night: UIColor.customPrimaryRefreshingOrangeTint20)
    }
    
    public static var componentDatavisualizeGraphTertiaryHover: UIColor {
        dynamicColor(day: UIColor.customPrimaryConfidentBlueTint20, night: UIColor.customPrimaryConfidentBlueTint20)
    }
    
    public static var componentDatavisualizeGraphDefaultHover: UIColor {
        dynamicColor(day: UIColor.customPrimaryTrustedNavyTint80, night: UIColor.customPrimaryTrustedNavyTint80)
    }
    
    public static var componentDatavisualizeGraphPrimaryOnpress: UIColor {
        dynamicColor(day: UIColor.customPrimaryTrustedNavyShade20, night: UIColor.customPrimaryTrustedNavyShade20)
    }
    
    public static var componentDatavisualizeGraphSecondaryOnpress: UIColor {
        dynamicColor(day: UIColor.customPrimaryRefreshingOrangeShade20, night: UIColor.customPrimaryRefreshingOrangeShade20)
    }
    
    public static var componentDatavisualizeGraphTertiaryOnpress: UIColor {
        dynamicColor(day: UIColor.customPrimaryConfidentBlueShade20, night: UIColor.customPrimaryConfidentBlueShade20)
    }
    
    public static var componentDatavisualizeGraphDefaultValueOnpress: UIColor {
        dynamicColor(day: UIColor.customPrimaryTrustedNavyTint40, night: UIColor.customPrimaryTrustedNavyTint40)
    }
    
    public static var componentDatavisualizeGraphDefaultValue: UIColor {
        dynamicColor(day: UIColor.customPrimaryTrustedNavyTint60, night: UIColor.customPrimaryTrustedNavyTint60)
    }

    public static var componentStatusBackgroundInformation: UIColor {
        dynamicColor(day: .secondarySkyBlue100, night: .secondarySkyBlue100)
    }

    public static var componentStatusBackgroundDefault: UIColor {
        dynamicColor(day: .secondaryGrey50, night: .secondaryGrey50)
    }

    public static var componentStatusBackgroundInformativeSpecial: UIColor {
        dynamicColor(day: .primaryTrustedNavy, night: .primaryTrustedNavy)
    }

    public static var componentStatusBackgroundSuccess: UIColor {
        dynamicColor(day: .utilityGreenSuccess100, night: .utilityGreenSuccess100)
    }

    public static var componentStatusBackgroundError: UIColor {
        dynamicColor(day: .utilityRedError100, night: .utilityRedError100)
    }

    public static var componentStatusBackgroundWarning: UIColor {
        dynamicColor(day: .utilityYellowWarning100, night: .utilityYellowWarning100)
    }

    public static var componentStatusBackgroundSpecial1: UIColor {
        dynamicColor(day: .customPrimaryRefreshingOrangeShade10, night: .customPrimaryRefreshingOrangeShade10)
    }

    public static var componentStatusDefault: UIColor {
        dynamicColor(day: .primaryHonestWhite, night: .primaryHonestWhite)
    }
    
    public static var componentStatusBackgroundWaiting: UIColor {
        dynamicColor(day: .secondaryGrey100, night: .secondaryGrey100)
    }
    
    public static var componentMustKnowBackgroundUrgent: UIColor {
        dynamicColor(day: .utilityRedError100, night: .utilityRedError100)
    }
    
    public static var componentMustKnowBackgroundWarning: UIColor {
        dynamicColor(day: .utilityYellowWarning100, night: .utilityYellowWarning100)
    }
    
    public static var componentMustKnowBackgroundSuccess: UIColor {
        dynamicColor(day: .utilityGreenSuccess100, night: .utilityGreenSuccess100)
    }
    
    public static var componentMustKnowBackgroundInformation: UIColor {
        dynamicColor(day: .secondarySkyBlue100, night: .secondarySkyBlue100)
    }
    
    public static var componentMustKnowBackgroundDisable: UIColor {
        dynamicColor(day: .secondaryGrey50, night: .secondaryGrey50)
    }
    
    public static var componentMustKnowDefault: UIColor {
        dynamicColor(day: .primaryHonestWhite, night: .primaryHonestWhite)
    }
    
    public static var componentMustKnowTextDefault: UIColor {
        dynamicColor(day: .primaryTrustedNavy, night: .primaryTrustedNavy)
    }
    
    public static var componentMustKnowDesc: UIColor {
        dynamicColor(day: .secondaryGrey100, night: .secondaryGrey100)
    }
    
    public static var componentMustKnowBackgroundDefault: UIColor {
        dynamicColor(day: .primaryHonestWhite, night: .primaryHonestWhite)
    }
    
    public static var componentMustKnowBackgroundOnPress: UIColor {
        dynamicColor(day: .secondaryGrey10, night: .secondaryGrey10)
    }
    
    public static var componentMustKnowBackgroundStackSoft: UIColor {
        dynamicColor(day: .secondaryGrey20, night: .secondaryGrey20)
    }
    
    public static var componentMustKnowBackgroundStrong: UIColor {
        dynamicColor(day: .secondaryGrey50, night: .secondaryGrey50)
    }

    public static var componentMustKnowOutline: UIColor {
        dynamicColor(day: .secondaryGrey50, night: .secondaryGrey50)
    }

    public static var componentBadgeBackground: UIColor {
        dynamicColor(day: .primaryRefreshingOrange, night: .primaryRefreshingOrange)
    }

    public static var componentBadgeLabel: UIColor {
        dynamicColor(day: .primaryHonestWhite, night: .primaryHonestWhite)
    }

    public static var componentDarkBackgroundOnPress: UIColor {
        dynamicColor(day: .customSecondarySkyBlue100Opacity30, night: .secondaryGrey50)
    }

    public static var componentPreviewFileBackground: UIColor {
        let color = UIColor(hex: "#FFFFFF")
        return dynamicColor(day: color, night: color)
    }

    public static var componentPreviewFileOutline: UIColor {
        let color = UIColor(hex: "#DFE6EC")
        return dynamicColor(day: color, night: color)
    }

    public static var componentOfferingTitle: UIColor {
        return dynamicColor(day: .primaryTrustedNavy, night: .primaryTrustedNavy)
    }

    public static var componentOfferingDesc: UIColor {
        return dynamicColor(day: .secondaryGrey70, night: .secondaryGrey70)
    }

    public static var componentOfferingValue: UIColor {
        return dynamicColor(day: .primaryTrustedNavy, night: .primaryTrustedNavy)
    }

    public static var componentOfferingOutline: UIColor {
        return dynamicColor(day: .secondaryGrey20, night: .secondaryGrey20)
    }

    public static var componentOfferingIcon: UIColor {
        return dynamicColor(day: .primaryTrustedNavy, night: .primaryTrustedNavy)
    }

    public static var componentOfferingBackground: UIColor {
        return dynamicColor(day: .primaryHonestWhite, night: .primaryHonestWhite)
    }
    
    public static var componentLightBackgroundHighlight: UIColor {
        return dynamicColor(day: .secondaryGrey10, night: .secondaryGrey10)
    }
    
    public static var componentLightBackgroundHighlightOnPress: UIColor {
        return dynamicColor(day: .secondaryGrey20, night: .secondaryGrey20)
    }
    
    public static var componentTierBackgroundBronze: UIColor {
        return dynamicColor(day: .tertiaryDarkBrown100, night: .tertiaryDarkBrown100)
    }
    
    public static var componentToggleDefault: UIColor {
        return dynamicColor(day: .primaryHonestWhite, night: .primaryHonestWhite)
    }
    
    public static var componentToggleBackgroundDefault: UIColor {
        return dynamicColor(day: .secondaryGrey50, night: .secondaryGrey50)
    }
    
    public static var componentToggleBackgroundActive: UIColor {
        return dynamicColor(day: .primaryRefreshingOrange, night: .primaryRefreshingOrange)
    }
    
    public static var componentToggleBackgroundDisable: UIColor {
        return dynamicColor(day: .secondaryGrey20, night: .secondaryGrey20)
    }
    
    public static var componentChatBackgroundButtonSecondary: UIColor {
        return dynamicColor(day: .primaryHonestWhite, night: .primaryHonestWhite)
    }
    
    public static var componentChatBackgroundButtonSecondaryOnPress: UIColor {
        return dynamicColor(day: .customPrimaryConfidentBlueTint90, night: .customPrimaryConfidentBlueTint90)
    }
    
    public static var componentChatLabelButtonSecondary: UIColor {
        return dynamicColor(day: .primaryConfidentBlue, night: .primaryConfidentBlue)
    }
    
    public static var componentChatOutlineButtonSecondary: UIColor {
        return dynamicColor(day: .primaryConfidentBlue, night: .primaryConfidentBlue)
    }
    
    public static var componentChatBackgroundMessageBox: UIColor {
        return dynamicColor(day: .secondarySkyBlue10, night: .secondarySkyBlue10)
    }
    
    public static var componentChatTextDefault: UIColor {
        return dynamicColor(day: .primaryTrustedNavy, night: .primaryTrustedNavy)
    }
    
    public static var componentChatBackgroundChat: UIColor {
        return dynamicColor(day: .secondaryGrey10, night: .secondaryGrey10)
    }
    
    public static var componentChatBackgroundChatDark: UIColor {
        return dynamicColor(day: .primaryConfidentBlue, night: .primaryConfidentBlue)
    }
    
    public static var componentChatTextOnDark: UIColor {
        return dynamicColor(day: .primaryHonestWhite, night: .primaryHonestWhite)
    }
    
    public static var componentChatDesc: UIColor {
        return dynamicColor(day: .secondaryGrey70, night: .secondaryGrey70)
    }
}
