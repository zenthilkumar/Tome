//
//  BooksDetailViewController.swift
//  Tome
//
//  Created by Senthil Kumar on 22/09/17.
//  Copyright © 2017 Senthil Kumar. All rights reserved.
//

import UIKit

class BooksDetailViewController: BaseViewController {

    var book: Book?
    
    @IBOutlet weak var bookImage: UIImageView!
    
    @IBOutlet weak var authors: UILabel!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    
    override var pageTitle: String {
        return book?.volumeInfo?.title ?? String()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bookImage.imageFromServerURL(urlString: book?.volumeInfo?.thumbnail)
        authors.text = book?.volumeInfo?.authors
        bookTitle.text = book?.volumeInfo?.title
        bookDescription.text = book?.volumeInfo?.description
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func passMessageWith(data: Any?) {
    
        if canControllerBeInstantiated(data: data) {
            
            book = data as? Book
        }
    }
    
    override func canControllerBeInstantiated(data: Any?) -> Bool{
        return data != nil
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
