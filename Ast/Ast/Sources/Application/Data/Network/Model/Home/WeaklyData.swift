//
//  WeaklyData.swift
//  Ast
//
//  Created by 변윤나 on 1/28/25.
//

import Foundation


struct LeadWeaklyModel {
    let idx: Int
    let title: String
    let acticle: [Weak]
    
    init(idx: Int, title: String, acticle: [Weak]) {
        self.idx = idx
        self.title = title
        self.acticle = acticle
    }
}

struct Weak {
    let subTitle: String
    let contents: [String]
    let subContents: [String]
    
    init(subTitle: String, contents: [String], subContents: [String]) {
        self.subTitle = subTitle
        self.contents = contents
        self.subContents = subContents
    }
}

//Mock

