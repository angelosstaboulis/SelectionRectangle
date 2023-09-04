//
//  ViewController.swift
//  SelectionRectangle
//
//  Created by Angelos Staboulis on 23/8/23.
//

import Cocoa
import AppKit
import SwiftUI

class SelectionView:NSImageView{
    var newImage:NSImage!
    var nsView = NSView()
    var rect:NSRect!
    var startPoint:NSPoint!
    var draggedPoint:NSPoint!

    override init(frame: NSRect){
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        drawRectangle()
    }
    
    func drawRectangle(){
        nsView.frame = .zero
        nsView.wantsLayer = true
        nsView.layer?.borderWidth = 15
        nsView.layer?.borderColor = NSColor.red.cgColor
        nsView.isHidden = true
        addSubview(nsView)
    }
    
    
    override func mouseDown(with event: NSEvent) {
        nsView.isHidden = false
        startPoint = event.locationInWindow
    }
    override func mouseDragged(with event: NSEvent) {
        draggedPoint = event.locationInWindow
        rect = NSRect(x: min(startPoint.x,draggedPoint.x), y: min(startPoint.y,draggedPoint.y), width: abs(startPoint.x - draggedPoint.x), height: abs(startPoint.y - draggedPoint.y))
        nsView.frame = rect
        
    }
    func clearBox(rectangle:NSRect){
        let box = CAShapeLayer()
        box.frame = rectangle
        box.backgroundColor =  NSColor.windowBackgroundColor.cgColor
        superview!.layer!.addSublayer(box)
    }
    func clearSelectionRectangle(){
            clearBox(rectangle: rect)
    }
    override func mouseUp(with event: NSEvent) {
        let pdfData = superview!.dataWithPDF(inside: nsView.frame)
        newImage = NSImage(data: pdfData)
       
    }
    
}



// MARK: - Initialization

class ViewController: NSViewController {
    let nsView = DrawView(frame: .zero, image: .init())
    
    override func loadView() {
        view = nsView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nsView.frame = NSScreen.main!.frame
    }
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
            
        }
    }
    
    
}

