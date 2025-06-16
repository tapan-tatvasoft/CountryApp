//
//  CountryListContent.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.
//

import SwiftUI

struct CountryListContent: View {
    let country: Country
    let showAddButton: Bool
    let showDeleteButton: Bool
    let onTap: () -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            
            WebImageView(
                urlString: country.bestFlagURL,
                placeholderImageName: "photo", // SF Symbol or asset
                width: 64,
                height: 32
            )
            
            
//            if let url = URL(string: country.bestFlagURL ?? "") {
//                CachedAsyncImageView(url: url)
//                    .frame(width: 64, height: 32)
//                    .clipShape(RoundedRectangle(cornerRadius: 4))
//                    .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: 2)
//            } else {
//                Image(systemName: "photo")
//                    .resizable()
//                    .frame(width: 64, height: 32)
//            }
            
            Text(country.name.common)
                .font(.headline)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Group {
                if showDeleteButton {
                    Image(systemName: "trash")
                    .foregroundColor(.red)
                } else if showAddButton {
                    Text("✓ Added")
                    .foregroundColor(.gray)
                } else {
                    Image(systemName: "plus.circle.fill")
                    .foregroundColor(.blue)
                }
            }
            .onTapGesture {
                onTap()
            }
            
        }
        .padding(.horizontal)
    }
}
