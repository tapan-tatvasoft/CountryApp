//
//  WebImageView.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct WebImageView: View {
    let urlString: String?
    let placeholderImageName: String
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        if let url = URL(string: urlString ?? "") {
            WebImage(url: url)
                .resizable()
                .indicator(.activity) // ✅ loading spinner
                .transition(.fade(duration: 0.25))
                .scaledToFit()
                .frame(width: width, height: height)
                .clipped()
        } else {
            Image(systemName: placeholderImageName)
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
                .foregroundColor(.gray)
        }
    }
}
