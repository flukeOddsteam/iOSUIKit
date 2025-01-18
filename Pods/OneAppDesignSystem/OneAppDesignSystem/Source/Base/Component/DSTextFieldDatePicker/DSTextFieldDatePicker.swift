//
//  DSTextFieldDatePicker.swift
//  OneAppDesignSystem
//
//  Created by TTB on 14/1/23.
//

import UIKit

private enum Constants {
    static let numberOfLines: Int = 1
    static let borderWidthContainerView: CGFloat = 1
    static let labelTopMarginConstaint: CGFloat = 8
    static let labelCenterYConstraint: CGFloat = 0
    static let dateFormatter: String = "d MMM yy"
    static let doneButtonText: String = "Done"
    static let cancelButtonText: String = "Cancel"
}

/// Enum DSTextFieldDatePicker state
public enum DSTextFieldDatePickerState {
    /// State normal before pressing on DSTextFieldDatePicker.
    case `default`
    /// State when the text field is pressed on and focusing on DSTextFieldDatePicker.
    case focus
    /// State when the date picker is selected and done button is pressed on.
    case selected(date: Date)
    /// State error with icon alert and error message below DSTextFieldDatePicker. If there is date value, it'll be shown.
    case error(errorMessage: String, date: Date? = nil)
    /// State disable DSTextFieldDatePicker. If there is date value, it'll be shown.
    case disable(date: Date? = nil)
}

/**
    Custom component DSTextFieldDatePicker for Design System
 
    ![image](/DocumentationImages/ds-text-field-datepicker.png)

    **Usage Example:**
    1. Create UIView on .xib file and assign ` DSTextFieldDatePicker` Class to the UIView.
    2. Binding constraint and don't set `height`.
    3. Connect UIView to `@IBOutlet` in text editor.
    4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
     @IBOutlet weak var textFieldDatePicker: DSTextFieldDatePicker!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         textFieldDatePicker.delegate = self
         textFieldDatePicker.setup(tagId: 1,
                                    state: .default,
                                    helperText: "Helping text (required)")
     }
     ```
     **DSTextFieldDatePicker has 5 states:**
     - default
     - focus
     - selected
     - error
     - disable
 */
public final class DSTextFieldDatePicker: UIView {

    @IBOutlet weak var transparentButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var helperTextView: DSHelperTextView!
    @IBOutlet weak var textFieldContentView: UIView!
    @IBOutlet weak var textField: UITextFieldPadding!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var clickableIcon: DSClickableIconBadge!

    // MARK: - Private variable
    private var labelTopMargin = NSLayoutConstraint()
    private var labelCenterYConstraint = NSLayoutConstraint()
    private var dateFormatter = DateFormatter()
    private var selectedDate: Date?
    private var previousErrorText: String = ""

    let datePicker = UIDatePicker()

