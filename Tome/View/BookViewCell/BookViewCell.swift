//
//  BookViewCell.swift
//  Tome
//
//  Created by Senthil Kumar on 22/09/17.
//  Copyright © 2017 Senthil Kumar. All rights reserved.
//

import UIKit

enum ReadingStatus: String {
    case Read
    case Pending
}

enum CellAction: String {
    case Reload = "Reload"
}

class BaseCellView: UITableViewCell {
    
    var indexPath: IndexPath?
    var hasUserInteract: ((CellAction, IndexPath?) -> (Void))?
    
    class var reuseIdentifier: String {
        return className
    }
    
    class var xibName: String {
        return className
    }
    
    func setIndexPath(indexPath: IndexPath?) {
        self.indexPath = indexPath
    }
    
    fileprivate class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}

class BookViewCell: BaseCellView {
    
    @IBOutlet private weak var bookTitle: UILabel!
    @IBOutlet private weak var toggleRead: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setBook(info: Any?, indexPath: IndexPath?) {
        
        let book = info as? Book
        super.setIndexPath(indexPath: indexPath)
        accessoryType = .disclosureIndicator
        bookTitle.text = book?.volumeInfo?.title
        toggleRead.setTitle(book?.hasRead == true ? ReadingStatus.Read.rawValue : ReadingStatus.Pending.rawValue, for: .normal)
    }
    
    @IBAction func ToggleRead(_ sender: Any) {
        if hasUserInteract != nil {
            hasUserInteract!(CellAction.Reload, indexPath)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    class var height: CGFloat {
        return 44.0
    }
}
