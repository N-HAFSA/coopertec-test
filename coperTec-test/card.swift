//
//  card.swift
//  coperTec-test
//
//  Created by CooperTec on 27/03/21.
//  Copyright © 2021 CooperTec. All rights reserved.
//

import Foundation


 
struct CardsData:Codable{
    let cards:[Card]
    
}
struct Card:Codable{
    
    let name:String
    let card_number:String
    let limit:Int
    let category:Category
        
}  

struct Category:Codable{
    
    let type:String
    let background_color:String
    let image_path:String
}
