//
//  Shooter+CoreDataProperties.swift
//  BarDown
//
//  Created by Jason Hilimire on 10/26/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//
//

import Foundation
import CoreData


extension Shooter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shooter> {
        return NSFetchRequest<Shooter>(entityName: "Shooter")
    }

    @NSManaged public var name: String?
    @NSManaged public var shotCycles: NSOrderedSet?

}

// MARK: Generated accessors for shotCycles
extension Shooter {

    @objc(insertObject:inShotCyclesAtIndex:)
    @NSManaged public func insertIntoShotCycles(_ value: ShotCycle, at idx: Int)

    @objc(removeObjectFromShotCyclesAtIndex:)
    @NSManaged public func removeFromShotCycles(at idx: Int)

    @objc(insertShotCycles:atIndexes:)
    @NSManaged public func insertIntoShotCycles(_ values: [ShotCycle], at indexes: NSIndexSet)

    @objc(removeShotCyclesAtIndexes:)
    @NSManaged public func removeFromShotCycles(at indexes: NSIndexSet)

    @objc(replaceObjectInShotCyclesAtIndex:withObject:)
    @NSManaged public func replaceShotCycles(at idx: Int, with value: ShotCycle)

    @objc(replaceShotCyclesAtIndexes:withShotCycles:)
    @NSManaged public func replaceShotCycles(at indexes: NSIndexSet, with values: [ShotCycle])

    @objc(addShotCyclesObject:)
    @NSManaged public func addToShotCycles(_ value: ShotCycle)

    @objc(removeShotCyclesObject:)
    @NSManaged public func removeFromShotCycles(_ value: ShotCycle)

    @objc(addShotCycles:)
    @NSManaged public func addToShotCycles(_ values: NSOrderedSet)

    @objc(removeShotCycles:)
    @NSManaged public func removeFromShotCycles(_ values: NSOrderedSet)

}
