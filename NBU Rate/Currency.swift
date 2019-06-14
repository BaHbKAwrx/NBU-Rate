//
//  Currency.swift
//  NBU Rate
//
//  Created by Shmygovskii Ivan on 6/14/19.
//  Copyright © 2019 Shmygovskii Ivan. All rights reserved.
//

import Foundation

struct Currency: Codable {
    
    let code: String
    let name: String
    let rate: Double
    let exchangeDate: String
    
    var image: String {
        return code
    }
    
    enum CodingKeys: String, CodingKey {
        case code = "cc"
        case name = "txt"
        case exchangeDate = "exchangedate"
        case rate
    }
}
