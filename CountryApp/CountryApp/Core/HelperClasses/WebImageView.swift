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
        if let urlString = urlString,
           let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: encoded) {

            WebImage(url: url)
                .resizable()
                .indicator(SDWebImageSwiftUI.Indicator.activity)
                .transition(.fade(duration: 0.3))
                .scaledToFit()
                .frame(width: width, height: height)
                .clipped()
                .background(
                    Image(systemName: placeholderImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width, height: height)
                        .opacity(0.3)
                )

        } else {
            Image(systemName: placeholderImageName)
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
                .foregroundColor(.gray)
        }
    }
}
