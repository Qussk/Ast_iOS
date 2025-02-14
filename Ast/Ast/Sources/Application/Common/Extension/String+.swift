//
//  String+.swift
//  Ast
//
//  Created by 변윤나 on 1/26/25.
//

import SwiftUI
import CommonCrypto
import CryptoKit


extension String {
    ///별자리이름 -> 한글명
    func getNameDescription() -> String {
        return AstroTyp(from: self)?.description ?? ""
    }
    ///별자리이름 -> 이모지
    func getEmoji() -> String {
        return AstroTyp(from: self)?.emoji ?? ""
    }
    ///별자리 이름 -> 심볼
    func getSymbol() -> String {
        return AstroTyp(from: self)?.symbol ?? ""
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
    
    //시간 ":"삽입
//    func lastTwoCharacters() -> String {
//        guard self.count == 4 && !self.contains(":") else { return self }
//
//        var modifiedString = self
//        let insertIndex = modifiedString.index(modifiedString.endIndex, offsetBy: -2) // 뒤에서 두 번째 위치
//        modifiedString.insert(":", at: insertIndex)
//
//        return modifiedString
//    }
}


extension String {
    func sha1() -> String {
        let data = Data(self.utf8)
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        
        data.withUnsafeBytes {
            _ = CC_SHA1($0.baseAddress, CC_LONG(data.count), &digest)
        }
        
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        
        return hexBytes.joined()
    }

}

fileprivate func formatDateToString(_ date: Date, format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.locale = Locale(identifier: "ko_KR")
    return dateFormatter.string(from: date)
}

fileprivate func formatStringToFormat( _ dateString: String, from fromFormat: String, to toFormat: String, locale: Locale? = nil) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = fromFormat
    if let locale = locale {
        dateFormatter.locale = locale
    }
    if let date = dateFormatter.date(from: dateString) {
        return formatDateToString(date, format: toFormat)
    } else {
        return ""
    }
}

extension String {
    var tobirthDateDots: String {
        formatStringToFormat(self, from: "yyyyMMdd", to: "yyyy.MM.dd")
    }
}
