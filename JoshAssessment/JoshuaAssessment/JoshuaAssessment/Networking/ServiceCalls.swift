//
//  ServiceCalls.swift
//  JoshuaAssessment
//
//  Created by Joshua Coetzer on 2022/09/11.
//

import Foundation

class ServiceCalls: URLSession {
    public static func fetchEvents(at url: URL, completion: @escaping (Result<[Event], Error>) -> Void) {
        shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                do {
                    let events = try JSONDecoder().decode([Event].self, from: data)
                    completion(.success(events))
                } catch let decoderError {
                    completion(.failure(decoderError))
                }
            }
        }.resume()
    }
    
    public static func fetchSchedules(at url: URL, completion: @escaping (Result<[Schedule], Error>) -> Void) {
        shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                do {
                    let schedules = try JSONDecoder().decode([Schedule].self, from: data)
                    completion(.success(schedules))
                } catch let decoderError {
                    completion(.failure(decoderError))
                }
            }
        }.resume()
    }
}
