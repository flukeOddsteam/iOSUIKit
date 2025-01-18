//
//  Font+Extension.swift
//  ComponentTest
//
//  Created by TTB on 17/2/2564 BE.
//

#if os(OSX)
import AppKit.NSFont
public typealias Font = NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
import UIKit.UIFont
public typealias Font = UIFont
#endif

// MARK: - FontFamily
public enum FontFamily {
    public enum OneApp {
		// MARK: - Italic
        public static let italic = FontConvertible(
			name: "Ekachon-Italic",
			family: "Ekachon",
			path: "Ekachon-Italic.ttf"
		)
		// MARK: - Bold
        public static let bold = FontConvertible(
			name: "Ekachon-Bold",
			family: "Ekachon",
			path: "Ekachon-Bold.ttf"
		)
        public static let boldItalic = FontConvertible(
			name: "Ekachon-BoldItalic",
			family: "Ekachon",
			path: "Ekachon-BoldItalic.ttf"
		)
		// MARK: - ExtraLight
        public static let extraLight = FontConvertible(
			name: "Ekachon-ExtraLight",
			family: "Ekachon",
			path: "Ekachon-ExtraLight.ttf"
		)
        public static let extraLightItalic = FontConvertible(
			name: "Ekachon-ExtraLightItalic",
			family: "Ekachon",
			path: "Ekachon-ExtraLightItalic.ttf"
		)
		// MARK: - Light
        public static let light = FontConvertible(
			name: "Ekachon-Light",
			family: "Ekachon",
			path: "Ekachon-Light.ttf"
		)
        public static let lightItalic = FontConvertible(
			name: "Ekachon-LightItalic",
			family: "Ekachon",
			path: "Ekachon-LightItalic.ttf"
		)
		// MARK: - Regular
        public static let regular = FontConvertible(
			name: "Ekachon-Regular",
			family: "Ekachon",
			path: "Ekachon-Regular.ttf"
		)
		// MARK: - Medium
        public static let medium = FontConvertible(
			name: "Ekachon-Medium",
			family: "Ekachon",
			path: "Ekachon-Medium.ttf"
		)
        public static let mediumItalic = FontConvertible(
			name: "Ekachon-MediumItalic",
			family: "Ekachon",
			path: "Ekachon-MediumItalic.ttf"
		)
        public static let all: [FontConvertible] = [
			italic,
			bold,
			boldItalic,
			extraLight,
			extraLightItalic,
			light,
			lightItalic,
			regular,
			medium,
			mediumItalic
		]
	}
    public static let allCustomFonts: [FontConvertible] = [OneApp.all].flatMap { $0 }
    public static func registerAllCustomFonts() {
		allCustomFonts.forEach { $0.register() }
	}
}

// MARK: - Implementation FontConvertible
public struct FontConvertible {
    public let name: String
    public let family: String
    public let path: String

    public func font(size: CGFloat) -> Font {
		return Font(font: self, size: size)
	}

    public func register() {
		guard let url = url else { return }
		CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
	}

	fileprivate var url: URL? {
		let bundle = BundleToken.bundle
		return bundle.url(forResource: path, withExtension: nil)
	}
}

extension Font {
    public convenience init!(font: FontConvertible, size: CGFloat) {
	#if os(iOS) || os(tvOS) || os(watchOS)
	if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
	  font.register()
	}
	#elseif os(OSX)
	if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
	  font.register()
	}
	#endif

	self.init(name: font.name, size: size)
  }
}

private final class BundleToken {
  static let bundle: Bundle = {
	Bundle(for: BundleToken.self)
  }()
}

extension UIFont {
	public static var specialH1ForAccountSummaryPageNavyRight: UIFont? {
		return FontFamily.OneApp.bold.font(size: 28)
	}

	public static var specialH1ForAccountSummaryPageNavyLeft: UIFont? {
		return FontFamily.OneApp.bold.font(size: 28.0)
	}

	public static var specialH1ForAccountSummaryPageNavyCenter: UIFont? {
		return FontFamily.OneApp.bold.font(size: 28.0)
	}

	public static var specialH1ForAccountSummaryPageWhiteCenter: UIFont? {
		return FontFamily.OneApp.bold.font(size: 28.0)
	}

	public static var specialH1ForAccountSummaryPageWhiteRight: UIFont? {
		return FontFamily.OneApp.bold.font(size: 28.0)
	}

	public static var specialH1ForAccountSummaryPageWhiteLeft: UIFont? {
		return FontFamily.OneApp.bold.font(size: 28.0)
	}

	public static var h1WhiteRight: UIFont? {
		return FontFamily.OneApp.bold.font(size: 24.0)
	}

