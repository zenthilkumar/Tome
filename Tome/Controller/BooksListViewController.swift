//
//  BooksListViewController.swift
//  Tome
//
//  Created by Senthil Kumar on 22/09/17.
//  Copyright © 2017 Senthil Kumar. All rights reserved.
//

import UIKit

enum BookType: String {
    
    case Default  = "All"
    case TopRated = "TopRated"
}

class BooksListViewController: BaseViewController {
    
    
    var books: [Book] = []
    var bookContent: BooksContent?
    @IBOutlet private weak var booksTable: UITableView!
    
    
    override var pageTitle: String {
        return "Books"
    }
    var hasUserInteract: ((CellAction, IndexPath?) -> (Void))?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addNavigationItem(title: BookType.TopRated.rawValue)
        booksTable.register(UINib(nibName: BookViewCell.xibName, bundle: Bundle.main), forCellReuseIdentifier: BookViewCell.reuseIdentifier)
        
        getBooksInfo()
        cellInteractions()
        booksTable.dataSource = self
        booksTable.delegate = self
    }
    
    fileprivate func addNavigationItem(title: String) {
        
        navigationControl.addNavigationButtonItems(title: title, navigationControl: BarButtonConfiguration.Right, storyboardComponent: MainStoryboard.BooksListViewController)
    }
    
    func cellInteractions() {
        
        hasUserInteract = { [weak self] action, indexPath in

            guard indexPath != nil else {
                return
            }
            
            switch action {
            case .Reload:
                if let book = self?.books[indexPath!.row] {
                    book.accessKeychainWith()
                }
                self?.booksTable.reloadRows(at: [indexPath!], with: .none)
                break
            }
        }
    }
    
    override func buttonItemTapped(sender: UIBarButtonItem) {
        
        if navigationControl.navigationControl?.buttonPosition == BarButtonConfiguration.Right.rawValue {
            if navigationControl.itemTitle == BookType.TopRated.rawValue {
                
                addNavigationItem(title: BookType.Default.rawValue)
                books = bookContent?.getBookTypes(bookType: BookType.TopRated.rawValue) ?? []
            } else {
                
                addNavigationItem(title: BookType.TopRated.rawValue)
                books = bookContent?.getBookTypes(bookType: BookType.Default.rawValue) ?? []
            }
            booksTable.reloadData()
        }
    }
    
    fileprivate func getBooksInfo() {
        
        if let book = BooksContent.createInstanceFromFile("Books") as? BooksContent {
            bookContent = book
            books = book.books ?? []
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension BooksListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let book: Book = books[indexPath.row]
        let bookViewCell = tableView.dequeueReusableCell(withIdentifier: BookViewCell.reuseIdentifier) as? BookViewCell
        bookViewCell?.hasUserInteract = hasUserInteract
        bookViewCell?.setBook(info: book, indexPath: indexPath)
        
        return bookViewCell!
    }
}

extension BooksListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        StoryboardInstantiator().instantiateWith(data: book, storyboard: MainStoryboard.BooksDetailViewController, navigationStyle: .Push)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return BookViewCell.height
    }
}
