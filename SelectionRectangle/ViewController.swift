//
//  ViewController.swift
//  SelectionRectangle
//
//  Created by Angelos Staboulis on 23/8/23.
//

import Cocoa
class DrawView: NSImageView {
    var rect:NSRect!
    var startPoint: NSPoint?
    var draggedPoint: NSPoint?
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        drawSelectionRectangle()
    }
    func drawSelectionRectangle(){
        guard let ctx = NSGraphicsContext.current?.cgContext else {
            return
        }
        guard let rectangle = rect else {
            return
        }

        ctx.setFillColor(NSColor.clear.cgColor)
        ctx.setStrokeColor(NSColor.black.cgColor)
        ctx.setLineWidth(10)

        ctx.addRect(rectangle)
        ctx.drawPath(using: .fillStroke)
    }
    
    
    func imageRepresentation()->NSImage{
        let imageRepresentation = bitmapImageRepForCachingDisplay(in: bounds)!
        cacheDisplay(in: bounds, to: imageRepresentation)
        return NSImage(cgImage: imageRepresentation.cgImage!, size: bounds.size)
        
    }
    
    override func mouseDown(with event: NSEvent) {
        startPoint = event.locationInWindow
    }
    override func mouseDragged(with event: NSEvent) {
        draggedPoint = event.locationInWindow
                
        rect = NSRect(x: startPoint!.x, y: startPoint!.y, width: draggedPoint!.x - startPoint!.x, height: draggedPoint!.y - startPoint!.y)
        
        needsDisplay = true
    }


}

class ViewController: NSViewController {
    let drawView = DrawView()
    override func loadView() {
        view = drawView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        drawView.frame = NSScreen.main!.frame
        // Do any additional setup after loading the view.
    }
   
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

