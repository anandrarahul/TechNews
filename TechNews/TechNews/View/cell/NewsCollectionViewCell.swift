//
//  NewsCollectionViewCell.swift
//  TechNews
//
//  Created by Rahul Anand on 08/05/21.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    
    override func awakeFromNib() {
        self.imageView.image = UIImage(named: "noimage")
    }
    
    func updateCell(_ image: String?, _ title: String?) {
        if let imageUrl = image {
            self.setImageFromUrl(imageURL: imageUrl)
        }
        if let storyTitle = title {
            self.titleLabel.text = storyTitle
        }
    }
    
    private func setImageFromUrl(imageURL :String) {
        URLSession.shared.dataTask( with: NSURL(string:imageURL)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                if let data = data {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }).resume()
    }
}
