//
//  PersistenceManager.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-15.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import Foundation

enum PersistenceAction {
    case add
    case remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    private enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateStorage(with favorite: Follower, action: PersistenceAction, completion: @escaping (ErrorMessage?) -> Void) {
        retrieveFavorites { result in
            
            switch result {
                case .failure(let error):
                    completion(error)
                case .success(var favorites):
                    switch action {
                    case .add:
                        guard !favorites.contains(favorite) else {
                            completion(.alreadySaved)
                            return
                        }
                        favorites.append(favorite)

                    case .remove:
                        favorites.removeAll(where: { $0 == favorite })
                    }
                    
                completion(save(favorites: favorites))
            }
            completion(nil)
        }
    }
    
    static func retrieveFavorites(completion: @escaping (Result<[Follower], ErrorMessage>)-> Void) {
        guard let data = PersistenceManager.defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let favorites = try JSONDecoder().decode([Follower].self, from: data)
            completion(.success(favorites))
        } catch {
            completion(.failure(.invalidData))
        }
    }
    
    static func save(favorites: [Follower])-> ErrorMessage? {
        do {
            let data = try JSONEncoder().encode(favorites)
            defaults.set(data, forKey: Keys.favorites)
        } catch {
            return ErrorMessage.unableToEncode
        }
        return nil
    }
}
