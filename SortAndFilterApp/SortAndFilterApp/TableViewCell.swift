//
//  TableViewCell.swift
//  SortAndFilterApp
//
//  Created by ISHAN ARUN PANT on 23/5/20.
//  Copyright © 2020 ISHAN ARUN PANT. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    
    
    @IBOutlet weak var lblNumber: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
