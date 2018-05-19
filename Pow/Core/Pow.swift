//
//  Pow.swift
//  Pow
//
//  Created by Elias Abel on 4/29/18.
//

import Foundation

/**
 A stateless, threadsafe pow point that contains the display and the dismissal logic of entries.
 */
public final class Pow {
    
    // Cannot be instantiated or inherited.
    private init() {}
    
    /** Returns true if an pow is currently displayed */
    public class var isCurrentlyDisplaying: Bool {
        return PowAttributes.isDisplaying
    }
    
    /**
     Displays a given pow view using a given attributes struct.
     - A thread-safe method - Can be invokes from anywhere.
     - A class method - Should be called on the class.
     - parameter view: Custom view that is to be displayed
     - parameter attributes: Attributes (The display properties)
     */
    public class func display(_ view: UIView, using attributes: PowAttributes = PowAttributes.init()) {
        executeUIAction {
            PowWindowProvider.shared.state = .pow(view: view, attributes: attributes)
        }
    }
    
    /**
     Dismisses the currently presented pow and removes the presented window instance.
     - A thread-safe method - Can be invokes from anywhere.
     - A class method - Should be called on the class.
     */
    public class func dismiss() {
        executeUIAction {
            PowWindowProvider.shared.dismiss()
        }
    }
    
    /**
     Layout the view hierarchy that is rooted in the window.
     - In case you use complex animations, you can call it to refresh the AutoLayout mechanism on the entire view hierarchy.
     - A thread-safe method - Can be invokes from anywhere.
     - A class method - Should be called on the class.
     */
    public class func layoutIfNeeded() {
        executeUIAction {
            PowWindowProvider.shared.layoutIfNeeded()
        }
    }
}

// MARK: Private
private extension Pow {
    
    // A Precaution: Executes a UI action on the main thread, thus letting any of the class methods of Pow to be invokes even from a background thread.
    private class func executeUIAction(_ action: @escaping () -> ()) {
        if Thread.isMainThread {
            action()
        } else {
            DispatchQueue.main.async {
                action()
            }
        }
    }
}
