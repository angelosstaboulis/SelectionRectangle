//
//  DrawView.swift
//  SelectionRectangle
//
//  Created by Angelos Staboulis on 3/9/23.
//

import Foundation
import AppKit
import Cocoa
class DrawView: NSView {
    var path: NSBezierPath = NSBezierPath()
    var rect:NSRect!
    var startPoint:NSPoint!
    var draggedPoint:NSPoint!
    var image : NSImage? {
        didSet {
            needsDisplay = true
        }
    }
    
    init(frame frameRect: NSRect, image : NSImage?) {
        self.image = image
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func mouseDown(with event: NSEvent) {
        path.move(to: convert(event.locationInWindow, from: nil))
    }
    override func mouseDragged(with event: NSEvent) {
        path.line(to: convert(event.locationInWindow, from: nil))
        needsDisplay = true
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        NSColor.green.set()
        path.lineJoinStyle = .round
        path.lineCapStyle = .round
        path.lineWidth = 15.0
        path.stroke()
        image?.draw(at: .zero, from: bounds, operation: .sourceOver, fraction: 1.0)

    }
    
    func mnuDelete(viewController:ViewController){
        for view in viewController.view.subviews{
            view.removeFromSuperview()
        }
    }
    
    
}
