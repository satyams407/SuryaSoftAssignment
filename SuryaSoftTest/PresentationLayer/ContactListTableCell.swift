//
//  ContactListTableCell.swift
//  SuryaSoftTest
//
//  Created by Satyam Sehgal on 24/11/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation
import UIKit

class ContactListTableCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var emailId: UILabel!
    @IBOutlet weak var contactImageView: UIImageView!

    var contact: Contact? {
        didSet {
            updateCell()
        }
    }

    func updateCell() {
        name.text = (contact?.firstName)! + " " + (contact?.lastName)!
        emailId.text = contact?.emailId
        contactImageView.downloadFromLink(link: (contact?.imageUrl) ?? "", contentMode: .scaleToFill)
    }
}
