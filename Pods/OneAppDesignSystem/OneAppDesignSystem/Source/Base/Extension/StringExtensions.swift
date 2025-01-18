import UIKit

extension String {
    var isNumeric: Bool {
        return self.matchRegEx(pattern: "^[\\d\\.]")
    }
    
    var isZero: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0"]
        return Set(self).isSubset(of: nums)
    }
    
    var removeCommas: String {
        let str = self.replacingOccurrences(of: ",", with: "")
        return str
    }
    
    var removeZero: String {
        let str = self.replacingOccurrences(of: "^0+", with: "", options: .regularExpression)
        return str
    }
    
    var toAmountFormat: String {
        let numberFormatterService: NumberFormatterServiceInterface = NumberFormatterService(maximumFractionDigits: 2, minimumFractionDigits: 2)
        return numberFormatterService.formatAmountString(self)
    }

    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data,
                                          options: [
                                            .documentType: NSAttributedString.DocumentType.html,
                                            .characterEncoding: String.Encoding.utf8.rawValue
                                          ],
                                          documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    static func getWidth(string: String, withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = string.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
    func maxLength(length: Int) -> String {
        var str = self
        let nsString = str as NSString
        if nsString.length >= length {
            str = nsString.substring(with:
                                        NSRange(
                                            location: 0,
                                            length: nsString.length > length ? length : nsString.length)
            )
        }
        return str
    }
    
    func matchRegEx(pattern: String, justMatch: Bool? = true) -> Bool {
        do {
            let range = NSRange(self.startIndex..<self.endIndex, in: self)
            let option: NSRegularExpression.Options = (justMatch ?? true) ? .caseInsensitive : .anchorsMatchLines
            let regex = try NSRegularExpression(pattern: pattern, options: option)
            let result = regex.firstMatch(in: self, options: [], range: range)
            return result != nil
        } catch {
            return false
        }
    }
    
    func idConcatenation(_ row: String) -> String {
        guard self.isNotEmpty else { return "" }
        return self + "_" + row
    }
    
    func heightLayout(withConstrainedWidth width: CGFloat, font: UIFont?) -> CGFloat {
        guard let font = font else { return CGFloat(0) }
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        
        return ceil(boundingBox.height)
    }
}
