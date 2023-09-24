//
//  MyPokemon+CoreDataProperties.swift
//  Pokemon
//
//  Created by сииас on 23/09/2023.
//
//

import Foundation
import CoreData


extension MyPokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyPokemon> {
        return NSFetchRequest<MyPokemon>(entityName: "MyPokemon")
    }

    @NSManaged public var elementType: String?
    @NSManaged public var height: Double
    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var weight: Double

}

extension MyPokemon : Identifiable {

}
