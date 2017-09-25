//
//  NavigationBarControls.swift
//  Tome
//
//  Created by Senthil Kumar on 24/09/17.
//  Copyright © 2017 Senthil Kumar. All rights reserved.
//

import UIKit

protocol NavigationControl {
    
    var buttonPosition: String { get }
}

enum BarButtonConfiguration: String, NavigationControl {
    
    case Left
    case Right
    
    var buttonPosition: String {
        get {
            return self.rawValue
        }
    }
    
}

class NavigationBarControls: StoryboardInstantiator {
    
    var itemTitle: String = String()
    var storyboard: StoryboardComponent?
    var navigationControl: NavigationControl?
    func addNavigationButtonItems(title: String, navigationControl: NavigationControl, storyboardComponent: StoryboardComponent) {
        itemTitle = title
        storyboard = storyboardComponent
        self.navigationControl = navigationControl
        if let appDelegate  = UIApplication.shared.delegate as? AppDelegate {
            
            if let rootViewController = appDelegate.window!.rootViewController {
                if rootViewController is UINavigationController {
                    
                    let navigationController = rootViewController as? UINavigationController
                    let topViewController = navigationController?.topViewController
                    if navigationControl.buttonPosition == BarButtonConfiguration.Left.rawValue {
                        
                        topViewController?.navigationItem.leftBarButtonItems = [addBarButton(topViewController: topViewController)]
                    } else {
                        
                        topViewController?.navigationItem.rightBarButtonItems = [addBarButton(topViewController: topViewController)]
                    }
                }
            }
        }
    }
    
    func addBarButton(topViewController: UIViewController?) -> UIBarButtonItem {
        
        let barButtonItem = UIBarButtonItem(title: itemTitle, style: .plain, target: topViewController, action: #selector((topViewController as? BaseViewController)?.buttonItemTapped))
        return barButtonItem
    }
}
