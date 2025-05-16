//
//  GOParkin9App.swift
//  GOParkin9
//
//  Created by Rico Tandrio on 20/03/25.
//

import SwiftUI
import SwiftData
import WidgetKit

@main
struct GOParkin9App: App {
    
    @StateObject private var appStartVM: AppStartViewModel = AppStartViewModel()
    
    static let parkingRecordRepository: ParkingRecordRepositoryProtocol = ParkingRecordRepository()

    var body: some Scene {
        WindowGroup {
            if appStartVM.isSplashActive {
                SplashScreenView()
                    .onAppear {
                        appStartVM.startSplashTimer()
                    }
            } else {
                ContentView()
                    .modelContainer(appStartVM.sharedModelContainer)
                    .fullScreenCover(isPresented: $appStartVM.isFirstLaunch) {
                        WelcomeScreenView(
                            isFirstLaunch: $appStartVM.isFirstLaunch
                        )
                    }
                    .onAppear() {
                        GOParkin9App.parkingRecordRepository.setContext(appStartVM.sharedModelContainer.mainContext)
                        
                        WidgetCenter.shared.reloadTimelines(ofKind: "GOParkin9Widget")
                    }
            }
        }
    }
}
