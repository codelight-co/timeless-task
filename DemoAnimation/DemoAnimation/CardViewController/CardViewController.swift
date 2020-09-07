//
//  CardViewController.swift
//  DemoAnimation
//
//  Created by le  anh on 8/31/20.
//  Copyright © 2020 le  anh. All rights reserved.
//

import Foundation
import UIKit

class CardViewController: UIViewController {
    
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var viewContent: UIView!
    
    func setVisibleLineView()
    {
        lineView.isHidden = false
    }
    
    func setInvibleLinewView()
    {
        lineView.isHidden = true
    }
    
    func setBackground()
    {
        handleArea.backgroundColor = UIColor(red: 41/255, green: 42/255, blue: 47/255, alpha: 1)
        viewContent.backgroundColor = UIColor(red: 41/255, green: 42/255, blue: 47/255, alpha: 1)
    }
    
    func setBackgroundCustomColor()
    {
        handleArea.backgroundColor = UIColor(red: 47/255, green: 48/255, blue: 53/255, alpha: 1)
        viewContent.backgroundColor = UIColor(red: 47/255, green: 48/255, blue: 53/255, alpha: 1)
    }
}
