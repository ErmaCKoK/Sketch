import UIKit

// MARK: - Function

func intersectionRange(_ rect1: CGRect, _ rect2: CGRect) -> CGRect? {
    
    let rect1 = rect1.standardized
    let rect2 = rect2.standardized
    
    let maxX1 = rect1.origin.x + rect1.size.width
    let maxX2 = rect2.origin.x + rect2.size.width
    
    let maxY1 = rect1.origin.y + rect1.size.height
    let maxY2 = rect2.origin.y + rect2.size.height
    
    //let x = rect1.
    
    var new = CGRect.zero
    
    if rect1.origin.x < rect2.origin.x {
        new.origin.x = rect2.origin.x
        
        if maxX1 > maxX2 {
            new.size.width = rect2.size.width
        } else {
            new.size.width = maxX1 - rect2.origin.x
        }
        
    } else {
        new.origin.x = rect1.origin.x
        
        if maxX1 > maxX2 {
            new.size.width = maxX2 - rect1.origin.x
        } else {
            new.size.width = rect1.size.width
        }
    }
    
    if new.width <= 0 {
        return .zero
    }
    
    if rect1.origin.y < rect2.origin.y {
        new.origin.y = rect2.origin.y
        
        if maxY1 > maxY2 {
            new.size.height = rect2.size.height
        } else {
            new.size.height = maxY1 - rect2.origin.y
        }
    } else {
        new.origin.y = rect1.origin.y
        
        if maxY1 < maxY2 {
            new.size.height = rect1.size.height
        } else {
            new.size.height = maxY2 - rect1.origin.y
        }
    }
    
    if new.height <= 0 {
        return .zero
    }
    
    
    return new
}

// MARK: - Test

let main = CGRect(x: 150, y: 100, width: 300, height: 200)
var second = CGRect.zero

second = CGRect(x: 50, y: 50, width: 50, height: 50)
intersectionRange(main, second) // {x 0 y 0 w 0 h 0}

second = CGRect(x: 50, y: 50, width: 50, height: 50)
intersectionRange(second, main) // {x 0 y 0 w 0 h 0}

second = CGRect(x: 50, y: 50, width: 300, height: 300)
intersectionRange(second, main) // {x 150 y 100 w 200 h 200}

second = CGRect(x: 50, y: 50, width: 300, height: 300)
intersectionRange(main, second) // {x 150 y 100 w 200 h 200}

second = CGRect(x: 50, y: 150, width: 300, height: 100)
intersectionRange(main, second) // {x 150 y 150 w 200 h 100}

second = CGRect(x: 50, y: 150, width: 100, height: 100)
intersectionRange(main, second) // {x 0 y 0 w 0 h 0}

second = CGRect(x: 350, y: 250, width: -100, height: -100)
intersectionRange(main, second) // {x 250 y 150 w 100 h 100}

second = CGRect(x: 250, y: 50, width: 100, height: 100)
intersectionRange(main, second) // {x 250 y 100 w 100 h 50}

second = CGRect(x: 250, y: 50, width: 100, height: 200)
intersectionRange(main, second) // {x 250 y 100 w 100 h 150}

second = CGRect(x: 250, y: 50, width: 100, height: 300)
intersectionRange(main, second) // {x 250 y 100 w 100 h 200}

second = CGRect(x: 250, y: 150, width: 100, height: 100)
intersectionRange(main, second) // {x 250 y 150 w 100 h 100}

second = CGRect(x: 250, y: 150, width: 100, height: 200)
intersectionRange(main, second) // {x 250 y 150 w 100 h 150}
