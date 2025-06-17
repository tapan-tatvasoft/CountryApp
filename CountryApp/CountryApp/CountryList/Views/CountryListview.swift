//
//  CountryListview.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.

import SwiftUI

import SwiftUI

struct CountryListview: View {
    
    @ObservedObject var viewModel: CountryListViewModel
    @State private var selectedCountry: Country?
    @State private var showDetails = false
    @State private var countryToDelete: Country?
    @State private var showDeleteConfirmation = false
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $viewModel.searchText, searchText: localizeString("searchBarPlaceholder"))
                    .padding(.horizontal)
                
                if viewModel.isLoading {
                    ProgressView(localizeString("loadingText"))
                }
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
                
                if viewModel.searchText.isEmpty && viewModel.countries.isEmpty {
                    Spacer()
                    Text(localizeString("noDataFound"))
                        .font(.body)
                        .foregroundStyle(.gray)
                        .padding(.horizontal)
                    Spacer()
                } else {
                    List {
                        if !viewModel.searchText.isEmpty {
                            searchSection
                        }
                        
                        if !viewModel.countries.isEmpty {
                            storedSection
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle(localizeString("countryListTitle"))
            .navigationDestination(isPresented: $showDetails) {
                if let selected = selectedCountry {
                    CountryDetailView(country: selected)
                }
            }
            // Confirmation Alert
            .alert(isPresented: $showDeleteConfirmation) {
                Alert(
                    title: Text("Confirm Deletion"),
                    message: Text("Are you sure you want to remove this country?"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let country = countryToDelete,
                           let index = viewModel.countries.firstIndex(where: { $0.id == country.id }) {
                            viewModel.removeCountry(at: IndexSet(integer: index))
                        }
                        countryToDelete = nil
                    },
                    secondaryButton: .cancel {
                        countryToDelete = nil
                    }
                )
            }
        }
    }
    
    private var searchSection: some View {
        Section(header: Text(localizeString("searchResults"))) {
            ForEach(viewModel.searchResults) { country in
                
                CountryListContent(
                    country: country,
                    showAddButton: viewModel.countries.contains(where: { $0.id == country.id }),
                    showDeleteButton: false,
                    onTap: {
                        viewModel.addCountry(country)
                    }
                )
                
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedCountry = country
                    showDetails = true
                }
                
            }
        }
    }
    
    private var storedSection: some View {
        Section(header: Text(localizeString("yourCountries"))) {
            ForEach(viewModel.countries) { country in
                CountryListContent(
                    country: country,
                    showAddButton: false,
                    showDeleteButton: true,
                    onTap: {
                        countryToDelete = country
                        showDeleteConfirmation = true
                    }
                )
                
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedCountry = country
                    showDetails = true
                }
            }
        }
    }
}

#Preview {
    let viewModel = CountryListViewModel(locationManager: LocationManager())
    CountryListview(viewModel: viewModel)
}

