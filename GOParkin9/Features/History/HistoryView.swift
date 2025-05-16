//
//  HistoryView.swift
//  GOParkin9
//
//  Created by Rico Tandrio on 23/03/25.
//  Edited by Chikmah on 26/03/25.
//

import SwiftUI
import SwiftData


struct HistoryView: View {
    @StateObject var viewModel: HistoryViewModel
    
    var body: some View {
        NavigationStack {
            List {

                if viewModel.histories.isEmpty {
                    Text("No history yet")
                        .foregroundColor(.secondary)
                }
                
                Group {
                    if !viewModel.getAllPinnedHistories().isEmpty {
                        HStack {
                            Image(systemName: "pin")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(.trailing, 10)
                            
                            
                            Text("Pinned")
                                .font(.headline)
                                .fontWeight(.bold)
                                .opacity(0.6)
                        }
                        
                        ForEach(viewModel.getAllPinnedHistories()) { entry in
                            HistoryCard(
                                entry: entry,
                                pinItem: { viewModel.pinItem(entry) },
                                deleteItem: {
                                    viewModel.selectedHistoryToBeDeleted = entry
                                    viewModel.showAlertDeleteSingle.toggle()
                                },
                                isSelecting: viewModel.isSelecting,
                                isSelected: viewModel.selectedParkingRecords.contains(entry.id),
                                toggleSelection: { viewModel.toggleSelection(entry) }
                            )
                        }
                    }
                }
                
                Group {
                    if !viewModel.getAllUnpinnedHistories().isEmpty {
                        HStack {
                            Image(systemName: "clock.arrow.circlepath")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(.trailing, 10)
                            
                            
                            Text("All History")
                                .font(.headline)
                                .fontWeight(.bold)
                                .opacity(0.6)
                        }
                        
                        ForEach(viewModel.getAllUnpinnedHistories(), id: \.id) { entry in
                            HistoryCard(
                                entry: entry,
                                pinItem: { viewModel.pinItem(entry) },
                                deleteItem: {
                                    viewModel.selectedHistoryToBeDeleted = entry
                                    viewModel.showAlertDeleteSingle.toggle()
                                },
                                isSelecting: viewModel.isSelecting,
                                isSelected: viewModel.selectedParkingRecords.contains(entry.id),
                                toggleSelection: { viewModel.toggleSelection(entry) }
                            )
                        }
                        
                    }
                }
            }
            .navigationTitle("History")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {

                        // Button for sort the history by date
                        Button {
                            viewModel.isDescending.toggle()
                        } label: {
                            Text("Sort by Date")
                            Text("\(viewModel.isDescending ? "Most Recent First" : "Oldest First")")
                                .font(.subheadline)
                            Image(systemName: "arrow.up.arrow.down")
                        }
                        
                        Button {
                            viewModel.navigateToConfigAutomaticDelete.toggle()
                        } label: {
                            Text("Delete Automatically")
                            Text("History will be deleted after \(viewModel.daysBeforeAutomaticDelete) days")
                                .font(.subheadline)
                            Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                        }
                        
                        // Button for cancel the selection
                        Button {
                            if !viewModel.histories.isEmpty {
                                viewModel.cancelSelection()
                            } else {
                                viewModel.showAlertHistoryEmpty.toggle()
                            }
                        } label: {
                            Text(viewModel.isSelecting ? "Cancel" : "Select")
                            Text(viewModel.isSelecting ? "Cancel Selection" : "Select Multiple")
                                .font(.subheadline)
                            Image(systemName: viewModel.isSelecting ? "checkmark.circle" : "checkmark.circle.fill")
                        }
                        
                        // Button for delete the selected history only if the selection is active
                        if viewModel.isSelecting && !viewModel.selectedParkingRecords.isEmpty {
                            Button {
                                viewModel.showAlertDeleteSelection.toggle()
                            } label: {
                                Text("Delete Selected")
                                Text("\(viewModel.selectedParkingRecords.count) selected")
                                    .font(.subheadline)
                                Image(systemName: "trash")
                            }
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.navigateToConfigAutomaticDelete) {
                ConfigAutomaticDeleteView(daysBeforeAutomaticDelete: $viewModel.daysBeforeAutomaticDelete)
            }
        }
        .onAppear {
            // This responsible for delete the history after certain days
            viewModel.automaticDeleteHistoryAfter(
                viewModel.daysBeforeAutomaticDelete
            )
            
            // This responsible for synchronize the history
            viewModel.synchronize()
        }
        .alertComponent(
            isPresented: $viewModel.showAlertHistoryEmpty,
            title: "There's no history yet",
            message: "Please complete a parking first.",
            confirmButtonText: "OK"
        )
        .alertComponent(
            isPresented: $viewModel.showAlertDeleteSelection,
            title: "Delete All Selected Records?",
            message: "This action cannot be undone.",
            confirmAction: viewModel.deleteSelection,
            confirmButtonText: "Delete",
            confirmButtonRole: .destructive
        )
        .alertComponent(
            isPresented: $viewModel.showAlertDeleteSingle,
            title: "Delete This Record?",
            message: "This action cannot be undone.",
            confirmAction: {
                if let entry = viewModel.selectedHistoryToBeDeleted {
                    viewModel.deleteItem(entry)
                }
            },
            confirmButtonText: "Delete",
            confirmButtonRole: .destructive
        )
    }
}

#Preview {
    ContentView()
}
