//
//  EventsViewModel.swift
//  JoshuaAssessment
//
//  Created by Joshua Coetzer on 2022/09/06.
//

import Foundation

class EventsViewModel {
    public var events: [Event]?
    
    func setEvents(with events: [Event]) {
        self.events = events.sorted(by: {Date.getFromString(dateString: $0.date) < Date.getFromString(dateString: $1.date)})
    }
}
