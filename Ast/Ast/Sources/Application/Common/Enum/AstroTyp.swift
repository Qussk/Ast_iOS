//
//  AstroTyp.swift
//  Ast
//
//  Created by 변윤나 on 1/23/25.
//

import Foundation


enum AstroTyp: Int {
    case aries = 0
    case taurus
    case gemini
    case cancer
    case leo
    case virgo
    case libra
    case scorpio
    case sagittarius
    case capricorn
    case aquarius
    case pisces

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
            return "3월 21일 ~ 4월 19일"
        case .taurus:
            return "4월 20일 ~ 5월 20일"
        case .gemini:
            return "5월 21일 ~ 6월 21일"
        case .cancer:
            return "6월 22일 ~ 7월 22일"
        case .leo:
            return "7월 23일 ~ 8월 22일"
        case .virgo:
            return "8월 23일 ~ 9월 22일"
        case .libra:
            return "9월 23일 ~ 10월 23일"
        case .scorpio:
            return "10월 24일 ~ 11월 22일"
        case .sagittarius:
            return "11월 23일 ~ 12월 21일"
        case .capricorn:
            return "12월 22일 ~ 1월 19일"
        case .aquarius:
            return "1월 20일 ~ 2월 18일"
        case .pisces:
            return "2월 19일 ~ 3월 20일"
        }
    }
}

enum LeadType: String, CaseIterable {
    case daily = "일일"
    case monthly = "월간"
    case yearly = "년간"
}
