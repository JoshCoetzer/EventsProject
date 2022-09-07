//
//  Date+GetFromString.swift
//  JoshuaAssessment
//
//  Created by Joshua Coetzer on 2022/09/07.
//

import Foundation

extension Date {
    static func getFromString(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" //"2022-09-08T03:52:01.197Z"
        guard let date = dateFormatter.date(from: dateString) else { return Date() }
        return date
    }
}