    private lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: leftButtonTitle,
            style: .done,
            target: self,
            action: #selector(doneDatePicker)
        )
        button.tintColor = DSColor.componentSummarySecondaryActive
        return button
    }()

    private lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: rightButtonTitle,
            style: .done,
            target: self,
            action: #selector(cancelDatePicker)
        )
        button.tintColor = DSColor.componentSummarySecondaryActive
        return button
    }()

    // MARK: - Public variable
    /// Variable for setting tag ID of DSTextFieldDatePicker.
    public var tagId: Int = 0

    /// Delegate of DSTextFieldDatePickerDelegate.
    public weak var delegate: DSTextFieldDatePickerDelegate?

    /// Variable for updating state of DSTextFieldDatePicker.
    public var state: DSTextFieldDatePickerState = .default {
        didSet {
            updateAppearance()
        }
    }

    /// Variable for check when there is text of selected date on text field of DSTextFieldDatePicker.
    public var hasSelectedDate: Bool {
        return textField.text != ""
    }

    /// Variable for displaying as a label when state there is no selected date and floating label when there is the selected date.
    public var textLabel: String = "" {
        didSet { label.text = textLabel }
    }

    /// Variable for update helper text of DSTextFieldDatePicker.
    public var helperText: String = "" {
        didSet { helperTextView.text = helperText }
    }

    /// Variable for update placeholder text of DSTextFieldDatePicker.
    public var placeholder: String = "" {
        didSet { label.text = placeholder }
    }

    /// Variable for update locale of DSTextFieldDatePicker.
    public var locale: Locale = .current {
        didSet {
            datePicker.locale = locale
            dateFormatter.locale = locale
        }
    }

    /// Variable for update calendar of DSTextFieldDatePicker.
    public var calendar: Calendar = .current {
        didSet {
            datePicker.calendar = calendar
            dateFormatter.calendar = calendar
        }
    }

    /// Variable for update timezone of DSTextFieldDatePicker.
    public var timeZone: TimeZone = .current {
        didSet {
            datePicker.timeZone = timeZone
            dateFormatter.timeZone = timeZone
        }
    }

    /// Variable for update minimum date in calendar
    public var minimumDate: Date = DatePickerConfiguration().minimumDate {
        didSet {
            datePicker.minimumDate = minimumDate
        }
    }

    /// Variable for update maximum date in calendar
    public var maximumDate: Date = DatePickerConfiguration().minimumDate {
        didSet {
            datePicker.maximumDate = maximumDate
        }
    }

    /// Variable for set left button title on toolbar. default is `Done`
    public var leftButtonTitle: String = Constants.doneButtonText {
        didSet {
            leftButton.title = leftButtonTitle
        }
    }

    /// Variable for set right button title on toolbar. default is `Cancel`
    public var rightButtonTitle: String = Constants.cancelButtonText {
        didSet {
            rightButton.title = rightButtonTitle
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    /// Setup DSTextFieldDatePicker
    ///
    /// Parameter for setup DSTextFieldDatePicker
    /// - Parameter tagId: id number of DSTextFieldDatePicker (mandatory).
    /// - Parameter state: state of DSTextFieldDatePicker (mandatory).
    /// - Parameter placeholder: text to display as the placeholder on the text field of DSTextFieldDatePicker (optional). Default is "Label".
    /// - Parameter minimumDate: specify min date. Default is 1900. When min > max, the values are ignored.
    /// - Parameter maximumDate: specify max date. Dfault is 2100. When min > max, the values are ignored.
    /// - Parameter helperText: helpertext of DSTextFieldDatePicker (optional). Default is "".
    /// - Parameter locale: locale of DSTextFieldDatePicker. Default locale is .current.
    /// - Parameter calendar: calendar of DSTextFieldDatePicker. Default calendar is  .current.
    public func setup(tagId: Int,
                      state: DSTextFieldDatePickerState,
                      placeholder: String = "",
                      minimumDate: Date? = nil,
                      maximumDate: Date? = nil,
                      helperText: String = "",
                      locale: Locale = .current,
                      calendar: Calendar = .current) {
        self.tagId = tagId
        self.placeholder = placeholder
        self.helperText = helperText
        debugPrint("test helpper TEXT: \(helperText)")
        self.state = state
        self.datePicker.locale = locale
        self.datePicker.calendar = calendar
        self.dateFormatter.calendar = calendar
        self.dateFormatter.locale = locale
        updateAppearance()

        setupRangeCalendar(minimumDate: minimumDate, maximumDate: maximumDate)
    }

    public func getSelectedDate() -> Date? {
        return self.selectedDate
    }

    public func clearSelectedDate() {
        setSelectedDate(date: nil)
        state = .default
    }

    public func setAccessibilityIdentifier(id: String? = nil,
                                           textFieldId: String? = nil,
                                           helperTextViewId: String? = nil,
                                           titleLabelId: String? = nil,
                                           clickableIconId: String? = nil) {
        self.accessibilityIdentifier = id
        textField.accessibilityIdentifier = textFieldId
        helperTextView.accessibilityIdentifier = helperTextViewId
        label.accessibilityIdentifier = titleLabelId
        clickableIcon.accessibilityIdentifier = clickableIconId
    }

}

// MARK: - Action
extension DSTextFieldDatePicker {
    @objc private func textFieldEditingDidBegin(_ textField: UITextField) {
        setupOverlay()
        updateLayout(state: .focus, isAnimate: true)
        delegate?.textFieldEditingDidBegin(self)
    }

    @objc private func textFieldEditingDidEnd(_ textField: UITextField) {
        removeOverlay()
        updateState()
        delegate?.textFieldEditingDidEnd(self)
    }

    @objc func doneDatePicker() {
        updateLayout(state: .selected(date: datePicker.date), isAnimate: true)
        contentView.endEditing(true)
        delegate?.didSelectDate(tagId: self.tagId, selectedDate: datePicker.date, textField: self)
    }

    @objc func cancelDatePicker() {
        updateState()
        self.contentView.endEditing(true)
    }

    @IBAction func pressedTransparentButton(_ sender: Any) {
        textField.becomeFirstResponder()
    }

    @IBAction func pressClickAbleIcon(_ sender: Any) {
        textField.becomeFirstResponder()
    }
}

// MARK: - Private
private extension DSTextFieldDatePicker {
    func commonInit() {
        setupXib()
        setupUI()
        setupGesture()
        setupToolBar()
        setupDatePicker()
    }

    func setupUI() {
        transparentButton.backgroundColor = .clear

        textField.font = DSFont.paragraphMedium
        textField.textColor = DSColor.componentLightDefault
        textField.inputView = datePicker
        textField.borderStyle = .none

        contentView.layer.borderWidth = Constants.borderWidthContainerView
        contentView.layer.borderColor = DSColor.componentLightOutline.cgColor
        contentView.backgroundColor = DSColor.componentLightBackground
        contentView.setRadius(radius: DSRadius.radius12px)

        label.numberOfLines = Constants.numberOfLines
        label.font = DSFont.placeholder
        label.textColor = DSColor.componentLightPlaceholder

        textField.font = DSFont.paragraphMedium
        textField.textColor = DSColor.componentLightDefault

        labelTopMargin = label.topAnchor.constraint(equalTo: textFieldContentView.topAnchor, constant: Constants.labelTopMarginConstaint)
        labelCenterYConstraint = label.centerYAnchor.constraint(equalTo: textFieldContentView.centerYAnchor, constant: Constants.labelCenterYConstraint)
        labelCenterYConstraint.isActive = true

        clickableIcon.setup(style: .normal, image: DSIcons.icon24Outlinecalendar.image)
        helperTextView.isHidden = true

        self.dateFormatter.dateFormat = Constants.dateFormatter
    }

    func setupGesture() {
        self.textField.addTarget(self, action: #selector(self.textFieldEditingDidBegin(_:)), for: .editingDidBegin)
        self.textField.addTarget(self, action: #selector(self.textFieldEditingDidEnd(_:)), for: .editingDidEnd)
    }

    func setupDatePicker() {
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
            datePicker.sizeToFit()
        }

        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                datePicker.backgroundColor = DSColor.componentOfferDesc
            } else {
                datePicker.backgroundColor = DSColor.pageLightBackground
            }
        }

        datePicker.tintColor = DSColor.componentSummarySecondaryActive
        datePicker.datePickerMode = .date
        datePicker.isMultipleTouchEnabled = true
    }

    func setupToolBar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                toolbar.barTintColor = DSColor.componentOfferDesc
            } else {
                toolbar.barTintColor = DSColor.componentSummaryBackground
            }
        }

        toolbar.setItems([leftButton, spaceButton, rightButton], animated: false)
        textField.inputAccessoryView = toolbar
    }

    func setupRangeCalendar(minimumDate: Date?, maximumDate: Date?) {
        let datePickConfiguration = DatePickerConfiguration()
        var minDate = datePickConfiguration.minimumDate
        var maxDate = datePickConfiguration.maximumDate

        if let minimumDate, let maximumDate, isValidPeriod(minimum: minimumDate, maximumDate: maximumDate) {
            minDate = minimumDate
            maxDate = maximumDate
        } else if let minimumDate, isValidPeriod(minimum: minimumDate, maximumDate: maxDate) {
            minDate = minimumDate
        } else if let maximumDate, isValidPeriod(minimum: minDate, maximumDate: maximumDate) {
            maxDate = maximumDate
        }

        self.minimumDate = minDate
        self.maximumDate = maxDate
    }

    func isValidPeriod(minimum: Date, maximumDate: Date) -> Bool {
        let dateOrdered = Calendar.current.compare(minimumDate, to: maximumDate, toGranularity: .day)
        return dateOrdered != .orderedDescending
    }

    func setSelectedDate(date: Date?) {
        selectedDate = date
        if let date = date {
            let dateString = dateFormatter.string(from: date)
            textField.text = dateString
            datePicker.date = date
        } else {
            textField.text = nil
        }
    }

    func updateAppearance() {
        contentView.layer.borderColor = state.contentViewBorderColor.cgColor
        contentView.backgroundColor = state.contentViewBackgroundColor
        transparentButton.isUserInteractionEnabled = state.transparentButtonisUserInteractionEnabled
        textFieldContentView.isUserInteractionEnabled = false

        switch self.state {
        case .default:
            labelTopMargin.isActive = false
            label.font = DSFont.placeholder
            label.textColor = DSColor.componentLightPlaceholder
            helperTextView.isHidden = helperText.isEmpty
            helperTextView.isError = false
            helperTextView.text = helperText
            clickableIcon.iconImageView.tintColor = DSColor.componentLightDefault
            transparentButton.isUserInteractionEnabled = true
        case .focus:
            labelTopMargin.isActive = hasSelectedDate
            label.font = hasSelectedDate ? DSFont.labelInput : DSFont.placeholder
            label.textColor = hasSelectedDate ? DSColor.componentLightLabel : DSColor.componentLightPlaceholder
            textField.tintColor = .clear
            clickableIcon.iconImageView.tintColor = DSColor.componentLightDefault
            helperTextView.isHidden = helperTextView.isError

        case .selected(let date):
            labelTopMargin.isActive = true
            label.font = DSFont.labelInput
            label.textColor = DSColor.componentLightLabel
            textField.font = DSFont.paragraphMedium
            textField.textColor = DSColor.componentLightDefault
            helperTextView.isHidden = helperText.isEmpty
            helperTextView.isError = false
            helperTextView.text = helperText
            clickableIcon.iconImageView.tintColor = DSColor.componentLightDefault

            setSelectedDate(date: date)
        case .error(let errorMessage, let date):

            labelTopMargin.isActive = hasSelectedDate
            label.font = hasSelectedDate ? DSFont.labelInput : DSFont.placeholder
            label.textColor = hasSelectedDate ? DSColor.componentLightLabel : DSColor.componentLightPlaceholder
            helperTextView.isHidden = false
            helperTextView.text = errorMessage
            helperTextView.isError = true
            clickableIcon.iconImageView.tintColor = DSColor.componentLightDefault

            previousErrorText = errorMessage
            setSelectedDate(date: date)
        case .disable(let date):
            labelTopMargin.isActive = !date.isNull
            label.font = date.isNull ? DSFont.placeholder : DSFont.labelInput
            label.textColor = date.isNull ? DSColor.componentLightPlaceholder : DSColor.componentLightLabel
            textField.textColor = date.isNull ? DSColor.componentLightPlaceholder : DSColor.componentLightLabel
            contentView.isUserInteractionEnabled = false
            helperTextView.isHidden = helperText.isEmpty
            helperTextView.isError = false
            helperTextView.text = helperText
            clickableIcon.iconImageView.tintColor = DSColor.componentDisableDefault
            setSelectedDate(date: date)
        }

        labelCenterYConstraint.isActive = !labelTopMargin.isActive
    }

    func updateLayout(state: DSTextFieldDatePickerState, isAnimate: Bool = false) {
        self.state = state
        performAnimation(animated: isAnimate,
                         interval: 0.2) {
            self.contentView.layoutIfNeeded()
        }
    }

    func setupOverlay() {
        guard let window = UIApplication.getWindow() else { return }

        let overlayView = UIView(frame: .zero)
        overlayView.backgroundColor = DSColor.otherBackgroundOverlayScreen
        overlayView.restorationIdentifier = "overlay.view.id"
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        window.addSubview(overlayView)

        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: window.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: window.bottomAnchor)
        ])
    }

    func removeOverlay() {
        guard let window = UIApplication.getWindow() else { return }

        if let overlayView = window.subviews.first(where: { view in
            view.restorationIdentifier == "overlay.view.id"
        }) {
            overlayView.removeFromSuperview()
        }
    }

    func updateState() {
        if helperTextView.isError {
            updateLayout(state: .error(errorMessage: previousErrorText, date: getSelectedDate()), isAnimate: true)
        } else {
            let state: DSTextFieldDatePickerState = self.hasSelectedDate ? .selected(date: self.selectedDate ?? Date()) : .default
            updateLayout(state: state, isAnimate: true)
        }
    }
}
