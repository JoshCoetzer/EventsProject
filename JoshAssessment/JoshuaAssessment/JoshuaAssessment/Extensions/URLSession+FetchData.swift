//
//  URLSession+FetchData.swift
//  JoshuaAssessment
//
//  Created by Joshua Coetzer on 2022/09/06.
//

import Foundation

extension URLSession {
    func fetchEvents(at url: URL, completion: @escaping (Result<[Event], Error>) -> Void) {
        self.dataTask(with: url) { (data, response, error) in
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
    
    func fetchSchedules(at url: URL, completion: @escaping (Result<[Schedule], Error>) -> Void) {
        self.dataTask(with: url) { (data, response, error) in
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
