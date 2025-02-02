//
//  Font+.swift
//  Ast
//
//  Created by 변윤나 on 1/22/25.
//

import SwiftUI
import UIKit


extension Font {
    static var h1: Font {
        return bold(size: 20)
    }
    
    static var h2: Font {
        return bold(size: 18)
    }
    
    static var h3: Font {
        return regular(size: 18)
    }
    
    static var h4: Font {
        return bold(size: 16)
    }
    
    static var h5: Font {
        return regular(size: 16)
    }
    
    static var h6: Font {
        return bold(size: 14)
    }
    
    static var h7: Font {
        return medium(size: 14)
    }
    
    static var h8: Font {
        return regular(size: 14)
    }

    static var h9: Font {
        return bold(size: 12)
    }

    static var h10: Font {
        return medium(size: 16)
    }
    
    static var l1: Font {
        return light(size: 12)
    }
    
    static var l2: Font {
        return light(size: 14)
    }

    static var l3: Font {
        return light(size: 16)
    }

    static var tiny1: Font {
        return regular(size: 10)
    }

    static var tiny2: Font {
        return regular(size: 12)
    }

    static var tiny3: Font {
        return regular(size: 14)
    }

    static var c1: Font {
        return medium(size: 12)
    }
    
    static var c2: Font {
        return bold(size: 10)
    }
    
    static var c3: Font {
        return bold(size: 12)
    }

    static var s1: Font {
        return bold(size: 24)
    }
    
    static var s2: Font {
        return bold(size: 36)
    }
    
    static var s3: Font {
        return light(size: 36)
    }

    
    static func bold(size: CGFloat) -> Font {
        return Font.custom("SpoqaHanSansNeo-Bold", size: size)
    }
    
    static func medium(size: CGFloat) -> Font {
        return Font.custom("SpoqaHanSansNeo-Medium", size: size)
    }
    
    static func regular(size: CGFloat) -> Font {
        return Font.custom("SpoqaHanSansNeo-Regular", size: size)
    }
    
    static func light(size: CGFloat) -> Font {
        return Font.custom("SpoqaHanSansNeo-Light", size: size)
    }
}



//MARK: UIKit
extension UIFont {
    static var h1: UIFont {
        return bold(size: 20)
    }
    
    static var h2: UIFont {
        return bold(size: 18)
    }
    
    static var h3: UIFont {
        return regular(size: 18)
    }
    
    static var h4: UIFont {
        return bold(size: 16)
    }
    
    static var h5: UIFont {
        return regular(size: 16)
    }
    
    static var h6: UIFont {
        return bold(size: 14)
    }
    
    static var h7: UIFont {
        return medium(size: 14)
    }
    
    static var h8: UIFont {
        return regular(size: 14)
    }
    
    static var c1: UIFont {
        return medium(size: 12)
    }
    
    static var c2: UIFont {
        return bold(size: 10)
    }
    
    static var s1: UIFont {
        return bold(size: 24)
    }
    
    static var s2: UIFont {
        return bold(size: 36)
    }
    
    static var s3: UIFont {
        return light(size: 36)
    }
    
    static func bold(size: CGFloat) -> UIFont {
        if let customFont = UIFont(name: "SpoqaHanSansNeo-Bold", size: size) {
            return customFont
        }
        else {
            return systemFont(ofSize: size)
        }
    }
    
    static func medium(size: CGFloat) -> UIFont {
        if let customFont = UIFont(name: "SpoqaHanSansNeo-Medium", size: size) {
            return customFont
        }
        else {
            return systemFont(ofSize: size)
        }
    }
    
    static func regular(size: CGFloat) -> UIFont {
        if let customFont = UIFont(name: "SpoqaHanSansNeo-Regular", size: size) {
            return customFont
        }
        else {
            return systemFont(ofSize: size)
        }
    }
    
    static func light(size: CGFloat) -> UIFont {
        if let customFont = UIFont(name: "SpoqaHanSansNeo-Light", size: size) {
            return customFont
        }
        else {
            return systemFont(ofSize: size)
        }
    }
}
