//
//  ContentView.swift
//  TabViewDemo
//
//  Created by Lucas Wilkinson on 8/28/20.
//  Copyright © 2020 Timeless Space. All rights reserved.
//

import SwiftUI
import Introspect


let itemsBottomTabs: [BottomBarItem] = [
    BottomBarItem(icon: Image("tab_bar_home0_icon"), title: "Home", color: .purple),
    BottomBarItem(icon: Image("tab_bar_agenda_icon"), title: "Calendar", color: .pink),
    BottomBarItem(icon: Image("tab_bar_feed_icon"), title: "Feed", color: .orange),
    BottomBarItem(icon: Image("tab_bar_create_icon"), title: "Create", color: .blue)
]

struct BasicView: View {
    let item: BottomBarItem
    
    var detailText: String {
        "\(item.title) Detail"
    }
    
    var infoView: some View {
            VStack {
                Text("Le Anh")
                    .font(.headline)
                    .foregroundColor(item.color)
                
                Text("anh.tranle@ncc.asia")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
    }
    
    var destination: some View {
        Text(detailText)
            .navigationBarTitle(Text(detailText))
    }
    
    var navigateButton: some View {
        NavigationLink(destination: destination) {
            ZStack {
                Rectangle()
                    .fill(item.color)
                    .cornerRadius(8)
                    .frame(height: 52)
                    .padding(.horizontal)
                
                Text("Navigate")
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            infoView
            Spacer()
        }
    }
}

struct ContentView : View {
    @State private var selectedIndex: Int = 0
    
    var selectedItem: BottomBarItem {
        itemsBottomTabs[selectedIndex]
    }
    
    var body: some View {
        ZStack(alignment: Alignment.top) {
            VStack {
                BasicView(item: selectedItem)
                    .navigationBarTitle(Text(selectedItem.title))
                BottomBar(selectedIndex: $selectedIndex, items: itemsBottomTabs).padding(.bottom, 50)
            }
            SlideOverCard {
                VStack {
                    Text("Overlay View")
                        .font(.headline)
                    Spacer()
                }
            }.edgesIgnoringSafeArea(.vertical)
        }
    }
}
