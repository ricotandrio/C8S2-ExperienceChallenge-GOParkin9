//
//  HomeModel.swift
//  GOParkin9
//
//  Created by Rico Tandrio on 15/05/25.
//

import Foundation
import SwiftUI

struct NavigationButtonModel: Identifiable {
    let id: Int
    let name: String
    let icon: String
}

struct NavigationButtonView: View {
    var action: () -> Void
    var navigation: NavigationButtonModel
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                Image(systemName: navigation.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 40)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .frame(width: 60, height: 60)

                Text(navigation.name)
                    .font(.caption)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: 80)
                    .padding(.top, 5)
                    .foregroundColor(Color.primary)

            }
            .contentShape(Rectangle())
        }
    }
}
