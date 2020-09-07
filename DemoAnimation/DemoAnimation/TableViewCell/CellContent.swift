//
//  CellContent.swift
//  DemoAnimation
//
//  Created by le  anh on 9/1/20.
//  Copyright © 2020 le  anh. All rights reserved.
//

import Foundation
import UIKit

class CellContent: UITableViewCell {

    @IBOutlet weak var lbContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setText(content: String)
    {
        lbContent.text = content
    }
}
