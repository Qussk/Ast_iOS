//
//  Date+.swift
//  Ast
//
//  Created by 변윤나 on 1/26/25.
//

import Foundation


extension Date {
    ///현재 월 가져오기
    public func toMonthDate() -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: currentDate)
        return "\(currentMonth)월"
    }
    
    ///현재 달의 주차 가져오기
    func toWeekOfmonth() -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        let weekOfMonth = calendar.component(.weekOfMonth, from: currentDate)
        return "\(weekOfMonth)"
    }
    
    /**
     날짜 객체에 월을 더하거나 뺌.
     - parameters:
       - months: 더하거나 뺄 월 정수 값.
     - returns: 날짜 객체.
     */
    func addMonths(_ months: Int) -> Date? {
        return add(byAdding: .month, value: months)
    }
    

}


public func getCurrentTimeIntervalSince1970() -> String {
    return "\(Date().timeIntervalSince1970)"
}

fileprivate func timeIntervalToDate(_ timeInterval: TimeInterval) -> String {
    let date = Date(timeIntervalSince1970: timeInterval)
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
    return formatter.string(from: date)
}

extension Date {
    func toFormateString(dateFormat: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .ko_KR
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.string(from: self)
    }
    
}

private extension Date {
    func add(byAdding component: Calendar.Component, value: Int) -> Date? {
        let calendar = Calendar.current
        
        guard let date = calendar.date(byAdding: component, value: value, to: self)
        else { return nil }
        
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        guard let addingDate = calendar.date(from: components)
        else { return  nil }
        
        return addingDate
    }
}
