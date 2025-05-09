//
//  HomeView.swift
//  GOParkin9
//
//  Created by Rico Tandrio on 21/03/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var userSettingsVM: UserSettingsViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    NavigationList()

                    DetailRecord(
                        detailRecordVM: DetailRecordViewModel()
                    )
                }
                .navigationTitle("GOParkin9")
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
