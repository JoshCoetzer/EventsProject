//
//  ViewController.swift
//  JoshuaAssessment
//
//  Created by Joshua Coetzer on 2022/09/05.
//

import UIKit

class EventsViewController: UIViewController {
    let viewModel: EventsViewModel
    let group = DispatchGroup()

    required init?(coder aDecoder: NSCoder) {
        viewModel = EventsViewModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        group.enter()
        getEventsData()
        group.notify(queue: .main) {
            print(self.viewModel.events?.count)
        }
    }

    private func getEventsData() {
        guard let url = URL(string: String.eventsUrl) else { return }
        
        URLSession.shared.fetchEvents(at: url) { result in
            switch result {
            case .success(let events):
                self.viewModel.events = events
                self.group.leave()
            case .failure(let error):
                print(error)
            }
        }
    }
}

