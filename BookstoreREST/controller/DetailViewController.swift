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
    
    
    func configureView() {
        // Update the user interface for the detail item.
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
    
}

