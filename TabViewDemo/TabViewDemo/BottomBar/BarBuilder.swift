//
//  BarBuilder.swift
//  BottomBar
//
//  Created by le  anh on 9/7/20.
//  Copyright © 2020 Timeless Space. All rights reserved.
//

import Foundation


@_functionBuilder
public struct BarBuilder{}


public extension BarBuilder{
    
    
    static func buildBlock(_ items: BottomBarItem...) -> [BottomBarItem]{
        items
    }
    
    
}
