//
//  MovieListCell.swift
//  MoviesTask
//
//  Created by mac on 2/27/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class MovieListCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var MovieTitle: UILabel!
    @IBOutlet weak var movieOverall: UILabel!
    @IBOutlet weak var date: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    
    
    func configration(data:results)  {
        self.MovieTitle.text=data.title
        self.movieOverall.text=data.overview
        self.date.text=data.release_date

        let baseURL="https://image.tmdb.org/t/p/w500/"
        let imagePath=data.poster_path //?? "PlaceholderImage"
        
        if imagePath == nil {
            let   stringimage="PlaceholderImage"
            
            if let imageURL = URL(string: stringimage) {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.photo.image = image
                        }
                    }
                }
            }

        }else{
        
            let stringimage=baseURL+"\(imagePath!)"
        
        
        
       
        if let imageURL = URL(string: stringimage) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                      self.photo.image = image
                    }
                }
            }
        }
        }

    }
    
    
    func configrationData(data:Movie)  {
        self.MovieTitle.text=data.title
        self.movieOverall.text=data.overview
        self.date.text=String(describing: data.date!)
        
        let baseURL="https://image.tmdb.org/t/p/w500/"
        let imagePath=data.photo
        let stringimage=baseURL+"\(imagePath)"
        
        self.photo.image = UIImage(data: imagePath as! Data)
        
//        if let imageURL = URL(string: imagePath) {
//            DispatchQueue.global().async {
//                let data = try? Data(contentsOf: imageURL)
//                if let data = data {
//                    let image = UIImage(data: data)
//                    DispatchQueue.main.async {
//                        self.photo.image = image
//                    }
//                }
//            }
//        }
        
    }
    
    
    
}
