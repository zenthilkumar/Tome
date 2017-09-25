//
//  BaseViewController.swift
//  Tome
//
//  Created by Senthil Kumar on 22/09/17.
//  Copyright © 2017 Senthil Kumar. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var pageTitle: String {
        return String()
    }
    var navigationControl: NavigationBarControls = NavigationBarControls()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.title = pageTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func buttonItemTapped(sender: UIBarButtonItem) {
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BaseViewController: StoryboardDataMessenger {
    
    func passMessageWith(data: Any?) { }
    
    func canControllerBeInstantiated(data: Any?) -> Bool{
        return false
    }
}
