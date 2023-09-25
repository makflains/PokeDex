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

    @NSManaged public var elementType: String?
    @NSManaged public var height: Float
    @NSManaged public var id: UUID?
    @NSManaged public var imageURL: String?
    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var weight: Float

    convenience init(pokemon: Pokemon, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = pokemon.id
        self.name = pokemon.name
        self.elementType = pokemon.types
        self.height = Float(pokemon.height)
        self.weight = Float(pokemon.weight)
        self.imageURL = pokemon.imageUrl
        self.url = pokemon.url
    }
}

extension Entity : Identifiable {

}
