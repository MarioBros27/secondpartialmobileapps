//
//  BookDAO.swift
//  BookstoreREST
//
//  Created by user168039 on 5/1/20.
//  Copyright © 2020 Tec. All rights reserved.
//

import Foundation

class BookDAO {
    //MARK: Properties
    var service: BookService = new BookService()
    
    //MARK: Functions
    func findAll() -> [Book] {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        var movies: [Movie] = service.getAll(handler: <#T##(Book) -> Void#>)
        
        do {
            movies = try managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            NSLog("Error fetching the movies from databse: %@", error)
        }
        
        return movies
    }
    
    func insertMovie(imdbId: String) {
        let movie: Movie = NSEntityDescription.insertNewObject(forEntityName: "Movie", into: managedObjectContext) as! Movie
        movie.imdbId = imdbId
        movie.insertedDate = Date()
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            NSLog("Error saving the movie in database: %@", error)
        }
    }
    
    func deleteMovie(movie: Movie) {
        managedObjectContext.delete(movie)
    }
}
