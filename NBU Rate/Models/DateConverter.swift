//
//  DateConverter.swift
//  NBU Rate
//
//  Created by Shmygovskii Ivan on 6/15/19.
//  Copyright © 2019 Shmygovskii Ivan. All rights reserved.
//

import Foundation

struct DateConverter {
    
    // func to convert date object to string like "20190615" (to pass it to url)
    static func toURLFormat(with date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        
        let formattedDate = formatter.string(from: date)
        let dateArray = formattedDate.components(separatedBy: ".")
        let urlDate = dateArray[0] + dateArray[1] + dateArray[2]
        return urlDate
    }
    
    // func to convert string to date
    static func dateFromString(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.date(from: dateString)
        return date!
    }
    
    // func to get previous dates (for historic requests)
    static func getPreviousDate(withOffset days: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.setValue(-days, for: .day)
        let now = Date()
        let newDate = Calendar.current.date(byAdding: dateComponents, to: now)
        return newDate!
    }
    
    // func to get day in int formate from current date
    static func getDay(from date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: date)
    }
}
