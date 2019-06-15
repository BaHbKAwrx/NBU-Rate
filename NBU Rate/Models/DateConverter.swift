//
//  DateConverter.swift
//  NBU Rate
//
//  Created by Shmygovskii Ivan on 6/15/19.
//  Copyright © 2019 Shmygovskii Ivan. All rights reserved.
//

import Foundation

struct DateConverter {
    
    static func toURLFormat(with date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        
        let formattedDate = formatter.string(from: date)
        let dateArray = formattedDate.components(separatedBy: ".")
        let urlDate = dateArray[0] + dateArray[1] + dateArray[2]
        return urlDate
    }
}
