//
//  Color.swift
//  Sketch
//
//  Created by Andrii Kurshyn on 7/21/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import Foundation

/// Color wrapper UICorol for Codable
struct Color : Codable {
    
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var alpha: CGFloat = 1.0
    
    var uiColor: UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    var cgColor: CGColor {
        return uiColor.cgColor
    }
    
    init(_ color: UIColor) {
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
}
