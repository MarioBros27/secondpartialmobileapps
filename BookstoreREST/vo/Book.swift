//
//  Book.swift
//  BookstoreREST
//
//  Created by user168039 on 5/1/20.
//  Copyright © 2020 Tec. All rights reserved.
//

import Foundation

class Book {
    var bookId: Int = 0
    var title: String = ""
    var author: String = ""
    var description: String = ""
    var image: String = ""
    init() {}
    
    init(_ bookId : Int, _ title : String, _ author : String, _ description : String, _ image : String) {
        self.bookId = bookId
        self.author = author
        self.title = title
        self.description = description
        self.image = image
    }
    
}
