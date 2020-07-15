//
//  User+CoreDataClass.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Codable {

    @NSManaged public var userId: Int32
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var website: String?
    @NSManaged public var phone: String?

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(userId, forKey: .userId)
            try container.encode(name, forKey: .name)
            try container.encode(email, forKey: .email)
            try container.encode(website, forKey: .website)
            try container.encode(phone, forKey: .phone)
        }
        catch {
            debugPrint(error)
        }
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: Constants.Entities.user, in: managedObjectContext) else {
            fatalError("Fail to decode User")
        }
        self.init(entity: entity, insertInto: managedObjectContext)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userId = try container.decode(Int32.self, forKey: .userId)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        website = try container.decodeIfPresent(String.self, forKey: .website)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case name, email, website, phone
    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}
