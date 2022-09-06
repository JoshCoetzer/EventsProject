//
//  Schedule.swift
//  JoshuaAssessment
//
//  Created by Joshua Coetzer on 2022/09/06.
//

import Foundation

struct Schedule: Decodable {
    let id: String
    let title: String
    let subtitle: String
    let date: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case image = "imageUrl"
        case id, title, subtitle, date
    }
}
