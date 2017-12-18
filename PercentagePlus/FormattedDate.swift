//
//  DateFormatter.swift
//  BarDown
//
//  Created by Jason Hilimire on 12/17/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import Foundation

class FormattedDate {
    
    var formattedDate: String {
        get {
            return dateFormatter()
        }
    }
    
    var date = NSDate()
    
    func dateFormatter() -> String{
        let currentDate = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        
        let dateString = formatter.string(from: currentDate as Date)
        print("\(dateString)")
        return dateString
        
    }
    
    
    init?(date: NSDate) {
        self.date = date
    }
}
