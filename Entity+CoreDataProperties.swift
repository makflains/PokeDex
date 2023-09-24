//
//  Entity+CoreDataProperties.swift
//  Pokemon
//
//  Created by сииас on 24/09/2023.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var name: String?
    @NSManaged public var elementType: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var weight: Float
    @NSManaged public var height: Float

}

extension Entity : Identifiable {

}
