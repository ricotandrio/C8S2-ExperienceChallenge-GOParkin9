//
//  ContentView.swift
//  GOParkin9
//
//  Created by Rico Tandrio on 20/03/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            TabView {
                HomeView(viewModel: HomeViewModel())
                   .tabItem {
                       Label("Menu", systemImage: "house")
                   }

                HistoryView(
                    viewModel: HistoryViewModel()
                )
                   .tabItem {
                       Label("History", systemImage: "clock")
                   }
            }
        }
        .ignoresSafeArea(.keyboard)
        .environment(\.sizeCategory, .large)
    }
}

#Preview {
    ContentView()
}