	public static var h1WhiteCenter: UIFont? {
		return FontFamily.OneApp.bold.font(size: 24.0)
	}

	public static var h1WhiteLeft: UIFont? {
		return FontFamily.OneApp.bold.font(size: 24.0)
	}

	public static var h1NavyRight: UIFont? {
		return FontFamily.OneApp.bold.font(size: 24.0)
	}
	
	public static var buttonNumericKeyboard: UIFont? {
		return FontFamily.OneApp.light.font(size: 24.0)
	}

	public static var subDeseNavyRight: UIFont? {
		return FontFamily.OneApp.regular.font(size: 18.0)
	}

	public static var h1NavyCenter: UIFont? {
		return FontFamily.OneApp.bold.font(size: 24.0)
	}

	public static var h1NavyLeft: UIFont? {
		return FontFamily.OneApp.bold.font(size: 24.0)
	}

	public static var buttonBigWhiteCenter: UIFont? {
		return FontFamily.OneApp.bold.font(size: 20.0)
	}

	public static var buttonBigWhiteCenter3: UIFont? {
		return FontFamily.OneApp.bold.font(size: 20.0)
	}

	public static var buttonBigDisabledRight: UIFont? {
		return FontFamily.OneApp.bold.font(size: 20.0)
	}

	public static var buttonBigDisabledCenter: UIFont? {
		return FontFamily.OneApp.bold.font(size: 20.0)
	}

	public static var buttonBigDisabledLeft: UIFont? {
		return FontFamily.OneApp.bold.font(size: 20.0)
	}

	public static var buttonBigOrangeRight: UIFont? {
		return FontFamily.OneApp.bold.font(size: 20.0)
	}

	public static var buttonBigOrangeCenter: UIFont? {
		return FontFamily.OneApp.bold.font(size: 20.0)
	}

	public static var buttonBigOrangeLeft: UIFont? {
		return FontFamily.OneApp.bold.font(size: 20.0)
	}

	public static var buttonBigWhiteRight: UIFont? {
		return FontFamily.OneApp.bold.font(size: 20.0)
	}

	public static var buttonBigWhiteLeft: UIFont? {
		return FontFamily.OneApp.bold.font(size: 20.0)
	}

	public static var h2WhiteRight: UIFont? {
		return FontFamily.OneApp.bold.font(size: 20.0)
	}

	public static var h2WhiteCenter: UIFont? {
		return FontFamily.OneApp.bold.font(size: 20.0)
	}

	public static var h2WhiteLeft: UIFont? {
		return FontFamily.OneApp.bold.font(size: 20.0)
	}

	public static var h2NavyRight: UIFont? {
		return FontFamily.OneApp.bold.font(size: 20.0)
	}

	public static var h2NavyCenter: UIFont? {
		return FontFamily.OneApp.bold.font(size: 20.0)
	}

	public static var h2NavyLeft: UIFont? {
		return FontFamily.OneApp.bold.font(size: 20.0)
	}

	public static var buttonBigNavyRight: UIFont? {
		return FontFamily.OneApp.bold.font(size: 18.0)
	}

	public static var buttonBigNavyCenter: UIFont? {
		return FontFamily.OneApp.bold.font(size: 18.0)
	}

	public static var buttonBigNavyLeft: UIFont? {
		return FontFamily.OneApp.bold.font(size: 18.0)
	}

	public static var paragraphBigDisabledCenter: UIFont? {
		return FontFamily.OneApp.regular.font(size: 18.0)
	}

	public static var paragraphBigDisabledLeft: UIFont? {
		return FontFamily.OneApp.regular.font(size: 18.0)
	}

	public static var paragraphBigWhiteRight: UIFont? {
		return FontFamily.OneApp.regular.font(size: 18.0)
	}

	public static var paragraphBigWhiteCenter: UIFont? {
		return FontFamily.OneApp.regular.font(size: 18.0)
	}

	public static var paragraphBigWhiteLeft: UIFont? {
		return FontFamily.OneApp.regular.font(size: 18.0)
	}

	public static var paragraphBigGreyRight: UIFont? {
		return FontFamily.OneApp.regular.font(size: 18.0)
	}

	public static var paragraphBigGreyCenter: UIFont? {
		return FontFamily.OneApp.regular.font(size: 18.0)
	}

	public static var paragraphBigGreyLeft: UIFont? {
		return FontFamily.OneApp.regular.font(size: 18.0)
	}

	public static var paragraphBigNavyRight: UIFont? {
		return FontFamily.OneApp.regular.font(size: 18.0)
	}

