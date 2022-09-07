//
//  ScheduleViewModel.swift
//  JoshuaAssessment
//
//  Created by Joshua Coetzer on 2022/09/06.
//

import Foundation

class ScheduleViewModel {
    public var schedules: [Schedule]?
    
    func setSchedules(with schedules: [Schedule]) {
        self.schedules = schedules.sorted(by: {Date.getFromString(dateString: $0.date) < Date.getFromString(dateString: $1.date)})
    }
}
