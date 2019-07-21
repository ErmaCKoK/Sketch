//
//  ColorButton.swift
//  Sketch
//
//  Created by Andrii Kurshyn on 7/21/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import UIKit

class ColorButton: UIButton {
    
    var colorView = UIView()
    
    @IBInspectable var color: UIColor? {
        get { return self.colorView.backgroundColor }
        set { self.colorView.backgroundColor = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.comonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.comonInit()
    }
    
    private func comonInit() {
        colorView.frame.size = CGSize(width: self.bounds.width-20, height: self.bounds.width-20)
        colorView.center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        colorView.layer.cornerRadius = colorView.frame.size.width/2
        colorView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin,.flexibleLeftMargin,.flexibleRightMargin]
        colorView.isUserInteractionEnabled = false
        addSubview(colorView)
    }
}
