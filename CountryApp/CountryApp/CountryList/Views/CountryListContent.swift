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
                placeholderImageName: SystemIcons.photo,
                width: 64,
                height: 32
            )
            
            Text(country.name.common)
                .font(.headline)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Group {
                if showDeleteButton {
                    Image(systemName: SystemIcons.trash)
                    .foregroundColor(.red)
                } else if showAddButton {
                    Text(localizeString("correctText"))
                    .foregroundColor(.gray)
                } else {
                    Image(systemName: SystemIcons.plusCircleFill)
                    .foregroundColor(.blue)
                }
            }
            .onTapGesture {
                onTap()
            }
            
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
    }
}
