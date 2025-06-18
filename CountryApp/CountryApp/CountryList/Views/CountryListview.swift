//
//  CountryListview.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.

import SwiftUI


struct CountryListview: View {
    
    @ObservedObject var viewModel: CountryListViewModel
    @State private var selectedCountry: Country?
    @State private var showDetails = false
    @State private var countryToDelete: Country?
    @State private var activeAlert: ActiveAlert?

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
            .alert(item: $activeAlert) { alertType in
                switch alertType {
                case .deleteConfirmation:
                    return Alert(
                        title: Text(localizeString("confirmDeletion")),
                        message: Text(localizeString("removeCountryError")),
                        primaryButton: .destructive(Text(localizeString("delete"))) {
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

                case .countryLimit:
                    return Alert(
                        title: Text(localizeString("limitReached")),
                        message: Text(localizeString("countryLimitAlert")),
                        dismissButton: .default(Text(localizeString("ok")))
                    )
                }
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
                        if viewModel.countries.count < 5 {
                            viewModel.addCountry(country)
                        } else {
                            activeAlert = .countryLimit
                        }
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
                        activeAlert = .deleteConfirmation
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

extension ActiveAlert: Identifiable {
    var id: Int {
        switch self {
        case .deleteConfirmation: return 0
        case .countryLimit: return 1
        }
    }
}
