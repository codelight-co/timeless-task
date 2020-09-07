//
//  BottomBarItem.swift
//  BottomBar
//
//  Created by le  anh on 9/7/20.
//  Copyright © 2020 Timeless Space. All rights reserved.
//

import SwiftUI

public struct BottomBarItem {
    public let icon: Image
    public let title: String
    public let color: Color
    
    public init(icon: Image,
                title: String,
                color: Color){
        self.icon = icon
        self.title = title
        self.color = color
    }
    
    public init(icon: String,
                title: String,
                color: Color) {
        self = BottomBarItem(icon: Image(systemName: icon),
                             title: title,
                             color: color)
    }
}
