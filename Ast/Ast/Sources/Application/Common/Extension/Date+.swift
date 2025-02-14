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

