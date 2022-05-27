//
//  Petition.swift
//  Project7
//
//  Created by SEONG YEOL YI on 2022/01/03.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}

struct Petitions: Codable {
    var results: [Petition]
}
