//
//  UIUtils.swift
//  Tome
//
//  Created by Senthil Kumar on 25/09/17.
//  Copyright © 2017 Senthil Kumar. All rights reserved.
//

import UIKit

extension UIImageView {
    func imageFromServerURL(urlString: String?) {
        guard urlString != nil && URL(string: urlString!) != nil else {
            return
        }
        URLSession.shared.dataTask(with: URL(string: urlString!)!, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}
