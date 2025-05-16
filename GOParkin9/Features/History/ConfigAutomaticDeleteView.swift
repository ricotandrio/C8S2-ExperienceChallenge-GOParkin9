//
//  ConfigAutomaticDeleteView.swift
//  GOParkin9
//
//  Created by Rico Tandrio on 31/03/25.
//

import SwiftUI

struct ConfigAutomaticDeleteView: View {
    @Binding var daysBeforeAutomaticDelete: Int
    
    var body: some View {
        List {
            Section(header: Text("Delete History After")) {
                ForEach([1, 3, 5, 7, 14, 30, 60, 90], id: \.self) { option in
                    HStack {
                        Text("\(option) Days\(option == 5 ?  " (Default)" : "")")
                        
                        Spacer()
                        
                        if daysBeforeAutomaticDelete == option {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        daysBeforeAutomaticDelete = option
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
