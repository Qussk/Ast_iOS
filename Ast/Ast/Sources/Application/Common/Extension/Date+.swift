//
//  Date+.swift
//  Ast
//
//  Created by 변윤나 on 1/26/25.
//

import Foundation


extension Date {
    
    public func isCurrentDate() -> String {
        let currentDate = Date()  // 현재 날짜
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: currentDate)  // 현재 월
        return "\(currentMonth)월"
    }
}
