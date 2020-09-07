//
//  Handle.swift
//  SlideOverlayCard
//
//  Created by le  anh on 9/7/20.
//  Copyright © 2020 Timeless Space. All rights reserved.
//

import Foundation
import SwiftUI

struct Handle : View {
    private let handleThickness = CGFloat(5.0)
    var body: some View {
        RoundedRectangle(cornerRadius: handleThickness / 2.0)
            .frame(width: 40, height: handleThickness)
            .foregroundColor(Color.secondary)
            .padding(5)
    }
}
