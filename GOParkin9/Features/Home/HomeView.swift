//
//  HomeView.swift
//  GOParkin9
//
//  Created by Rico Tandrio on 21/03/25.
//

import SwiftUI

struct NavigationListView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        Section(header:
            VStack(alignment: .leading) {
                Text("Navigate Around")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text("Where do you want to go?")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
            }
        ) {
            ScrollView(.horizontal, showsIndicators: false) {
                // MARK: - Defined Location List
                HStack(alignment: .top, spacing: 30) {
                    ForEach(viewModel.navigations) { navigation in
                        Button {
                            viewModel.setSelectedNavigation(to: navigation.id)
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
                .padding(.leading, 8)
                .padding(.vertical)
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
    }
}

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // MARK: - Navigate to Defined Location
                    VStack(alignment: .leading) {
                        NavigationListView(viewModel: viewModel)
                    }
                    
                    // MARK: - Currently Parked Information
                    VStack(alignment: .leading) {
                        Section {
                            if viewModel.activeParkingRecord != nil {
                                DetailRecordActive(viewModel: viewModel)
                            } else {
                                DetailRecordInactive(viewModel: viewModel)
                            }
                        } header: {
                            VStack(alignment: .leading) {
                                Text("Currently Parked")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                
                                if let _ = viewModel.activeParkingRecord {
                                    Text("Details of your parking activity")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(.secondary)
                                } else {
                                    Text("There's no record of your parking activity")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(.secondary)
                                    
                                }
                            }
                            .padding(.vertical)
                        }
                    }
                }
                .navigationTitle("GOParkin9")
                .padding()
                .onAppear() {
                    viewModel.synchronize()
                }
                .onOpenURL { url in
                    if url == URL(string: AppLinks.viewCompassUrl) {
                        viewModel.isActiveRecordCompassOpen = true
                    }
                }
                .onChange(of: viewModel.selectedNavigation) {
                    viewModel.isNavigationButtonCompassOpen.toggle()
                }
                .alertComponent(
                    isPresented: $viewModel.isCompleteAlert,
                    title: "Complete this record?",
                    message: "This action will move the record to history and cannot be undone.",
                    confirmAction: viewModel.complete,
                    confirmButtonText: "Complete",
                    confirmButtonRole: .destructive
                )
                .fullScreenCover(isPresented: $viewModel.isPreviewOpen) {
                    if let image = viewModel.activeParkingRecord?.images[viewModel.selectedImageIndex].getImage() {
                        ImagePreviewView(imageName: image, isPresented: $viewModel.isPreviewOpen)
                    }
                }
                .fullScreenCover(isPresented: $viewModel.isNavigationButtonCompassOpen) {
                    CompassView(
                        isCompassOpen: $viewModel.isNavigationButtonCompassOpen,
                        selectedLocation: viewModel.selectedNavigation,
                        longitude: 0,
                        latitude: 0
                    )
                }
                .fullScreenCover(isPresented: $viewModel.isActiveRecordCompassOpen) {

                    if let record = viewModel.activeParkingRecord {
                        CompassView(
                            isCompassOpen: $viewModel.isActiveRecordCompassOpen,
                            selectedLocation: 6,
                            longitude: record.longitude,
                            latitude: record.latitude
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
