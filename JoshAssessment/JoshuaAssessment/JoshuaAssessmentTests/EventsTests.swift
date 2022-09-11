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
    
    func testTitle() throws {
        group.notify(queue: .main) {
            XCTAssertEqual("Liverpool v Porto", self.systemUnderTest.events?[0].title)
        }
    }
    
    func testSubTitle() throws {
        group.notify(queue: .main) {
            XCTAssertEqual("UEFA Champions League", self.systemUnderTest.events?[0].subtitle)
        }
    }
    
    func testDate() throws {
        group.notify(queue: .main) {
            XCTAssertEqual("2022-09-07T01:19:59.687Z", self.systemUnderTest.events?[0].date)
        }
    }
    
    func testImageUrl() throws {
        group.notify(queue: .main) {
            XCTAssertEqual("https://firebasestorage.googleapis.com/v0/b/dazn-recruitment/o/310176837169_image-header_pDach_1554579780000.jpeg?alt=media&token=1777d26b-d051-4b5f-87a8-7633d3d6dd20", self.systemUnderTest.events?[0].image)
        }
    }
    
    func testVideoUrl() throws {
        group.notify(queue: .main) {
            XCTAssertEqual("https://firebasestorage.googleapis.com/v0/b/dazn-recruitment/o/310176837169_image-header_pDach_1554579780000.jpeg?alt=media&token=1777d26b-d051-4b5f-87a8-7633d3d6dd20", self.systemUnderTest.events?[0].video)
        }
    }
    
    func testAscendingOrder() throws {
        group.notify(queue: .main) {
            var inAscending = true
            for i in 0...(self.systemUnderTest.events?.count ?? 0) {
                if Date.getFromString(dateString: self.systemUnderTest.events?[i].date ?? "") >= Date.getFromString(dateString: self.systemUnderTest.events?[i + 1].date ?? "") {
                    inAscending = false
                    break
                }
            }
            XCTAssertTrue(inAscending)
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
        self.systemUnderTest.getEventsData(group: group)
    }
}
