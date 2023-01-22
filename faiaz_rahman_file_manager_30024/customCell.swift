//
//  customCell.swift
//  faiaz_rahman_file_manager_30024
//
//  Created by Faiaz Rahman on 21/12/22.
//

import UIKit

class customCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
