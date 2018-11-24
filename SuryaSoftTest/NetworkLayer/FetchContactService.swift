//
//  FetchContactService.swift
//  SuryaSoftTest
//
//  Created by Satyam Sehgal on 21/11/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation
import SwiftyJSON

enum NetworkResult {
    case success(JSON)
    case failure(NetworkError)
}

class FetchContactService: FetchContactProtocol {

    private let session = URLSession.shared

    func fetchContacts(_ url: URL, params: [String: String], completion: @escaping (NetworkResult) -> Void) {
        var request = URLRequest(url: url)
        if let httpBody =  try? JSONSerialization.data(withJSONObject: params, options: []) {
            request.httpBody = httpBody
        }
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        session.dataTask(with: request) { (data, response, error) -> Void  in
            guard let data = data else {
                completion (NetworkResult.failure(NetworkError.fetchError))
                return
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completion (NetworkResult.failure(NetworkError.networkError))
                return
            }

            do {
                let json = try JSON(data: data)
                DispatchQueue.main.async {
                    completion(NetworkResult.success(json))
                }
            }
            catch( _) {
                DispatchQueue.main.async {
                    completion(NetworkResult.failure(NetworkError.fetchError))
                }
            }
        }.resume()
    }
}
