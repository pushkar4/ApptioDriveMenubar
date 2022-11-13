//
//  AppDelegate.swift
//  ApptioDriveMenubar
//
//  Created by Pushkar Sharma on 12/11/22.
//

import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusItem: NSStatusItem!
    let popup = NSPopover()
    
    private lazy var contentView: NSView? = {
        let view = (statusItem.value(forKey: "window") as? NSWindow)?.contentView
        return view
    }()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        print("App finished launch")
        setupMenuBar()
        setupPopup()
    }
}

// MARK: - MENU BAR

extension AppDelegate {
    
    func setupMenuBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: 64)
        guard let contentView = self.contentView,
              let menuButton = statusItem.button
        else { return }
        
        let hostingView = NSHostingView(rootView: MenuBarIconView())
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(hostingView)
        
        NSLayoutConstraint.activate([
            hostingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            hostingView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            hostingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            hostingView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])
        
        menuButton.action = #selector(menuButtonClicked)
    }
    
    @objc func menuButtonClicked() {
        print("Menu button clicked")
        if popup.isShown {
            popup.performClose(nil)
            return
        }
        
        guard let menuButton = statusItem.button else { return }
        let positioningView = NSView(frame: menuButton.bounds)
        positioningView.identifier = NSUserInterfaceItemIdentifier("positioningView")
        menuButton.addSubview(positioningView)
        
        popup.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: .maxY)
        menuButton.bounds = menuButton.bounds.offsetBy(dx: 0, dy: menuButton.bounds.height)
        popup.contentViewController?.view.window?.makeKey()
    }
}

// MARK: - POPUP

extension AppDelegate: NSPopoverDelegate {
    
    func setupPopup() {
        popup.behavior = .transient
        popup.animates = true
        popup.contentSize = .init(width: 300, height: 380)
        popup.contentViewController = NSViewController()
        popup.contentViewController?.view = NSHostingView(
            rootView: PopupStatusView().frame(maxWidth: .infinity, maxHeight: .infinity).padding()
        )
        popup.delegate = self
    }
    
    func popoverDidClose(_ notication: Notification) {
        let positioningView = statusItem.button?.subviews.first {
            $0.identifier == NSUserInterfaceItemIdentifier("positioningView")
        }
        positioningView?.removeFromSuperview()
    }
}
