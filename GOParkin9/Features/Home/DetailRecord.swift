//
//  DetailRecord.swift
//  GOParkin9
//
//  Created by Rico Tandrio on 24/03/25.
//

import SwiftUI
import SwiftData

struct DetailRecord: View {

    @StateObject var detailRecordVM: DetailRecordViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Section {
                if detailRecordVM.activeParkingRecord != nil {
                    DetailRecordActive(
                        detailRecordVM: detailRecordVM
                    )
                } else {
                    DetailRecordInactive()
                }

            } header: {
                VStack(alignment: .leading) {
                    Text("Currently Parked")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    if let _ = detailRecordVM.activeParkingRecord {
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
            .alertComponent(
                isPresented: $detailRecordVM.isComplete,
                title: "Complete this record?",
                message: "This action will move the record to history and cannot be undone.",
                confirmAction: detailRecordVM.complete,
                confirmButtonText: "Complete",
                confirmButtonRole: .destructive
            )
            .fullScreenCover(isPresented: $detailRecordVM.isPreviewOpen) {
                if let image = detailRecordVM.activeParkingRecord?.images[detailRecordVM.selectedImageIndex].getImage() {
                    ImagePreviewView(imageName: image, isPresented: $detailRecordVM.isPreviewOpen)
                }
            }
            .fullScreenCover(isPresented: $detailRecordVM.isCompassOpen) {

                if let record = detailRecordVM.activeParkingRecord {
                    CompassView(
                        isCompassOpen: $detailRecordVM.isCompassOpen,
                        selectedLocation: 6,
                        longitude: record.longitude,
                        latitude: record.latitude
                    )
                }
            }
            .onAppear() {
                detailRecordVM.synchronize()
            }
        }
        .onOpenURL { url in
            if url == URL(string: AppLinks.viewCompassUrl) {
                detailRecordVM.isCompassOpen = true
            }
        }
    }
}

#Preview {
    ContentView()
}
