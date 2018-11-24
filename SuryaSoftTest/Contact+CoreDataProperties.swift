//
//  Contact+CoreDataProperties.swift
//  
//
//  Created by Satyam Sehgal on 24/11/18.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var emailId: String?
    @NSManaged public var firstName: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var lastName: String?

}
