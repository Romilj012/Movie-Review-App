//
//  MasterTableViewCell.swift
//  assignment4
//
//  Created by Romil Jain on 4/27/23.
//

import UIKit

class MasterTableViewCell: UITableViewCell {

    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieRatingSlider: UISlider!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
