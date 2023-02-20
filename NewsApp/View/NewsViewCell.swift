//
//  NewsViewCell.swift
//  NewsApp
//
//  Created by pvrdixit on 20/02/23.
//

import UIKit
import Kingfisher

class NewsViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var headlinesLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

        
    func configure(_ news: Article) {
        newsImageView.image = UIImage(named: "imageNotAvailable")
        if let urlImageString = news.urlToImage {
            let imageURL = URL(string: urlImageString)
            newsImageView.kf.setImage(with: imageURL)
        }
        headlinesLabel.text = news.headline
        sourceLabel.text = "Source: " + news.source.name
        dateLabel.text = news.datePublished
    }
    
    override func prepareForReuse() {
        newsImageView.image = UIImage(named: "imageNotAvailable")
    }
    
}
