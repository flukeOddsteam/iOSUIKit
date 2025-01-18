//
//  NumberFormatterService.swift
//  OneAppDesignSystem
//
//  Created by TTB on 23/1/23.
//

import UIKit

protocol NumberFormatterServiceInterface {
    func updateFractionDigits(maximumFractionDigits: Int, minimumFractionDigits: Int)
    func formatAmountString(_ amount: String?) -> String
    func isAmountNumberFormatted(input: String?, maxLength: Int?, digits: Int) -> Bool
    func isValidNumber(inputString: String, textField: UITextField, range: NSRange, string: String, maxLength: Int?) -> Bool
}

final class NumberFormatterService {
    
    private lazy var formatter: NumberFormatter = {
        let format = NumberFormatter()
        format.locale = Locale(identifier: "en_US")
        format.groupingSize = 3
        format.decimalSeparator = "."
        format.maximumFractionDigits = self.maximumFractionDigits
        format.minimumFractionDigits = self.minimumFractionDigits
        format.groupingSeparator = ","
        format.usesGroupingSeparator = true
        return format
    }()

    private var maximumFractionDigits: Int
    private var minimumFractionDigits: Int

    init(maximumFractionDigits: Int, minimumFractionDigits: Int) {
        self.maximumFractionDigits = maximumFractionDigits
        self.minimumFractionDigits = minimumFractionDigits
    }
}

extension NumberFormatterService: NumberFormatterServiceInterface {
    func updateFractionDigits(maximumFractionDigits: Int, minimumFractionDigits: Int) {
        self.maximumFractionDigits = maximumFractionDigits
        self.minimumFractionDigits = minimumFractionDigits
    }

    func formatAmountString(_ amount: String?) -> String {
        guard let amount = amount else {
            return ""
        }
        let number = NSDecimalNumber(string: amount)
        return formatter.string(from: number) ?? ""
    }
    
    func isAmountNumberFormatted(input: String?,
                                 maxLength: Int?,
                                 digits: Int) -> Bool {
        guard let input = input, input.isNotEmpty else { return true }
        
        let countDot = input.filter({ $0 == "." }).count
        let isHasDot = countDot > 1
        guard isHasDot.revert else { return false }
        
        let inputSplit = input.components(separatedBy: ".")
        let numberPart = inputSplit.first ?? ""
        if let maximumInputLength = maxLength {
            let isInputGreeterThanMaxLength = numberPart.count > maximumInputLength
            guard isInputGreeterThanMaxLength.revert else { return false }
        }
       
        if inputSplit.count > 1 {
            let digit = inputSplit.last ?? ""
            if digit.count > 2 {
                return false
            }
        }
        return true
    }
    
    func isValidNumber(inputString: String,
                       textField: UITextField,
                       range: NSRange,
                       string: String,
                       maxLength: Int?) -> Bool {
        
        let isValidInput = inputString.isNumeric && inputString.isNotEmpty
        if !isValidInput {
            let textFieldValue = textField.text as? NSString
            if textFieldValue?.substring(with: range) == "," {
                textField.moveCursorPositionOneToTheLeft()
                return false
            }
            return true
        }
        
        if let oldString = textField.text,
           let replacingRange = Range(range, in: oldString) {
            let newString = oldString.replacingCharacters(in: replacingRange, with: inputString)
            let newStringWithoutComma = newString.removeCommas
            
            let isAmountNumberFormatted = isAmountNumberFormatted(input: newStringWithoutComma,
                                                                  maxLength: maxLength,
                                                                  digits: 2)
            
            guard isAmountNumberFormatted else { return false }
            
            if string == "," {
                textField.text = newStringWithoutComma
            }
            
            return true
        }
        
        return false
    }
}
