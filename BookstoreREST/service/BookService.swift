//
//  BookService.swift
//  BookstoreREST
//
//  Created by user168039 on 5/1/20.
//  Copyright © 2020 Tec. All rights reserved.
//

import Foundation

class BookService : NSObject {
    //MARK: Functions
    func getAll(handler: @escaping ([Book]) -> Void) {
        let endpoint: String = "https://booksappsample.herokuapp.com/books"
        
        guard let url = URL(string: endpoint) else {
            NSLog("Error creating URL %@", endpoint)
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard error == nil else {
                print("Error calling URL")
                print(error!)
                return
            }
            
            guard let responseData = data else {
                print("Error data is empty")
                return
            }
            
            do {
                guard let response = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [[String : Any]] else {
                        print("Error trying to convert data to JSON")
                        return
                }
                
                let books = self.buildBookListFromAPIResponse(response)
                
                handler(books)
            } catch  {
                print("Error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }

    private func buildBookFromAPIResponse(_ response: [String: Any]) -> Book {
        let book = Book()
        
        if let bookId = response["id"] as? Int {
            book.bookId = bookId
        }
        
        if let title = response["title"] as? String {
            book.title = title
        }
        
        if let author = response["author"] as? String {
            book.author = author
        }
        
        if let description = response["description"] as? String {
            book.description = description
        }
        if let image = response["cover"] as? String{
            book.image = image
        }
        return book
    }
    
    private func buildBookListFromAPIResponse(_ list : [[String : Any]]) -> [Book] {
        var bookList: [Book] = []
        
        for jsonBook in list {
            let book = Book()
            
            if let bookId = jsonBook["id"] as? Int {
                book.bookId = bookId
            }
            
            if let title = jsonBook["title"] as? String {
                book.title = title
            }
            
            if let author = jsonBook["author"] as? String {
                book.author = author
            }
            
            if let description = jsonBook["description"] as? String {
                book.description = description
            }
            if let image = jsonBook["cover"] as? String{
                book.image = image
            }
            
            bookList.append(book)
            
        }
        
        return bookList
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()){
        
    }
    
    func deleteBook(id: Int) {
        guard let url = URL(string: "https://booksappsample.herokuapp.com/books/\(id)") else {
            print("Error: cannot create URL")
            return
        }
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling DELETE")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
        }.resume()
    }
}
