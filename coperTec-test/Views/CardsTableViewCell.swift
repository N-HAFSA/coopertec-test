//
//  CardsTableViewCell.swift
//  coperTec-test
//
//  Created by CooperTec on 27/03/21.
//  Copyright © 2021 CooperTec. All rights reserved.
//

import UIKit

class CardsTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var card_number: UILabel!
    @IBOutlet weak var limit: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var imageViewHolder: UIView!
    
    private var urlString: String = ""
    //cache
    var  imageCache = NSCache<AnyObject, AnyObject>()
 
    var cardsPresenter = CardsPresenter(apiService: CardsApiService())

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // Setup cards values
    func setCellWithValuesOf(_ card:Card ) {
        
        
        updateUI(name: card.name, card_number: card.card_number, limit: card.limit, avatar: card.category.image_path,background_color: card.category.background_color)
    }
    
    
    // Update the UI Views
    private func updateUI(name: String?, card_number: String?, limit: Int?, avatar: String?,background_color:String) {
           
        self.name.text = name
        self.card_number.text = "**** " + card_number!
        self.limit.text =  "R$" +  String(limit!)
        self.card_number.textColor = cardsPresenter.hexStringToUIColor(hex: background_color)
        imageViewHolder.backgroundColor = cardsPresenter.hexStringToUIColor(hex: background_color)
           guard let avatar = avatar else {return}
           urlString = avatar
           
           guard let posterImageURL = URL(string: urlString) else {
               self.avatar.image = UIImage(named: "noImageAvailable")
               return
           }
           
           getImageDataFrom(url: posterImageURL)

           
       }
       // MARK: - Get image data
       private func getImageDataFrom(url: URL) {
           //if cached use it
           if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
               self.avatar.image = cachedImage
                
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
                            
                           self.avatar.image = image
                           //cache
                           self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                       }
                       
                   }
               }.resume()
           }
           
       }

}
