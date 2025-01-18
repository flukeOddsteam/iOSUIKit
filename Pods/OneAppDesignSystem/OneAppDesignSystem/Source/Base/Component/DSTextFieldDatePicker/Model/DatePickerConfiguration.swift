//
//  DatePickerConfiguration.swift
//  OneAppDesignSystem
//
//  Created by TTB on 21/12/2566 BE.
//

import Foundation

struct DatePickerConfiguration {
    let minimumDate: Date
    let maximumDate: Date

    init() {
        let calendar: Calendar = Calendar(identifier: .gregorian)
        let minimumComponent = DateComponents(calendar: calendar, year: 1900, month: 1, day: 1)
        let maximumComponent = DateComponents(calendar: calendar, year: 2100, month: 12, day: 31)

        guard let minDate = minimumComponent.date, let maxDate = maximumComponent.date else {
            fatalError("Invalid date")
        }

        minimumDate = minDate
        maximumDate = maxDate
    }
}
