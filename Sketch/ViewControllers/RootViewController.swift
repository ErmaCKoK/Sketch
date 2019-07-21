//
//  ViewController.swift
//  Sketch
//
//  Created by Andrii Kurshyn on 7/18/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    @IBOutlet weak var sketchView: SketchView!
    @IBOutlet weak var colorButton: ColorButton!
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var redoButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var saveImageButton: UIButton!
    
    var sketch = Sketch(name: "Sketch")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sketchView.drawingDelegate = self
        loadSketch()
    }
    
    private func loadSketch() {
        Sketch.load(fileName: "Sketch") { (sketch) in
            if let sketch = sketch {
                self.sketch = sketch
            }
            self.reloadView()
        }
    }
    
    private func reloadView() {
        sketchView.strokes = sketch.strokes
        colorButton.color = sketch.currentColor.uiColor
        
        undoButton.isEnabled = sketch.strokes.count > 0
        saveImageButton.isEnabled = undoButton.isEnabled
        resetButton.isEnabled = undoButton.isEnabled
        redoButton.isEnabled = sketch.redoStrokes.count > 0
    }
    
    // MARK: - Actions
    
    @IBAction func undoButtonAction() {
        let last = sketch.strokes.removeLast()
        sketch.redoStrokes.append(last)
        sketch.save()

        reloadView()
    }
    
    @IBAction func redoButtonAction() {
        let last = sketch.redoStrokes.removeLast()
        sketch.strokes.append(last)
        sketch.save()
        
        reloadView()
    }
    
    @IBAction func resetButtonAction() {
        let new = Sketch(name: "Sketch")
        new.currentColor = sketch.currentColor
        sketch = new
        sketch.save()
        
        reloadView()
    }
    
    @IBAction func saveImageButtonAction() {
        let image = self.sketchView.getImage()
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWith:contextInfo:)), nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "colorPicker" {
            let picker = segue.destination as! ColorPickerViewController
            picker.delegate = self
        }
    }
}

// MARK: - SketchView Drawing Delegate

extension RootViewController: SketchViewDrawingDelegate {
    
    func drawingStroke(in sketchView: SketchView, with particle: StrokeParticle) -> Stroke? {
        return Stroke(particle: particle, size: 5.0, color: sketch.currentColor.uiColor)
    }
    
    func sketchView(_ sketchView: SketchView, endDraw stroke: Stroke) {
        sketch.strokes.append(stroke)
        sketch.redoStrokes = []
        sketch.save()
        
        reloadView()
    }
}

// MARK: - SketchView Drawing Delegate

extension RootViewController: ColorPickerViewDelegate {
    
    func colorPickerViewController(_ colorPickerViewController: ColorPickerViewController, didSelect color: UIColor) {
        sketch.currentColor = Color(color)
        sketch.save()
        
        reloadView()
        colorPickerViewController.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Save image to Library

extension RootViewController {
    
    @objc
    func image(_ image: UIImage, didFinishSavingWith error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            showAlertWith(title: "Saved", message: "Your image has been saved to your photos.")
        }
    }
    
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}



