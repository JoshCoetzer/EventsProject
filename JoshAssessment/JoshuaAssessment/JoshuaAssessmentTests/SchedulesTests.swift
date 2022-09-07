//
//  SchedulesTests.swift
//  JoshuaAssessmentTests
//
//  Created by Joshua Coetzer on 2022/09/06.
//

import XCTest
@testable import JoshuaAssessment

class SchedulesTests: XCTestCase {
    let systemUnderTest = ScheduleViewModel()
    let group = DispatchGroup()
    
    func testSchedulesNumber() throws {
        group.notify(queue: .main) {
            XCTAssertEqual(16, self.systemUnderTest.schedules?.count)
        }
    }

}

extension SchedulesTests {
    override func setUp() {
        super.setUp()
        group.enter()
        getSchedulesData()
    }
    
    private func getSchedulesData() {
        guard let url = URL(string: String.schedulesUrl) else { return }
        
        URLSession.shared.fetchSchedules(at: url) { result in
            switch result {
            case .success(let schedules):
                self.systemUnderTest.setSchedules(with: schedules)
                self.group.leave()
            case .failure(let error):
                print(error)
            }
        }
    }
}

