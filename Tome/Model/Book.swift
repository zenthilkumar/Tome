//
//  Book.swift
//  Tome
//
//  Created by Senthil Kumar on 22/09/17.
//  Copyright © 2017 Senthil Kumar. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class BooksContent: BaseModel {
    
    fileprivate enum JsonKey: String {
        
        case TotalItems     = "totalItems"
        case Items          = "items"
    }
    
    var books: [Book]?
    
    var topRatedBooks: [Book]? {
        get {
            
            let topRatedBooks = books?.filter({ $0.volumeInfo!.averageRating! >= 4.5 })
            return topRatedBooks
        }
    }
    
    class func createInstanceFrom(_ dictionary: [String: Any]?) -> Any? {
        
        guard dictionary != nil else { return nil }
        
        let instance = BooksContent()
        instance.setAttributesFromDictionary(dictionary)
        
        return instance
    }
    
    func getKeyChainData() -> [String: Any]? {
        return nil
    }
    
    func getBookTypes(bookType: String) -> [Book]? {
        
        if bookType == BookType.TopRated.rawValue {
            return topRatedBooks
        } else {
            return books
        }
    }
    
    
    func setAttributesFromDictionary(_ dictionary: [String: Any]?) {
        
        let items = dictionary?[JsonKey.Items.rawValue] as? [Any]
        books = listFromRawArray(items)
    }
}




class Book: BaseModel {
    
    fileprivate enum JsonKey: String {
        
        case Id             = "id"
        case HasRead        = "hasRead"
        case VolumeInfo     = "volumeInfo"
    }
    
    var bookId: String?
    var hasRead: Bool = false
    var volumeInfo: VolumeInfo?
    
    class func createInstanceFrom(_ dictionary: [String: Any]?) -> Any? {
        
        guard dictionary != nil else { return nil }
        
        let bookInstance = Book()
        bookInstance.setAttributesFromDictionary(dictionary)
        
        return bookInstance
    }
    
    func getKeyChainData() -> [String: Any]? {
        
        var dictionary = [String: Any]()
        
        dictionary[JsonKey.Id.rawValue] = bookId
        dictionary[JsonKey.HasRead.rawValue] = hasRead
        dictionary[JsonKey.VolumeInfo.rawValue] = volumeInfo?.getKeyChainData()
        
        return dictionary
    }
    
    func validateKeychainData() -> Bool {
        
        return bookId != nil
    }
    
    func accessKeychainWith() {
        if self.validateKeychainData() == true {
            
            hasRead = !hasRead
            if hasRead {
                KeychainWrapper.standard.set(getKeyChainData()!.description, forKey: bookId!)
            } else {
                KeychainWrapper.standard.removeObject(forKey: bookId!)
            }
        }
    }
    
    func setAttributesFromDictionary(_ dictionary: [String: Any]?) {
        
        bookId = dictionary?[JsonKey.Id.rawValue] as? String
        hasRead = KeychainWrapper.standard.string(forKey: bookId ?? String()) != nil
        let volumes = dictionary?[JsonKey.VolumeInfo.rawValue] as? [String: Any]
        volumeInfo = VolumeInfo.createInstanceFrom(volumes) as? VolumeInfo
    }
}




class VolumeInfo: BaseModel {
    
    fileprivate enum JsonKey: String {
        
        case Title              = "title"
        case Authors            = "authors"
        case SubTitle           = "subtitle"
        case Thumbnail          = "thumbnail"
        case ImageLinks         = "imageLinks"
        case SearchInfo         = "searchInfo"
        case Description        = "description"
        case TextSnippet        = "textSnippet"
        case AverageRating      = "averageRating"
        case PublishedDate      = "publishedDate"
        case SmallThumbnail     = "smallThumbnail"
    }
    
    var title: String?
    var authors: String?
    var subTitle: String?
    var thumbnail: String?
    var description: String?
    var averageRating: Double?
    var publishedDate: String?
    var smallThumbnail: String?
    
    class func createInstanceFrom(_ dictionary: [String: Any]?) -> Any? {
        
        guard dictionary != nil else { return nil }
        
        let volumeInfo = VolumeInfo()
        volumeInfo.setAttributesFromDictionary(dictionary)
        
        return volumeInfo
    }
    
    func getKeyChainData() -> [String: Any]? {
        
        var dictionary = [String: Any]()
        
        dictionary[JsonKey.Title.rawValue] = title
        dictionary[JsonKey.Authors.rawValue] = authors
        dictionary[JsonKey.SubTitle.rawValue] = subTitle
        dictionary[JsonKey.Thumbnail.rawValue] = thumbnail
        dictionary[JsonKey.Description.rawValue] = description
        dictionary[JsonKey.AverageRating.rawValue] = averageRating
        dictionary[JsonKey.PublishedDate.rawValue] = publishedDate
        dictionary[JsonKey.SmallThumbnail.rawValue] = smallThumbnail
        
        return dictionary
    }
    
    func setAttributesFromDictionary(_ dictionary: [String: Any]?) {
        
        title = dictionary?[JsonKey.Title.rawValue] as? String ?? String()
        authors = (dictionary?[JsonKey.Authors.rawValue] as? [String])?.joined(separator: ",") ?? String()
        subTitle = dictionary?[JsonKey.SubTitle.rawValue] as? String ?? String()
        description = dictionary?[JsonKey.Description.rawValue] as? String ?? String()
        publishedDate = dictionary?[JsonKey.PublishedDate.rawValue] as? String ?? String()
        averageRating = dictionary?[JsonKey.AverageRating.rawValue] as? Double ?? 0.0
        
        let imageLink = dictionary?[JsonKey.ImageLinks.rawValue] as? [String: Any]
        thumbnail = imageLink?[JsonKey.Thumbnail.rawValue] as? String
        smallThumbnail = imageLink?[JsonKey.SmallThumbnail.rawValue] as? String
    }
}
