//
//  ContactListCellModel.swift
//  SuryaSoftTest
//
//  Created by Satyam Sehgal on 24/11/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ContactListCellModel: Codable {

    var imageUrl: String
    var emailId: String
    var firstName: String
    var lastName: String

    init?(json:JSON) {
        guard let data = try? json.rawData() else {
            return nil
        }
        self = try! JSONDecoder().decode(ContactListCellModel.self, from: data)
    }

}
