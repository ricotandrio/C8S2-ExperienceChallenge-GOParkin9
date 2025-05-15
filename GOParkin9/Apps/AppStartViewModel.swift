//
//  UserStartViewModel.swift
//  GOParkin9
//
//  Created by Rico Tandrio on 20/04/25.
//

import SwiftUI
import SwiftData

class AppStartViewModel: ObservableObject {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    @Published var isSplashActive = true
    
    @Environment(\.scenePhase) var scenePhase
    
    @Published var isFirstLaunch: Bool {
        didSet {
            appStorageManager.markAppAsLaunched()
        }
    }
    
    var sharedModelContainer: ModelContainer
    
    private var appStorageManager: AppStorageProtocol
    
    init(appStorageManager: AppStorageProtocol = AppStorageManager()) {
        // Initialize the shared ModelContainer
        self.sharedModelContainer = {
            let schema = Schema([ParkingRecord.self])
            let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            return try! ModelContainer(for: schema, configurations: [config])
        }()
        
        self.appStorageManager = appStorageManager
        
        self.isFirstLaunch = appStorageManager.getIsFirstLaunch()
    }
    
    func startSplashTimer() {
        Task {
            try? await Task.sleep(nanoseconds: 3_000_000_000)
            withAnimation {
                self.isSplashActive = false
            }
        }
    }
}
