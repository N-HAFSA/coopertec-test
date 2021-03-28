//
//  CardsViewController.swift
//  coperTec-test
//
//  Created by CooperTec on 27/03/21.
//  Copyright © 2021 CooperTec. All rights reserved.
//
/*****   PS : Not done yet ******/

//need to add image in case of nil
//cast the limite in to show the number without optional
//navigate to the second view

import UIKit

class CardsViewController: UIViewController {

    
    var cardsPresenter = CardsPresenter(apiService: CardsApiService())
    
    var cellController = CardsTableViewCell()
    
    
    let network = NetworkManager.sharedInstance
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //check the internet
        network.reachability.whenUnreachable = { reachability in
            self.CloseOnOfflinePage()
        }
    //-------API RESULTS
        cardsPresenter.fetchCardsData{ [weak self] in
        self?.tableView.dataSource = self
        self?.tableView.reloadData()
        
    }
        
        
    }
    //offline
    private func CloseOnOfflinePage() -> Void {
       
        let alert = UIAlertController(title: "No Internet", message: "This App Requires internet connection!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: {_ in
           exit(0)
        }))
        self.present(alert, animated: true, completion: nil)
   }

    
}
