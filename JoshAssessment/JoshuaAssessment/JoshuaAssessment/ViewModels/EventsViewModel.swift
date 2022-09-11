//
//  EventsViewModel.swift
//  JoshuaAssessment
//
//  Created by Joshua Coetzer on 2022/09/06.
//

import Foundation

class EventsViewModel {
    public var events: [Event]?
    
    private func setEvents(with events: [Event]) {
        self.events = events.sorted(by: {Date.getFromString(dateString: $0.date) < Date.getFromString(dateString: $1.date)})
    }
    
    func getEventsData(group: DispatchGroup) {
        guard let url = URL(string: URLStrings.eventsUrl.rawValue) else { return }
        
        ServiceCalls.fetchEvents(at: url) { [weak self] result in
            switch result {
            case .success(let events):
                self?.setEvents(with: events)
                group.leave()
            case .failure(let error):
                print(error)
            }
        }
    }
}
