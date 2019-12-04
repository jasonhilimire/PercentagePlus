//
//  CustomSlider.swift
//  BarDown
//
//  Created by Jason Hilimire on 12/3/19.
//  Copyright © 2019 Peanut Apps. All rights reserved.
//

import UIKit

@IBDesignable
class CustomSlider: UISlider {

    @IBInspectable var thumbImage: UIImage? {
        didSet {
            setThumbImage(thumbImage, for: .normal)
        }
    }
    
    @IBInspectable var thumbHighlightImage: UIImage? {
        didSet {
            setThumbImage(thumbHighlightImage, for: .highlighted)
        }
    }

}
