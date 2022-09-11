//
//  ScheduleViewModel.swift
//  JoshuaAssessment
//
//  Created by Joshua Coetzer on 2022/09/06.
//

import Foundation

class ScheduleViewModel {
    public var schedules: [Schedule]?
    
    private func setSchedules(with schedules: [Schedule]) {
        self.schedules = schedules.sorted(by: {Date.getFromString(dateString: $0.date) < Date.getFromString(dateString: $1.date)})
    }
    
    func getSchedulesData(group: DispatchGroup) {
        guard let url = URL(string: URLStrings.schedulesUrl.rawValue) else { return }
        
        ServiceCalls.fetchSchedules(at: url) { [weak self] result in
            switch result {
            case .success(let schedules):
                self?.setSchedules(with: schedules)
                group.leave()
            case .failure(let error):
                print(error)
            }
        }
    }
}
