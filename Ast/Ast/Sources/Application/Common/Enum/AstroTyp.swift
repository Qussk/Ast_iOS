//
//  AstroTyp.swift
//  Ast
//
//  Created by 변윤나 on 1/23/25.
//

import Foundation


enum AstroTyp: String, CaseIterable {
    case aries, taurus, gemini, cancer, leo, virgo, libra, scorpio, sagittarius, capricorn, aquarius, pisces

    var description: String {
        switch self {
        case .aries:
            return "양자리"
        case .taurus:
            return "황소자리"
        case .gemini:
            return "쌍둥이자리"
        case .cancer:
            return "게자리"
        case .leo:
            return "사자자리"
        case .virgo:
            return "처녀자리"
        case .libra:
            return "천칭자리"
        case .scorpio:
            return "전갈자리"
        case .sagittarius:
            return "사수자리"
        case .capricorn:
            return "염소자리"
        case .aquarius:
            return "물병자리"
        case .pisces:
            return "물고기자리"
        }
    }
    
    var date: String {
        switch self {
        case .aries:
            return "3/21 ~ 4/19"
        case .taurus:
            return "4/20 ~ 5/20"
        case .gemini:
            return "5/21 ~ 6/21"
        case .cancer:
            return "6/22 ~ 7/22"
        case .leo:
            return "7/23 ~ 8/22"
        case .virgo:
            return "8/23 ~ 9/22"
        case .libra:
            return "9/23 ~ 10/23"
        case .scorpio:
            return "10/24 ~ 11/22"
        case .sagittarius:
            return "11/23 ~ 12/21"
        case .capricorn:
            return "12/22 ~ 1/19"
        case .aquarius:
            return "1/20 ~ 2/18"
        case .pisces:
            return "2/19 ~ 3/20"
        }
    }
    
    var emoji: String {
        switch self {
        case .aries:
            return "🐑"
        case .taurus:
            return "🐮"
        case .gemini:
            return "👯"
        case .cancer:
            return "🦀"
        case .leo:
            return "🦁"
        case .virgo:
            return "🧝🏻‍♀️"
        case .libra:
            return "⚖️"
        case .scorpio:
            return "🦂"
        case .sagittarius:
            return "🏹"
        case .capricorn:
            return "🐐"
        case .aquarius:
            return "🏺"
        case .pisces:
            return "🐟"
        }
    }
    
    var symbol: String {
        switch self {
        case .aries:
            return "♈️"
        case .taurus:
            return "♉️"
        case .gemini:
            return "♊️"
        case .cancer:
            return "♊️"
        case .leo:
            return "♌️"
        case .virgo:
            return "♍️"
        case .libra:
            return "♎️"
        case .scorpio:
            return "♏️"
        case .sagittarius:
            return "♐️"
        case .capricorn:
            return "♑️"
        case .aquarius:
            return "♒️"
        case .pisces:
            return "♓️"
        }
    }
        
    static func getZodiacSign(birthDate: String) -> AstroTyp? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        guard let date = dateFormatter.date(from: birthDate) else { return nil }
        
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        // 별자리 계산
        switch (month, day) {
        case (3, 21...31), (4, 1...19): return .aries
        case (4, 20...30), (5, 1...20): return .taurus
        case (5, 21...31), (6, 1...20): return .gemini
        case (6, 21...30), (7, 1...22): return .cancer
        case (7, 23...31), (8, 1...22): return .leo
        case (8, 23...31), (9, 1...22): return .virgo
        case (9, 23...30), (10, 1...22): return .libra
        case (10, 23...31), (11, 1...21): return .scorpio
        case (11, 22...30), (12, 1...21): return .sagittarius
        case (12, 22...31), (1, 1...19): return .capricorn
        case (1, 20...31), (2, 1...18): return .aquarius
        case (2, 19...29), (3, 1...20): return .pisces
        default: return nil
        }
    }
    
    init?(from string: String) {
        self.init(rawValue: string.lowercased())
    }
}

enum LeadType: String, CaseIterable {
    case daily = "일일"
    case weakly = "주간"
    case monthly = "월간"
    case yearly = "년간"
}


struct CalendarType {
    enum Season: String {
        case winter = "❄️"
        case spring = "🌿"
        case cherryBlossom = "🌸"
        case summer = "🌻"
        case vacation = "⛱️"
        case lateSummer = "🎻"
        case autumn = "🍂"
        case christmas = "🎄"
        case none = ""

        static func currentSeason() -> Season {
            let month = Calendar.current.component(.month, from: Date())

            switch month {
            case 1, 2:
                return .winter
            case 3 :
                return .cherryBlossom
            case 4, 5 :
                return .spring
            case 6, 7 :
                return .summer
            case 8 :
                return .vacation
            case 9, 10 :
                return .lateSummer
            case 11:
                return .autumn
            case 12 :
                return .christmas
            default:
                return .none //지정하지 않음.
            }
        }
    }

}
