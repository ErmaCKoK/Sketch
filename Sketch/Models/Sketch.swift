//
//  SketchFile.swift
//  Sketch
//
//  Created by Andrii Kurshyn on 7/21/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import Foundation

/// Sketch object
class Sketch: Codable {
    let name: String
    
    var strokes: [Stroke] = []
    var redoStrokes: [Stroke] = []
    
    var currentColor: Color = Color(.black)
    
    init(name: String) {
        self.name = name
    }
}

// MARK: Sketch store

extension Sketch {
    
    func save() {
        DispatchQueue(label: "com.sketch.saving").async {
            var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            url.appendPathComponent(self.name)
            
            let data = try? JSONEncoder().encode(self)
            try? data?.write(to: url)
        }
    }
    
    static func load(fileName: String, completion: @escaping (Sketch?)->()) {
        DispatchQueue(label: "com.sketch.saving").async {
            var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            url.appendPathComponent(fileName)
            
            guard let data = try? Data(contentsOf: url) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            let sketch = try? JSONDecoder().decode(Sketch.self, from: data)
            DispatchQueue.main.async {
                completion(sketch)
            }
        }
    }
}
