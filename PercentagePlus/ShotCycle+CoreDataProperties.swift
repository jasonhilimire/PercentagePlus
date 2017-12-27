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
    @NSManaged public var shootingPercentage: Int16
    @NSManaged public var upperLeftHitCount: Int16
    @NSManaged public var upperRightHitCount: Int16
    @NSManaged public var bottomRightHitCount: Int16
    @NSManaged public var bottomLeftHitCount: Int16
    @NSManaged public var fiveHoleHitCount: Int16
    @NSManaged public var totalHitCount: Int16

}
