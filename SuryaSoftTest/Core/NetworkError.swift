//
//  NetworkError.swift
//  SuryaSoftTest
//
//  Created by Satyam Sehgal on 24/11/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation

enum NetworkError {
    case networkError
    case fetchError

    var errorMessage: String {
        switch self {
        case .networkError: return "Something went wrong!"
        case .fetchError: return "Unable to Fetch!"
        }
    }
}
