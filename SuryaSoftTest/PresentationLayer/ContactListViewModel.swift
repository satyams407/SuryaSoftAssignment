//
//  ViewModel.swift
//  SuryaSoftTest
//
//  Created by Satyam Sehgal on 21/11/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation

class ContactListViewModel {

    func validateEmail(data: String?) -> Bool {
        guard let email = data else {
            return false
        }

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
