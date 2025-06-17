//
//  CountryAppApp.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.
//
//
//import SwiftUI
//import SDWebImageSVGCoder
//import SDWebImage

import SwiftUI
import SDWebImageSVGCoder
import SDWebImage
import SwiftData

@main
struct CountryAppApp: App {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var viewModel: CountryListViewModel
    
    // 💾 SwiftData container
    let modelContainer: ModelContainer

    init() {
        // Initialize LocationManager
        let locationManager = LocationManager()
        _locationManager = StateObject(wrappedValue: locationManager)

        // Initialize ViewModel with locationManager
        let vm = CountryListViewModel(apiService: APIManager(), locationManager: locationManager)
        _viewModel = StateObject(wrappedValue: vm)

        // Initialize SwiftData model container
        do {
            modelContainer = try ModelContainer(for: CDCountry.self)
            vm.setContext(modelContainer.mainContext)
        } catch {
            fatalError("⚠️ Failed to initialize ModelContainer: \(error)")
        }
        
        // Register SVG support
        configSDWebImage()
    }
    
    private func configSDWebImage() {
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        
        // Configure timeouts on the existing shared downloader
               let sessionConfig = URLSessionConfiguration.default
               sessionConfig.timeoutIntervalForRequest = 30 // Request timeout
               sessionConfig.timeoutIntervalForResource = 60 // Total resource timeout
        
               // Apply session config to shared downloader
               SDWebImageDownloader.shared.config.sessionConfiguration = sessionConfig
        SDWebImageDownloader.shared.config.maxConcurrentDownloads = 1

       
        
        
    }

    var body: some Scene {
        WindowGroup {
            CountryListview(viewModel: viewModel)
                .modelContainer(modelContainer) // 🔌 inject SwiftData
        }
    }
}
