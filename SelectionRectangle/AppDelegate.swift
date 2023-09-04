//
//  AppDelegate.swift
//  SelectionRectangle
//
//  Created by Angelos Staboulis on 23/8/23.
//

import Cocoa
import SwiftUI
@main
class AppDelegate: NSObject, NSApplicationDelegate {
    var selectionView:SelectionView!
    var viewController:ViewController!
 
    @IBAction func mnuCut(_ sender: Any) {
        let pasteboard = NSPasteboard.general
        pasteboard.prepareForNewContents(with: .init())
        pasteboard.setData(selectionView.newImage.tiffRepresentation, forType: NSPasteboard.PasteboardType(rawValue: "image"))
        selectionView.clearSelectionRectangle()
        selectionView.removeFromSuperview()
    }
    @IBAction func mnuCopy(_ sender: Any) {
        let pasteboard = NSPasteboard.general
        pasteboard.prepareForNewContents(with: .init())
        pasteboard.setData(selectionView.newImage.tiffRepresentation, forType: NSPasteboard.PasteboardType(rawValue: "image"))
        selectionView.removeFromSuperview()
    }
    @IBAction func mnuSelection(_ sender: Any) {
        selectionView = SelectionView(frame: NSScreen.main!.frame)
        selectionView.wantsLayer = true
        selectionView.layer!.backgroundColor = NSColor.clear.cgColor
        selectionView.layer!.borderWidth = 15
        selectionView.layer!.borderColor = NSColor.clear.cgColor
        viewController.view.addSubview(selectionView)
    }
   

    @IBAction func mnuPaste(_ sender: Any) {
        let pasteboard = NSPasteboard.general
        let imageData = pasteboard.data(forType: NSPasteboard.PasteboardType(rawValue: "image"))
        let newImage = NSImage(data: imageData!)
        let nsImageView = NSImageView(image: newImage!)
        nsImageView.frame = NSScreen.main!.visibleFrame
        nsImageView.wantsLayer = true
        viewController.view.addSubview(nsImageView)
        selectionView.removeFromSuperview()
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        viewController = NSApplication.shared.orderedWindows.first?.contentViewController as? ViewController
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

