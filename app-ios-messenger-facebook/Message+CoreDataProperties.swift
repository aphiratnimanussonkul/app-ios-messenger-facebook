//
//  Message+CoreDataProperties.swift
//  app-ios-messenger-facebook
//
//  Created by ODDS on 10/2/2563 BE.
//  Copyright © 2563 ODDS. All rights reserved.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var text: String?
    @NSManaged public var date: Date?
    @NSManaged public var friend: Friend?

}
