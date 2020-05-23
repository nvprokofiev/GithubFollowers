//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-04.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func getFollowers(username: String, page: Int, completion: @escaping (Result<[Follower], ErrorMessage>)-> Void) {
        let endpoint = Endpoint.followers(username: username, page: page)
        dataTask(for: endpoint, completion: completion)
    }
    
    func getUser(username: String, completion: @escaping (Result<User, ErrorMessage>)-> Void) {
        let endpoint = Endpoint.user(username: username)
        dataTask(for: endpoint, completion: completion)
    }
}

fileprivate extension NetworkManager {
    
    private func dataTask<T: Decodable>(for endpoint: Endpoint, completion: @escaping (Result<T, ErrorMessage>) -> Void) {
        
        guard let url = URL(string: endpoint.path) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self else { return }
            
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            self.decode(from: data, to: T.self, completion: completion)
            
        }.resume()
    }
    
    private func decode<T: Decodable>(from data: Data, to type: T.Type, completion: @escaping (Result<T, ErrorMessage>)-> Void) {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decoded = try decoder.decode(T.self, from: data)
            completion(.success(decoded))
        } catch (let error){
            print(error)
            completion(.failure(.invalidData))
        }
    }
}
