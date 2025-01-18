//
//  DSDatePicker.swift
//  OneAppDesignSystem
//
//  Created by TTB on 17/1/23.
//

import UIKit

private enum Constants {
    static let orderedDescending: String = "DESCENDING"
    static let orderedAscending: String = "ASCENDING"
    static let orderedSame: String = "SAME"
    static let startDateLabel: String = "Start Date"
    static let endDateLabel: String = "End Date"
}

/// Enum DSDatePicker type.
public enum DSDatePickerType {
    /// Single type has only one item of DSTextFieldDatePicker.
    case single
    /// Period type has 2 items of DSTextFieldDatePicker for start date and end date.
    case period
}

/// Delegate for DSDatePicker
public protocol DSDatePickerDelegate: AnyObject {
    func didSelectStartDate(tagId: Int, selectedDate: Date, textField: DSTextFieldDatePicker)
    func didSelectEndDate(tagId: Int, selectedDate: Date, textField: DSTextFieldDatePicker)
}

/**
    Custom component DSDatePicker for Design System
 
    ![image](/DocumentationImages/ds-datepicker.png)

    **Usage Example:**
    1. Create UIView on .xib file and assign ` DSDatePicker` Class to the UIView.
    2. Binding constraint and don't set `height`.
    3. Connect UIView to `@IBOutlet` in text editor.
    4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
     @IBOutlet weak var datePicker: DSDatePicker!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         datePicker.delegate = self
         datePicker.setup(tagId: 1, type: .single, startDateLabel: "Label")
     }
     ```
     **DSDatePicker has 2 types:**
     - single: There is only one item of DSTextFieldDatePicker.
     - period: There are 2 items of DSTextFieldDatePicker which is for start date and end date. End date DSTextFieldDatePicker will be disable until start date DSTextFieldDatePicker is selected.
 */
public final class DSDatePicker: UIView {

    @IBOutlet public weak var textFieldDatePickerStart: DSTextFieldDatePicker!
    @IBOutlet public weak var textFieldDatePickerEnd: DSTextFieldDatePicker!

    // MARK: - Private Variable
    private var startDateLabel: String = ""
    private var endDateLabel: String = ""
    private var startDateHelperText: String = ""
    private var endDateHelperText: String = ""
    
    private var type: DSDatePickerType = .period {
        didSet {
            updateAppearance()
        }
    }
    
    // MARK: - Public Variable
    /// Variable for set tag ID of DSDatePicker.
    public var tagId: Int = 0
    
    /// Delegate of DSDatePicker.
    public weak var delegate: DSDatePickerDelegate?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// Setup DSDatePicker
    ///
    /// Parameter for setup DSDatePicker
    /// - Parameter tagId: id number of DSDatePicker (mandatory).
    /// - Parameter type: type of DSDatePicker (mandatory).
    /// - Parameter startDateLabel: text to display as the placeholder on the text field start date of DSDatePicker (optional). Default is "".
    /// - Parameter endDateLabel: text to display as the placeholder on the text field end date of DSDatePicker (optional). Default is "".
    /// - Parameter startDateHelperText: helpertext of start date (optional). Default is "".
    /// - Parameter endDateHelperText:helpertext od end date (optional). Default is "".
    /// - Parameter minimumDate: specify min date. Default is nil. When min > max, the values are ignored.
    /// - Parameter maximumDate: specify max date. Dfault is nil. When min > max, the values are ignored.
    /// - Parameter locale: locale of DSTextFieldDatePicker. Default locale is .current.
    /// - Parameter calendar: calendar of DSTextFieldDatePicker. Default calendar is  .current.
    public func setup(tagId: Int,
                      type: DSDatePickerType,
                      startDateLabel: String = "",
                      endDateLabel: String = "",
                      startDateHelperText: String = "",
                      endDateHelperText: String = "",
                      minimumDate: Date? = nil,
                      maximumDate: Date? = nil,
                      locale: Locale = .current,
                      calendar: Calendar = .current) {
        self.tagId = tagId
        self.startDateLabel = startDateLabel
        self.endDateLabel = endDateLabel
        self.startDateHelperText = startDateHelperText
        self.endDateHelperText = endDateHelperText
        self.type = type

        let datePickerConfiguration = DatePickerConfiguration()
        let minDate = minimumDate ?? datePickerConfiguration.minimumDate
        let maxDate = maximumDate ?? datePickerConfiguration.maximumDate

        textFieldDatePickerStart.setup(
            tagId: 1,
            state: .default,
            placeholder: startDateLabel,
            minimumDate: minDate,
            maximumDate: maxDate,
            helperText: startDateHelperText,
            locale: locale,
            calendar: calendar
        )

        textFieldDatePickerEnd.setup(
            tagId: 2,
            state: .default,
            placeholder: endDateLabel,
            minimumDate: minDate,
            maximumDate: maxDate,
            helperText: endDateHelperText,
            locale: locale,
            calendar: calendar
        )
    }

