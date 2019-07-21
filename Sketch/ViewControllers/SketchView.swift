//
//  SketchView.swift
//  Sketch
//
//  Created by Andrii Kurshyn on 7/18/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import UIKit

protocol SketchViewDrawingDelegate: class {
    func drawingStroke(in sketchView: SketchView, with particle: StrokeParticle) -> Stroke?
    func sketchView(_ sketchView: SketchView, endDraw stroke: Stroke)
}

class SketchView: UIView {
    
    weak var drawingDelegate: SketchViewDrawingDelegate?
    
    var strokes = [Stroke]() {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    private var drawingStroke: Stroke?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor.clear
    }

    // MARK: Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let particle = strokeParticle(with: touch)
        
        guard let stroke = self.drawingDelegate?.drawingStroke(in: self, with: particle) else { return }
        
        self.drawingStroke = stroke
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard
            let touch = touches.first,
            let drawingStroke = self.drawingStroke
        else {
            return
        }
        
        let particle = strokeParticle(with: touch)
        drawingStroke.particles.append(particle)
        
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard
            let touch = touches.first,
            let drawingStroke = self.drawingStroke
        else {
            return
        }
        
        let particle = strokeParticle(with: touch)
        drawingStroke.particles.append(particle)
        
        self.drawingDelegate?.sketchView(self, endDraw: drawingStroke)
        self.drawingStroke = nil
        self.setNeedsDisplay()
    }
    
    private func strokeParticle(with touch: UITouch) -> StrokeParticle {
        let location = touch.location(in: self)
        return StrokeParticle(location: location, force: touch.force == 0 ? 1 : touch.force)
    }

}

// MARK - Public methods

extension SketchView {
    
    func getImage() -> UIImage {
        
        UIGraphicsBeginImageContext(frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}

// MARK: - Drawing methods.

extension SketchView {
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()!
        
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        
        // Optimization opportunity: Draw the existing strokes in a different view or user cache image,
        // and only draw each time we add a stroke.
        for stroke in self.strokes {
            draw(stroke, in: context)
        }
        
        if let stroke = self.drawingStroke {
            draw(stroke, in: context)
        }
    }
    
}

// MARK: Draw stroke

private extension SketchView {
    
    func draw(_ stroke: Stroke, in context: CGContext) {
        
        context.setStrokeColor(stroke.color.cgColor)
        
        var preprevious: StrokeParticle?
        for i in 1..<stroke.particles.count {
            let previous = stroke.particles[i-1]
            let current = stroke.particles[i]
            preprevious = preprevious ?? previous
            
            let mid1 = previous.middleLocation(with: preprevious!)
            let mid2 = current.middleLocation(with: previous)
            
            context.move(to: mid1)
            context.addQuadCurve(to: mid2, control: previous.location)
            
            context.setLineWidth(stroke.size * current.force)
            context.strokePath()
            
            preprevious = previous
        }
    }
    
}
