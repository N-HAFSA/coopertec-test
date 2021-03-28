//
//  CardsDetailsViewController.swift
//  coperTec-test
//
//  Created by Suporte on 27/03/21.
//  Copyright © 2021 CooperTec. All rights reserved.
//

import UIKit

class CardsDetailsViewController: UIViewController {

    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var limit: UILabel!
    @IBOutlet weak var card_number: UILabel!
    
    private var urlString: String = ""
    //cache
    var  imageCache = NSCache<AnyObject, AnyObject>()
    
    var CardImage =  UIImage()
    var card:Card?
    
    var cardsPresenter = CardsPresenter(apiService: CardsApiService())
    
    var cellController = CardsTableViewCell()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //cardImage.image = card.
        name.text = card?.name
        limit.text = "R$" + String(card!.limit)
        card_number.text =  card?.card_number
        let  imageUrl =  card?.category.image_path
        guard let imageURL = imageUrl else {return}
        urlString = imageURL
        
        guard let posterImageURL = URL(string: urlString) else {
            self.cardImage.image = UIImage(named: "noImageAvailable")
            return
        }
     
        getImageDataFrom(url: posterImageURL)

 }
    
    // MARK: - Get image data
    private func getImageDataFrom(url: URL) {
        //if cached use it
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.cardImage.image = cachedImage
             
        }
        else{
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                // Handle Error
                if let error = error {
                    print("DataTask error: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    // Handle Empty Data
                    print("Empty Data")
                    return
                }
                
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self.cardImage.image = image
                        //cache
                        self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    }
                    
                }
            }.resume()
        }
        
    }


}
