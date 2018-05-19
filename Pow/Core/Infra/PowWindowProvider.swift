//
//  PowWindowProvider.swift
//  Pow
//
//  Created by Elias Abel on 4/19/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit

public class PowWindowProvider {
    
    public enum State {
        case pow(view: UIView, attributes: PowAttributes)
        case main
        
        var isMain: Bool {
            switch self {
            case .main:
                return true
            default:
                return false
            }
        }
    }
    
    // Safe area insets
    static var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return PowWindowProvider.shared.powWindow?.rootViewController?.view?.safeAreaInsets ?? UIApplication.shared.keyWindow?.rootViewController?.view.safeAreaInsets ?? .zero
        } else {
            let statusBarMaxY = UIApplication.shared.statusBarFrame.maxY
            return UIEdgeInsets(top: statusBarMaxY, left: 0, bottom: 10, right: 0)
        }
    }
    
    // Shared
    static let shared = PowWindowProvider()

    // State
    public internal(set) var state: State = .main {
        didSet {
            switch state {
            case .main:
                clean()
            case .pow(view: let view, attributes: let attributes):
                setup(with: view, attributes: attributes)
            }
        }
    }
    
    // Entry window
    var powWindow: PowWindow!
    
    // Root view controller
    var rootVC: PowRootViewController? {
        return powWindow?.rootViewController as? PowRootViewController
    }

    private init() {}
    
    func dismiss() {
        guard let rootVC = rootVC else {
            return
        }
        rootVC.animateOutLastEntry()
    }
    
    // MARK: Setup and Teardown methods
    private func setup(with messageView: UIView, attributes: PowAttributes) {
        let powController: PowRootViewController
        if powWindow == nil {
            powController = PowRootViewController()
            powWindow = PowWindow(with: powController)
        } else {
            powController = rootVC!
        }
        powWindow.windowLevel = attributes.windowLevel.value
        
        let powView = PowView()
        powView.content = PowView.Content(view: messageView, attributes: attributes)
        powController.configure(newEntryView: powView, attributes: attributes)
    }
    
    private func clean() {
        powWindow = nil
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }
    
    func layoutIfNeeded() {
        powWindow?.layoutIfNeeded()
    }
}
