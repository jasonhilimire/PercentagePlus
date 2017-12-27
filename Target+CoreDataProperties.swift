//
//  Target+CoreDataProperties.swift
//  BarDown
//
//  Created by Jason Hilimire on 12/26/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//
//

import Foundation
import CoreData


extension Target {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Target> {
        return NSFetchRequest<Target>(entityName: "Target")
    }

    @NSManaged public var hitCount: Int16
    @NSManaged public var name: String?

}
