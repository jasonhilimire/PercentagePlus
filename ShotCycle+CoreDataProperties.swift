//
//  ShotCycle+CoreDataProperties.swift
//  BarDown
//
//  Created by Jason Hilimire on 12/26/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//
//

import Foundation
import CoreData


extension ShotCycle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShotCycle> {
        return NSFetchRequest<ShotCycle>(entityName: "ShotCycle")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var shots: Int16

}
