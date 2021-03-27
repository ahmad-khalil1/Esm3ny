//
//  BookItem.swift
//  Esm3ny
//
//  Created by Ahmad Khalil on 2/10/21.
//

import UIKit

class BookItem : Hashable {
    
    // hasbable protocol confirmation
    
    private var identifier = UUID()
    
    static func == (lhs: BookItem , rhs: BookItem ) -> Bool{
        return lhs.identifier == rhs .identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    // bookitem properities
    
    var title : String
    var image : UIImage
    
    init(title : String , image : UIImage ) {
        self.title = title
        self.image = image
        
    }
}

class BookItemDetailed: BookItem {
    var rating : Double
    var ratingCount : Int
    var price : Double
    var bookAutherName : String
    
    init (title : String , image : UIImage , rating : Double  , ratingCount : Int , price : Double , bookAutherName : String ) {
        self.rating = rating
        self.ratingCount = ratingCount
        self.price = price
        self.bookAutherName = bookAutherName
        super.init(title: title, image: image)
    }
}


//,
