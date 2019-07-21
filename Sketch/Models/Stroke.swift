//
//  Stroke.swift
//  Sketch
//
//  Created by Andrii Kurshyn on 7/20/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import UIKit

struct StrokeParticle: Codable {
    var location: CGPoint
    var force: CGFloat
    
    func middleLocation(with particle: StrokeParticle) -> CGPoint {
        return CGPoint(x: (location.x + particle.location.x)/2, y: (location.y + particle.location.y)/2)
    }
}

/// Stroke
class Stroke: Codable {
    
    var size: CGFloat
    var particles: [StrokeParticle]
    
    var color: Color
    
    /// Init Stroke object
    ///
    /// - Parameters:
    ///   - particle: first stroke
    ///   - size: size stroke
    ///   - color: color store
    init(particle: StrokeParticle, size: CGFloat, color: UIColor) {
        self.particles = [particle]
        self.size = size
        self.color = Color(color)
    }
}
