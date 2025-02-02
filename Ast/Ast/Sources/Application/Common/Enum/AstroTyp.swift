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
