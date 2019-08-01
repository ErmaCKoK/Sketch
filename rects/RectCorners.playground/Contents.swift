import UIKit

// MARK: - Rect

struct Rect: CustomPlaygroundDisplayConvertible {
    
    var point1: CGPoint
    var point2: CGPoint
    
    static var zero: Rect {
        return Rect(point1: .zero, point2: .zero)
    }
    
    init(point1: CGPoint, point2: CGPoint) {
        self.point1 = point1
        self.point2 = point2
    }
    
    init(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat) {
        self.point1 = CGPoint(x: x1, y: y1)
        self.point2 = CGPoint(x: x2, y: y2)
    }
    
    
    var playgroundDescription: Any {
        return "{x \(self.point1.x) y \(self.point1.y)} {x \(self.point2.x) y \(self.point2.y)}"
    }
    
    var topLeft: CGPoint {
        let topLeftX = min(point1.x, point2.x)
        let topLeftY = min(point1.y, point2.y)
        return CGPoint(x: topLeftX, y: topLeftY)
    }
    
    var bottomRight: CGPoint {
        let bottomRightX = max(point1.x, point2.x)
        let bottomRightY = max(point1.y, point2.y)
        return CGPoint(x: bottomRightX, y: bottomRightY)
    }
    
    var cgRect: CGRect {
        let topLeft = self.topLeft
        let bottomRight = self.bottomRight
        return CGRect(x: topLeft.x, y: topLeft.y, width: bottomRight.x - topLeft.x, height: bottomRight.y - topLeft.y)
    }
    
    init(cgRect: CGRect) {
        let cgRect = cgRect.standardized
        self.point1 = cgRect.origin
        self.point2 = CGPoint(x: cgRect.maxX, y: cgRect.maxY)
    }
}

// MARK: - Function

func intersectionRange(_ rect1: Rect, _ rect2: Rect) -> Rect {
    
    let topLeft1 = rect1.topLeft
    let bottomRight1 = rect1.bottomRight
    
    let topLeft2 = rect2.topLeft
    let bottomRight2 = rect2.bottomRight
    
    var new = Rect.zero
    
    new.point1.x = max(topLeft1.x, topLeft2.x)
    new.point2.x = min(bottomRight1.x, bottomRight2.x)
    
    new.point1.y = max(topLeft1.y, topLeft2.y)
    new.point2.y = min(bottomRight1.y, bottomRight2.y)
    
    if new.point1.x >= new.point2.x || new.point1.y >= new.point2.y {
        return .zero
    }
    
    return new
}


// MARK: - Tests

let main = Rect(x1: 150, y1: 100, x2: 450, y2: 300)
var second = Rect.zero

second = Rect(x1: 0, y1: 500, x2: 550, y2: 550)
intersectionRange(main, second) // {x 0.0 y 0.0} {x 0.0 y 0.0}

second = Rect(x1: 0, y1: 0, x2: 50, y2: 50)
intersectionRange(main, second) // {x 0.0 y 0.0} {x 0.0 y 0.0}

second = Rect(x1: 0, y1: 150, x2: 200, y2: 250)
intersectionRange(main, second) // {x 150.0 y 150.0} {x 200.0 y 250.0}

second = Rect(x1: 0, y1: 150, x2: 200, y2: 250)
intersectionRange(second, main) // {x 150.0 y 150.0} {x 200.0 y 250.0}

second = Rect(x1: 200, y1: 550, x2: 0, y2: 0)
intersectionRange(main, second) // {x 150.0 y 100.0} {x 200.0 y 300.0}

second = Rect(cgRect: CGRect(x: 50, y: 50, width: 50, height: 50))
intersectionRange(main, second).cgRect // {x 0 y 0 w 0 h 0}

second = Rect(cgRect:CGRect(x: 50, y: 50, width: 50, height: 50))
intersectionRange(second, main).cgRect // {x 0 y 0 w 0 h 0}

second = Rect(cgRect:CGRect(x: 50, y: 50, width: 300, height: 300))
intersectionRange(second, main).cgRect // {x 150 y 100 w 200 h 200}

second = Rect(cgRect:CGRect(x: 50, y: 50, width: 300, height: 300))
intersectionRange(main, second).cgRect // {x 150 y 100 w 200 h 200}

second = Rect(cgRect:CGRect(x: 50, y: 150, width: 300, height: 100))
intersectionRange(main, second).cgRect // {x 150 y 150 w 200 h 100}

second = Rect(cgRect:CGRect(x: 50, y: 150, width: 100, height: 100))
intersectionRange(main, second).cgRect // {x 0 y 0 w 0 h 0}

second = Rect(cgRect:CGRect(x: 350, y: 250, width: -100, height: -100))
intersectionRange(main, second).cgRect // {x 250 y 150 w 100 h 100}

second = Rect(cgRect:CGRect(x: 250, y: 50, width: 100, height: 100))
intersectionRange(main, second).cgRect // {x 250 y 100 w 100 h 50}

second = Rect(cgRect:CGRect(x: 250, y: 50, width: 100, height: 200))
intersectionRange(main, second).cgRect // {x 250 y 100 w 100 h 150}

second = Rect(cgRect:CGRect(x: 250, y: 50, width: 100, height: 300))
intersectionRange(main, second).cgRect // {x 250 y 100 w 100 h 200}

second = Rect(cgRect:CGRect(x: 250, y: 150, width: 100, height: 100))
intersectionRange(main, second).cgRect // {x 250 y 150 w 100 h 100}

second = Rect(cgRect:CGRect(x: 250, y: 150, width: 100, height: 200))
intersectionRange(main, second).cgRect // {x 250 y 150 w 100 h 150}
