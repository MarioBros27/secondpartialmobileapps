//
//  BookDelegate.swift
//  BookstoreREST
//
//  Created by user168039 on 5/2/20.
//  Copyright © 2020 Tec. All rights reserved.
//

import Foundation

protocol BookDelegate {
    func newBook(_ controller : AnyObject, newBook : Book)
    func editBook(_ controller : AnyObject, editBook : Book)
    func deleteBook(_ controller : AnyObject)
}