	public static var paragraphBigNavyCenter: UIFont? {
		return FontFamily.OneApp.regular.font(size: 18.0)
	}

	public static var paragraphBigNavyLeft: UIFont? {
		return FontFamily.OneApp.regular.font(size: 18.0)
	}

	public static var h3GreenRight: UIFont? {
		return FontFamily.OneApp.bold.font(size: 16.0)
	}

	public static var h3GreenCenter: UIFont? {
		return FontFamily.OneApp.bold.font(size: 16.0)
	}

	public static var h3GreenLeft: UIFont? {
		return FontFamily.OneApp.bold.font(size: 16.0)
	}

	public static var h3RedRight: UIFont? {
		return FontFamily.OneApp.bold.font(size: 16.0)
	}

	public static var h3RedCenter: UIFont? {
		return FontFamily.OneApp.bold.font(size: 16.0)
	}

	public static var h3RedLeft: UIFont? {
		return FontFamily.OneApp.bold.font(size: 16.0)
	}

	public static var h3WhiteRight: UIFont? {
		return FontFamily.OneApp.bold.font(size: 16.0)
	}

	public static var h3WhiteCenter: UIFont? {
		return FontFamily.OneApp.bold.font(size: 16.0)
	}

	public static var h3WhiteLeft: UIFont? {
		return FontFamily.OneApp.bold.font(size: 16.0)
	}

	public static var h3NavyRight: UIFont? {
		return FontFamily.OneApp.bold.font(size: 16.0)
	}

	public static var h3NavyCenter: UIFont? {
		return FontFamily.OneApp.bold.font(size: 16.0)
	}

	public static var h3NavyLeft: UIFont? {
		return FontFamily.OneApp.bold.font(size: 16.0)
	}

	public static var paragraphSmallDisabledRight: UIFont? {
		return FontFamily.OneApp.regular.font(size: 16.0)
	}

	public static var paragraphSmallDisabledCenter: UIFont? {
		return FontFamily.OneApp.regular.font(size: 16.0)
	}

	public static var paragraphSmallDisabledLeft: UIFont? {
		return FontFamily.OneApp.regular.font(size: 16.0)
	}

	public static var paragraphSmallWhiteRight: UIFont? {
		return FontFamily.OneApp.regular.font(size: 16.0)
	}

	public static var paragraphSmallWhiteCenter: UIFont? {
		return FontFamily.OneApp.regular.font(size: 16.0)
	}

	public static var paragraphSmallWhiteLeft: UIFont? {
		return FontFamily.OneApp.regular.font(size: 16.0)
	}

	public static var paragraphSmallGreyRight: UIFont? {
		return FontFamily.OneApp.regular.font(size: 16.0)
	}

	public static var paragraphSmallGreyCenter: UIFont? {
		return FontFamily.OneApp.regular.font(size: 16.0)
	}

	public static var paragraphSmallGreyLeft: UIFont? {
		return FontFamily.OneApp.regular.font(size: 16.0)
	}

	public static var paragraphSmallNavyRight: UIFont? {
		return FontFamily.OneApp.regular.font(size: 16.0)
	}

	public static var paragraphSmallNavyCenter: UIFont? {
		return FontFamily.OneApp.regular.font(size: 16.0)
	}

	public static var paragraphSmallNavyLeft: UIFont? {
		return FontFamily.OneApp.regular.font(size: 16.0)
	}

	public static var buttonSmallDisabledRight: UIFont? {
		return FontFamily.OneApp.bold.font(size: 14.0)
	}

	public static var buttonSmallDisabledCenter: UIFont? {
		return FontFamily.OneApp.bold.font(size: 14.0)
	}

	public static var buttonSmallDisabledLeft: UIFont? {
		return FontFamily.OneApp.bold.font(size: 14.0)
	}

	public static var buttonSmallOrangeRight: UIFont? {
		return FontFamily.OneApp.bold.font(size: 14.0)
	}

	public static var buttonSmallOrangeCenter: UIFont? {
		return FontFamily.OneApp.bold.font(size: 14.0)
	}

	public static var buttonSmallOrangeLeft: UIFont? {
		return FontFamily.OneApp.bold.font(size: 14.0)
	}

	public static var buttonSmallWhiteRight: UIFont? {
		return FontFamily.OneApp.bold.font(size: 14.0)
	}

	public static var buttonSmallWhiteCenter: UIFont? {
		return FontFamily.OneApp.bold.font(size: 14.0)
	}

	public static var buttonSmallWhiteLeft: UIFont? {
		return FontFamily.OneApp.bold.font(size: 14.0)
	}

	public static var buttonSmallNavyRight: UIFont? {
		return FontFamily.OneApp.bold.font(size: 14.0)
	}

