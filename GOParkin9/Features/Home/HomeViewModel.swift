//
//  HomeViewModel.swift
//  GOParkin9
//
//  Created by Rico Tandrio on 15/05/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var isActiveRecordCompassOpen: Bool = false
    @Published var isNavigationButtonCompassOpen: Bool = false
    
    @Published var selectedNavigation:Int = 0
    
    @Published var selectedImageIndex = 0
    @Published var isPreviewOpen = false
    
    @Published var isCompleteAlert: Bool = false
    @Published var activeParkingRecord: ParkingRecord?
    
    let navigations: [NavigationButtonModel] = [
        .init(id:1, name: "Entry Gate Basement 1", icon: "pedestrian.gate.open"),
        .init(id:2, name: "Exit Gate Basement 1", icon: "pedestrian.gate.closed"),
        .init(id:3, name: "Charging Station", icon: "bolt.car"),
        .init(id:4, name: "Entry Gate Basement 2", icon: "pedestrian.gate.open"),
        .init(id:5, name: "Exit Gate Basement 2", icon: "pedestrian.gate.closed"),
    ]
    
    init() { }
    
    func setSelectedNavigation(to id: Int) {
        self.selectedNavigation = id
    }
    
    func synchronize() {
        switch GOParkin9App.parkingRecordRepository.getActiveParkingRecord() {
        case .success(let record):
            self.activeParkingRecord = record
        case .failure(let error):
            print("Error fetching active parking record: \(error)")
        }
    }
    
    func complete() {
        guard let record = activeParkingRecord else { return }
        
        switch GOParkin9App.parkingRecordRepository.update(
            parkingRecord: record,
            latitude: record.latitude,
            longitude: record.longitude,
            isPinned: record.isPinned,
            isHistory: true,
            images: record.images,
            floor: record.floor,
            completedAt: Date.now
        ) {
            
        case .success(let updatedEntry):
            print("Parking record updated successfully: \(updatedEntry)")
        case .failure(let error):
            print("Error updating parking record: \(error)")
        }
        
        self.synchronize()
    }
}
