//
//  TimeUtils.swift
//  News
//
//  Created by Ivan Depolo on 02/12/2018.
//  Copyright © 2018 Ivan Depolo. All rights reserved.
//

import Foundation

fileprivate struct Constants{
    static let cetTimezone = "CET"
    static let displayTimeFormat = "yyyy-MM-dd HH:mm:ss"
    static let serverTimeFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
}

func reformat( time : String) -> String {
    let date = stringToDate(fromString: time)
    if let converted = date?.convertToLocalTime(fromTimeZone: Constants.cetTimezone){
        return dateToString(fromDate: converted)
    }
    return "" // should be refactored since an empty string fallback is not good practise
}

func dateToString(fromDate date: Date) -> String {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = Constants.displayTimeFormat
    
    return dateFormatter.string(from: date)
}

func stringToDate(fromString string: String) -> Date? {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = Constants.serverTimeFormat
    
    return dateFormatter.date(from: string)
}

extension Date {
    func convertToLocalTime(fromTimeZone timeZoneAbbreviation: String) -> Date? {
        if let timeZone = TimeZone(abbreviation: timeZoneAbbreviation) {
            let targetOffset = TimeInterval(timeZone.secondsFromGMT(for: self))
            let localOffeset = TimeInterval(TimeZone.autoupdatingCurrent.secondsFromGMT(for: self))
            
            return self.addingTimeInterval(targetOffset - localOffeset)
        }
        
        return nil
    }
}
