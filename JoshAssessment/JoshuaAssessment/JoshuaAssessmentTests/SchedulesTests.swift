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
    
    func testTitle() throws {
        group.notify(queue: .main) {
            XCTAssertEqual("Liverpool v Porto", self.systemUnderTest.schedules?[0].title)
        }
    }
    
    func testSubTitle() throws {
        group.notify(queue: .main) {
            XCTAssertEqual("UEFA Champions League", self.systemUnderTest.schedules?[0].subtitle)
        }
    }
    
    func testDate() throws {
        group.notify(queue: .main) {
            XCTAssertEqual("2022-09-07T01:19:59.687Z", self.systemUnderTest.schedules?[0].date)
        }
    }
    
    func testImageUrl() throws {
        group.notify(queue: .main) {
            XCTAssertEqual("https://firebasestorage.googleapis.com/v0/b/dazn-recruitment/o/310176837169_image-header_pDach_1554579780000.jpeg?alt=media&token=1777d26b-d051-4b5f-87a8-7633d3d6dd20", self.systemUnderTest.schedules?[0].image)
        }
    }
    
    func testAscendingOrder() throws {
        group.notify(queue: .main) {
            var inAscending = true
            for i in 0...(self.systemUnderTest.schedules?.count ?? 0) {
                if Date.getFromString(dateString: self.systemUnderTest.schedules?[i].date ?? "") >= Date.getFromString(dateString: self.systemUnderTest.schedules?[i + 1].date ?? "") {
                    inAscending = false
                    break
                }
            }
            XCTAssertTrue(inAscending)
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
        systemUnderTest.getSchedulesData(group: group)
    }
}

