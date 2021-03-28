//
//  CardsPresenter.swift
//  coperTec-test
//
//  Created by CooperTec on 27/03/21.
//  Copyright © 2021 CooperTec. All rights reserved.
//

import Foundation
import UIKit
protocol CardsViewDelegate: NSObjectProtocol {
    func displayCard(description:(String))
}

class CardsPresenter{
    private let apiService:CardsApiService
    weak private var cardViewDelegate : CardsViewDelegate?
    weak var  cardsView: CardsViewController?
    
    var cardsToDisplay = [Card]()
    
    //cache
    var  imageCache = NSCache<AnyObject, AnyObject>()
    var image = UIImage()
    @IBOutlet var cardImageView: UIImageView!
    
    init(apiService:CardsApiService) {
        self.apiService = apiService
    }
    
    func setViewDelegate(cardViewDelegate:CardsViewDelegate?){
        self.cardViewDelegate = cardViewDelegate
    }
    
    // MARK: - Get API data
    func fetchCardsData(completion: @escaping () -> ()) {
        
        // weak self - prevent retain cycles
        apiService.getCardsData { [weak self] (result) in
            
            switch result {
           
            case .success(let listOf):
                self?.cardsToDisplay = listOf.cards
                completion()
               // print(listOf.cards)
             case .failure(let error):
                // Something is wrong with the JSON file or the model
                print("Error processing json data: \(error)")
            }
        }
    }
    
    // MARK: - Set TableView Params
       func numberOfRowsInSection(section: Int) -> Int {
    
           if cardsToDisplay.count != 0 {
               return cardsToDisplay.count
           }
           return 0
       }
       
       func cellForRowAt (indexPath: IndexPath) -> Card {
            
           return cardsToDisplay[indexPath.row]
       }
    // MARK: - from hex to UIColor

    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
 
}
