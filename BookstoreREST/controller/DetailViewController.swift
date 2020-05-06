//
//  DetailViewController.swift
//  BookstoreREST
//
//  Created by user168039 on 5/1/20.
//  Copyright © 2020 Tec. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    
    @IBOutlet weak var descriptionLabel: UITextView!
    var delegate : BookDelegate?
    @IBOutlet weak var imageView: UIImageView!
    
    var flag = true
    
    func configureView() {
        // Update the user interface for the detail item.
        if flag == false {
            
        }
        if let detail = detailItem {
            titleLabel.text = detail.title
            authorLabel.text = detail.author
            descriptionLabel.text = detail.description
            let unencodedData = Data(base64Encoded: detail.image)!
            let image = UIImage(data: unencodedData)
            imageView.image = image
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
        
    }

    var detailItem: Book? {
        didSet {
            //delegate?.newBook(self, newBook: detailItem!)
        }
    }

    @IBAction func deleteBook(_ sender: UIBarButtonItem) {
        let service = BookService()
        
        
        
        if let detail = detailItem{
            print("book to delete \(detail.bookId)")
            service.deleteBook(id: detailItem!.bookId)
        }
        delegate?.deleteBook(self)
    }
    public func bookExists(id: Int) {
        
        
        let url = URL(string: "https://booksappsample.herokuapp.com/books/\(id)")
        
        let request = URLRequest(url: url!)
       
            
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
             
            print("working")
            if error != nil  {
                print("Error: error calling ")
                print(error!)
                self.flag = false
            }
            if data == nil {
                print("Error: Did not receive data")
                self.flag = false
                return
            }
            let code = response as? HTTPURLResponse
            if code?.statusCode == 404{
                self.flag = false
                DispatchQueue.main.async {
                    self.view.backgroundColor = UIColor.red
                    print("catched")
                }
                
            }
            
          
        }
        
        task.resume()
        
    }
    
}

