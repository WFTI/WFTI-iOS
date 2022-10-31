//
//  Date.swift
//  TabSample
//
//  Created by yeongbin ro on 2022/10/29.
//

import Foundation

extension Date {
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: self)
    }
    
    public var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    public var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    public var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    func getDayOfWeek() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEEEE"
        formatter.locale = Locale(identifier:"ko_KR")
        let convertStr = formatter.string(from: self)
        return convertStr
    }

    
    
    public var monthName: String {
        let nameFormatter = DateFormatter()
        nameFormatter.dateFormat = "MMMM" // format January, February, March, ...
        return nameFormatter.string(from: self)
    }
    
}

