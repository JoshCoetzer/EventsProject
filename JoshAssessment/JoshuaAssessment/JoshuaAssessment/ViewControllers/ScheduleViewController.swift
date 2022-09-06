//
//  ScheduleViewController.swift
//  JoshuaAssessment
//
//  Created by Joshua Coetzer on 2022/09/05.
//

import UIKit

class ScheduleViewController: UIViewController {
    let viewModel: ScheduleViewModel
    let group = DispatchGroup()
    
    required init?(coder aDecoder: NSCoder) {
        viewModel = ScheduleViewModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        group.enter()
        getSchedulesData()
        group.notify(queue: .main) {
            print(self.viewModel.schedules?.count)
        }
    }
    
    private func getSchedulesData() {
        guard let url = URL(string: String.eventsUrl) else { return }
        
        URLSession.shared.fetchSchedules(at: url) { result in
            switch result {
            case .success(let schedules):
                self.viewModel.schedules = schedules
                self.group.leave()
            case .failure(let error):
                print(error)
            }
        }
    }
}
