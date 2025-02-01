//
//  TestEntity.swift
//  Ast
//
//  Created by 변윤나 on 2/1/25.
//

import Foundation



struct TestEntity: Decodable, Hashable {
    let field1: String
    let field2: String
    let numnerAsInt: String
    
    init(field1: String, field2: String, numnerAsInt: String) {
        self.field1 = field1
        self.field2 = field2
        self.numnerAsInt = numnerAsInt
    }
}

