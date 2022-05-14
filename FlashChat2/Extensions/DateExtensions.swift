//
//  DateExtensions.swift
//  FlashChat2
//
//  Created by Đỗ Trung Hoài on 14/05/2022.
//

import Foundation

public extension Date {
    func timeAgoSinceNow(numericDates: Bool = true) -> String {
        let calendar = Calendar.current
        let now = Date()
        let earliest = (now as NSDate).earlierDate(self)
        let lastest = (earliest == now) ? self : now
        let components: DateComponents = (calendar as
                                            NSCalendar).components([
                                                NSCalendar.Unit.minute,
                                                NSCalendar.Unit.hour,
                                                NSCalendar.Unit.day,
                                                NSCalendar.Unit.weekOfYear,
                                                NSCalendar.Unit.month,
                                                NSCalendar.Unit.year,
                                                NSCalendar.Unit.second
                                            ], from: earliest, to: lastest, options: NSCalendar.Options())
        guard
            let year = components.year,
            let month = components.month,
            let weekOfYear = components.weekOfYear,
            let day = components.day,
            let hour = components.hour,
            let minute = components.minute,
            let second = components.second
        else { return "Một lúc trước đó" }
        
        if year >= 1 {
            return year >= 2 ? "\(year) năm trước" : numericDates ? "1 năm trước" : "Năm trước"
        } else if month >= 1 {
            return month >= 2 ? "\(month) tháng trước" : numericDates ? "1 tháng trước" : "Tháng trước"
        } else if weekOfYear >= 1 {
            return weekOfYear >= 2 ? "\(weekOfYear) tuần trước" : numericDates ? "1 tuần trước" : "Tuần trước"
        } else if day >= 1 {
            return day >= 2 ? "\(day) ngày trước" : numericDates ? "1 ngày trước" : "Hôm qua"
        } else if hour >= 1 {
            return hour >= 2 ? "\(hour) giờ trước" : numericDates ? "1 giờ trước" : "1 giờ trước"
        } else if minute >= 1 {
            return minute >= 2 ? "\(minute) phút trước" : numericDates ? "1 phút trước" : "1 phút trước"
        } else {
            return second >= 3 ? "\(second) giây trước" : "Vừa tức thì"
        }
    }
}
