//
//  publicViewCell.swift
//  YaraCan
//
//  Created by MAC13 on 19/06/19.
//  Copyright © 2019 Fernando Huarcaya Torres. All rights reserved.
//

import UIKit

class publicViewCell: UITableViewCell {

    
    @IBOutlet weak var imagenPet: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descripcion: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
