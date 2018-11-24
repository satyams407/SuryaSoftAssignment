//
//  FetchContactServiceProtocol.swift
//  SuryaSoftTest
//
//  Created by Satyam Sehgal on 24/11/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation

protocol FetchContactProtocol {
     func fetchContacts(_ url: URL, params: [String: String], completion: @escaping (NetworkResult) -> Void)
}
