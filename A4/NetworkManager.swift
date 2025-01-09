//
//  NetworkManager.swift
//  A4
//
//  Created by Archita Nemalikanti on 11/24/24.
//

import Alamofire
import Foundation
import UIKit

class NetworkManager {
    /// Shared singleton instance
    static let shared = NetworkManager()
    
    // Prevent other instances from being created
    private init() { }
    
    func fetchRecipes(completion: @escaping ([Recipe]) -> Void) {
        // 2. Specify the endpoint
        let endpoint = "https://api.jsonbin.io/v3/b/64d033f18e4aa6225ecbcf9f?meta=false"
        
        // 3. Create a decoder
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601 // Only if needed
        decoder.keyDecodingStrategy = .convertFromSnakeCase // Only if needed
        
        // 4. Create the request
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: [Recipe].self, decoder: decoder) { response in
            // 5. Handle the response
                switch response.result {
                case .success(let recipes):
                    print("Successfully fetched \(recipes.count) recipes")
                    completion(recipes)
                case .failure(let error):
                    print("Error in NetworkManager.fetchRoster: \(error)")
                }
            }
    }
}
