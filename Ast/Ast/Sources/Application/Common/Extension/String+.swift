//
//  String+.swift
//  Ast
//
//  Created by 변윤나 on 1/26/25.
//

import SwiftUI


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



extension String {
    ///:이 있는 경우 Text의 앞부분부터 :까지 bold처리
    func boldTextBeforeColon() -> Text {
        if let colonIndex = self.firstIndex(of: ":") {
            let boldPart = self[..<colonIndex] // 콜론 앞부분
            let remainingPart = self[colonIndex...] // 콜론 이후부분
            
            return Text(boldPart).bold() + Text(remainingPart)
        } else {
            return Text(self)
        }
    }
    
    ///"->"을 특수문자 →로 변경
    func replaceArrow() -> String {
        return self.replacingOccurrences(of: "->", with: "→")
    }

}
