//
//  BarBuilder.swift
//  BottomBar
//
//  Created by le  anh on 9/7/20.
//  Copyright © 2020 Timeless Space. All rights reserved.
//
import SwiftUI

public struct BottomBar : View {
    @Binding public var selectedIndex: Int
    
    public let items: [BottomBarItem]
    
    public init(selectedIndex: Binding<Int>, items: [BottomBarItem]) {
        self._selectedIndex = selectedIndex
        self.items = items
    }
    
    
    public init(selectedIndex: Binding<Int>, @BarBuilder items: () -> [BottomBarItem]){
        self = BottomBar(selectedIndex: selectedIndex,
                         items: items())
    }
    
    
    public init(selectedIndex: Binding<Int>, item: BottomBarItem){
        self = BottomBar(selectedIndex: selectedIndex,
                         items: [item])
    }
    
    
    func itemView(at index: Int) -> some View {
        Button(action: {
            withAnimation { self.selectedIndex = index }
        }) {
            BottomBarItemView(selected: self.$selectedIndex,
                              index: index,
                              item: items[index])
        }
    }
    
    public var body: some View {
        HStack(alignment: .bottom) {
            ForEach(0..<items.count) { index in
                self.itemView(at: index)
                
                if index != self.items.count-1 {
                    Spacer()
                }
            }
        }
        .padding()
        .animation(.default)
    }
}

#if DEBUG
struct BottomBar_Previews : PreviewProvider {
    static var previews: some View {
        BottomBar(selectedIndex: .constant(0), items: [
            BottomBarItem(icon: Image("tab_bar_home0_icon"), title: "Home", color: .purple),
            BottomBarItem(icon: Image("tab_bar_agenda_icon"), title: "Calendar", color: .pink),
            BottomBarItem(icon: Image("tab_bar_feed_icon"), title: "Feed", color: .orange),
            BottomBarItem(icon: Image("tab_bar_create_icon"), title: "Create", color: .blue)
        ])
    }
}
#endif
