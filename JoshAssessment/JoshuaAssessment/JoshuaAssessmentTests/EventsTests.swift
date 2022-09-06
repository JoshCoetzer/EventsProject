//
//  JoshuaAssessmentTests.swift
//  JoshuaAssessmentTests
//
//  Created by Joshua Coetzer on 2022/09/05.
//

import XCTest
@testable import JoshuaAssessment

class EventsTests: XCTestCase {
    let systemUnderTest = EventsViewModel()
    let group = DispatchGroup()
    
    func testEventsNumber() throws {
        group.notify(queue: .main) {
            XCTAssertEqual(16, self.systemUnderTest.events?.count)
        }
    }

}

extension EventsTests {
    override func setUp() {
        super.setUp()
        group.enter()
        getEventsData()
    }
    
    private func getEventsData() {
        guard let url = URL(string: String.eventsUrl) else { return }
        
        URLSession.shared.fetchEvents(at: url) { result in
            switch result {
            case .success(let events):
                self.systemUnderTest.events = events
                self.group.leave()
            case .failure(let error):
                print(error)
            }
        }
    }
}
