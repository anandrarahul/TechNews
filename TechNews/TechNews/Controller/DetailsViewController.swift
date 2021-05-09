//
//  DetailsViewController.swift
//  TechNews
//
//  Created by Rahul Anand on 08/05/21.
//

import UIKit

class DetailViewControllerDataSource {
    
    var articles: Articles
    
    init(articles: Articles) {
        self.articles = articles
    }
    
}

class DetailsViewController: UIViewController {

    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var authorLabel: UILabel!
    @IBOutlet weak private var publishedAtLabel: UILabel!
    @IBOutlet weak private var urlButton: UIButton!
    
    var dataSource: DetailViewControllerDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateDetails()
    }
    
    func updateDetails() {
        
        if let img = self.dataSource?.articles.urlToImage {
            URLSession.shared.dataTask( with: NSURL(string:img)! as URL, completionHandler: {
                (data, response, error) -> Void in
                DispatchQueue.main.async {
                    if let data = data {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }).resume()
        } else {
            self.imageView.image = UIImage(named: "noimage")
        }
        if let title = self.dataSource?.articles.title {
            self.titleLabel.text = "Title: \(title)"
            self.titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        }
        if let desc = self.dataSource?.articles.description {
            self.descriptionLabel.text = "Description: \(desc)"
        }
        if let contentUrl = self.dataSource?.articles.url {
            self.urlButton.setTitle(contentUrl, for: .normal)
        }
        if let author = self.dataSource?.articles.author {
            self.authorLabel.text = "Author: \(author)"
        }
        if let published = self.dataSource?.articles.publishedAt {
            self.publishedAtLabel.text = "Published By: \(published)"
        }
        
    }

    @IBAction private func urlButtonClicked(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: (self.dataSource?.articles.url)!)!, options: [:], completionHandler: nil)
    }
}
