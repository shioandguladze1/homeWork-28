//
//  CountriesTableViewCell.swift
//  homework28 (shio andghuladze)
//
//  Created by shio andghuladze on 30.08.22.
//

import UIKit

class CountriesTableViewCell: UITableViewCell {
    @IBOutlet weak var countryNameLbl: UILabel!
    
    func setUp(name: String){
        countryNameLbl.text = name
    }

}
