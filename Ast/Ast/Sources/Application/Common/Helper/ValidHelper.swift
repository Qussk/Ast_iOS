//
//  ValidHelper.swift
//  Ast
//
//  Created by 변윤나 on 2/13/25.
//

import Foundation


struct ValidHelper {
    func isValidBirthDate(_ dateString: String) -> Bool {
        let dateFormat = "yyyyMMdd"
        
        let regex = "^[0-9]{8}$"
        if !NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: dateString) {
            return false
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        if let _ = dateFormatter.date(from: dateString) {
            return true
        } else {
            return false
        }
    }
    
    ///시간 한자리,두자리 모두 허용(7,07,17(0))
    func isValidTime(_ timeString: String) -> Bool {
        let regex = "^(?:[0-9]|[01]\\d|2[0-3]):[0-5]\\d$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: timeString)
    }

}
