//
//  SplashVC.swift
//  PercentagePlus
//
//  Created by Jason Hilimire on 3/11/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import Foundation
import  UIKit



class SplashVC: UIViewController {
    
    @IBOutlet weak var image: UIButton!
    
    @IBAction func imageBtn(_ sender: UIButton) {
        

        

    }
    
    override func viewDidLoad() {
        image.center = CGPoint(x: image.center.x + 800, y: image.center.y)
        
        UIView.animate(withDuration: 1.0, delay: 0, options: [ .curveLinear] , animations:  {
            
            self.image.center = CGPoint(x: self.image.center.x - 800, y: self.image.center.y)
        })
    }
   
    
    
    
}


