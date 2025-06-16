//
//  CountryAppApp.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.
//

import SwiftUI
import SDWebImageSVGCoder
import SDWebImage

@main
struct CountryAppApp: App {
    @StateObject private var viewModel = CountryListViewModel(apiService: APIManager())
    
    init() {
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CountryListview(viewModel: viewModel)
            }
        }
    }
}
