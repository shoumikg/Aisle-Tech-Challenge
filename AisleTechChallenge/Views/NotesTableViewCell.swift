//
//  NotesTableViewCell.swift
//  AisleTechChallenge
//
//  Created by Shoumik on 08/11/24.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