    public func setAccessibilityIdentifier(
        id: String? = nil,
        datePickerStartId: String? = nil,
        textFieldStartId: String? = nil,
        helperTextViewStartId: String? = nil,
        titleLabelStartId: String? = nil,
        clickableIconStartId: String? = nil,
        datePickerEndId: String? = nil,
        textFieldEndId: String? = nil,
        helperTextViewEndId: String? = nil,
        titleLabelEndId: String? = nil,
        clickableIconEndId: String? = nil
    ) {
        self.accessibilityIdentifier = id
        textFieldDatePickerStart.accessibilityIdentifier = datePickerStartId
        textFieldDatePickerStart.textField.accessibilityIdentifier = textFieldStartId
        textFieldDatePickerStart.helperTextView.accessibilityIdentifier = helperTextViewStartId
        textFieldDatePickerStart.label.accessibilityIdentifier = titleLabelStartId
        textFieldDatePickerStart.clickableIcon.accessibilityIdentifier = clickableIconStartId
        textFieldDatePickerEnd.accessibilityIdentifier = datePickerEndId
        textFieldDatePickerEnd.textField.accessibilityIdentifier = textFieldEndId
        textFieldDatePickerEnd.helperTextView.accessibilityIdentifier = helperTextViewEndId
        textFieldDatePickerEnd.label.accessibilityIdentifier = titleLabelEndId
        textFieldDatePickerEnd.clickableIcon.accessibilityIdentifier = clickableIconEndId
    }
}

// MARK: - DSTextFieldDatePickerDelegate
extension DSDatePicker: DSTextFieldDatePickerDelegate {
    public func didSelectDate(tagId: Int, selectedDate: Date, textField: DSTextFieldDatePicker) {
        let comparingResult = self.comparingDate(startDate: textFieldDatePickerStart.getSelectedDate() ?? Date(), endDate: textFieldDatePickerEnd.getSelectedDate() ?? Date())
        switch tagId {
        case 1:
            textFieldDatePickerEnd.state = textFieldDatePickerEnd.hasSelectedDate ? .selected(date: textFieldDatePickerEnd.getSelectedDate() ?? Date()) : .default
            if textFieldDatePickerEnd.hasSelectedDate {
                if comparingResult == .orderedDescending {
                    textFieldDatePickerEnd.clearSelectedDate()
                }
            }
            delegate?.didSelectStartDate(tagId: self.tagId, selectedDate: selectedDate, textField: textField)
        case 2:
            if comparingResult == .orderedDescending {
                textFieldDatePickerStart.clearSelectedDate()
            }
            delegate?.didSelectEndDate(tagId: self.tagId, selectedDate: selectedDate, textField: textField)
        default: break
        }
    }
}

// MARK: - Private
private extension DSDatePicker {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        textFieldDatePickerStart.delegate = self
        textFieldDatePickerEnd.delegate = self
        textFieldDatePickerStart.setup(tagId: 1, state: .default)
        textFieldDatePickerEnd.setup(tagId: 2, state: .disable())
    }
    
    func updateAppearance() {
        textFieldDatePickerStart.helperTextView.isHidden = startDateHelperText.isEmpty
        textFieldDatePickerStart.helperText = startDateHelperText
        
        switch type {
        case .single:
            textFieldDatePickerEnd.isHidden = true
            textFieldDatePickerStart.textLabel = self.startDateLabel
        case .period:
            textFieldDatePickerEnd.isHidden = false
            textFieldDatePickerStart.textLabel = self.startDateLabel.isEmpty ? Constants.startDateLabel : self.startDateLabel
            textFieldDatePickerEnd.textLabel = self.endDateLabel.isEmpty ? Constants.endDateLabel : self.endDateLabel
            textFieldDatePickerEnd.helperTextView.isHidden = endDateHelperText.isEmpty
            textFieldDatePickerEnd.helperText = endDateHelperText
        }
    }
    
    func comparingDate(startDate: Date, endDate: Date) -> ComparisonResult {
        return Calendar.current.compare(startDate, to: endDate, toGranularity: .day)
    }
}