	public static var buttonSmallNavyCenter: UIFont? {
		return FontFamily.OneApp.bold.font(size: 14.0)
	}

	public static var buttonSmallNavyLeft: UIFont? {
		return FontFamily.OneApp.bold.font(size: 14.0)
	}

	public static var subtitleDisabledRight: UIFont? {
		return FontFamily.OneApp.regular.font(size: 14.0)
	}

	public static var subtitleDisabledCenter: UIFont? {
		return FontFamily.OneApp.regular.font(size: 14.0)
	}

	public static var subtitleDisabledLeft: UIFont? {
		return FontFamily.OneApp.regular.font(size: 14.0)
	}

	public static var subtitleWhiteRight: UIFont? {
		return FontFamily.OneApp.regular.font(size: 14.0)
	}

	public static var subtitleWhiteCenter: UIFont? {
		return FontFamily.OneApp.regular.font(size: 14.0)
	}

	public static var subtitleWhiteLeft: UIFont? {
		return FontFamily.OneApp.regular.font(size: 14.0)
	}

	public static var subtitleGreyRight: UIFont? {
		return FontFamily.OneApp.regular.font(size: 14.0)
	}

	public static var subtitleGreyCenter: UIFont? {
		return FontFamily.OneApp.regular.font(size: 14.0)
	}

	public static var subtitleGreyLeft: UIFont? {
		return FontFamily.OneApp.regular.font(size: 14.0)
	}

	public static var subtitleNavyRight: UIFont? {
		return FontFamily.OneApp.regular.font(size: 14.0)
	}

	public static var subtitleNavyCenter: UIFont? {
		return FontFamily.OneApp.regular.font(size: 14.0)
	}

	public static var subtitleNavyLeft: UIFont? {
		return FontFamily.OneApp.regular.font(size: 14.0)
	}

	public static var labelWhiteRight: UIFont? {
		return FontFamily.OneApp.medium.font(size: 12.0)
	}

	public static var labelWhiteCenter: UIFont? {
		return FontFamily.OneApp.medium.font(size: 12.0)
	}

	public static var labelWhiteLeft: UIFont? {
		return FontFamily.OneApp.medium.font(size: 12.0)
	}

	public static var labelWhiteLeft14: UIFont? {
		return FontFamily.OneApp.medium.font(size: 14.0)
	}

	public static var leadingWhiteRight: UIFont? {
		return FontFamily.OneApp.regular.font(size: 12.0)
	}

	public static var leadingWhiteCenter: UIFont? {
		return FontFamily.OneApp.regular.font(size: 12.0)
	}

	public static var leadingWhiteLeft: UIFont? {
		return FontFamily.OneApp.regular.font(size: 12.0)
	}

	public static var leadingDisabledRight: UIFont? {
		return FontFamily.OneApp.regular.font(size: 12.0)
	}

	public static var leadingDisabledCenter: UIFont? {
		return FontFamily.OneApp.regular.font(size: 12.0)
	}

	public static var leadingDisabledLeft: UIFont? {
		return FontFamily.OneApp.regular.font(size: 12.0)
	}

	public static var labelDisabledRight: UIFont? {
		return FontFamily.OneApp.regular.font(size: 12.0)
	}

	public static var labelDisabledCenter: UIFont? {
		return FontFamily.OneApp.regular.font(size: 12.0)
	}

	public static var labelDisabledLeft: UIFont? {
		return FontFamily.OneApp.regular.font(size: 12.0)
	}

	public static var leadingGreyRight: UIFont? {
		return FontFamily.OneApp.regular.font(size: 12.0)
	}

	public static var leadingGreyCenter: UIFont? {
		return FontFamily.OneApp.regular.font(size: 12.0)
	}

	public static var leadingGreyLeft: UIFont? {
		return FontFamily.OneApp.regular.font(size: 12.0)
	}

	public static var labelGreyRight: UIFont? {
		return FontFamily.OneApp.regular.font(size: 12.0)
	}

	public static var labelGreyCenter: UIFont? {
		return FontFamily.OneApp.regular.font(size: 12.0)
	}

	public static var labelGreyLeft: UIFont? {
		return FontFamily.OneApp.regular.font(size: 12.0)
	}

	public static var labelNavyRight: UIFont? {
		return FontFamily.OneApp.regular.font(size: 12.0)
	}

	public static var labelNavyCenter: UIFont? {
		return FontFamily.OneApp.regular.font(size: 12.0)
	}

	public static var labelNavyLeft: UIFont? {
		return FontFamily.OneApp.regular.font(size: 12.0)
	}
}
