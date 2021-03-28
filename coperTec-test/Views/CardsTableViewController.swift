//
//  TableViewController.swift
//  coperTec-test
//
//  Created by CooperTec on 27/03/21.
//  Copyright © 2021 CooperTec. All rights reserved.
//

import UIKit

extension CardsViewController : UITableViewDataSource,UITableViewDelegate  {

      func setupTableView(){
        
        tableView.dataSource = self
        tableView.delegate = self
 
    }
    
    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if (cardsPresenter.cardsToDisplay.count == 0 ){
            tableView.setEmptyView(message: "You don't have any Cards yet.")
        }else {
            tableView.restore()
        }
        return cardsPresenter.numberOfRowsInSection(section: section)
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //init cell
        let cell =  tableView.dequeueReusableCell(withIdentifier: "CardsViewControllerCell", for: indexPath) as! CardsTableViewCell
        let cards = cardsPresenter.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(cards)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // performSegue(withIdentifier: "CardDetails", sender: self)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CardsDetailsViewController{
            destination.card = cardsPresenter.cellForRowAt(indexPath: tableView.indexPathForSelectedRow!)
           // destination.CardImage = 
         }
        
    }
}

extension UITableView {
    func setEmptyView(message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()

        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.textColor = UIColor.lightGray
        titleLabel.font = UIFont(name: "HelveticaNeue-semibold", size: 18)

        emptyView.addSubview(titleLabel)

        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
            
        titleLabel.text = message
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
       
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
    
    
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
