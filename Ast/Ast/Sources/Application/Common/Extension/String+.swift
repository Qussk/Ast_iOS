//
//  String+.swift
//  Ast
//
//  Created by 변윤나 on 1/26/25.
//

import Foundation


extension String {
    //별자리이름 -> 한글명
    func getNameDescription() -> String {
        return AstroTyp(from: self)?.description ?? ""
    }
    //별자리이름 -> 이모지 변경
    func getEmoji() -> String {
        return AstroTyp(from: self)?.emoji ?? ""
    }
}
