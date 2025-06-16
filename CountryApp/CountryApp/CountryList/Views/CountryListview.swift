//
//  CountryListview.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.
//
//
//import SwiftUI
//
//struct CountryListview: View {
//    
//    @ObservedObject var viewModel: CountryListViewModel
//    
//    var body: some View {
//        VStack {
//            SearchBar(text: $viewModel.searchText, searchText: "Search a country to add")
//                .padding(.horizontal)
//            
//            ScrollView {
//                LazyVStack {
//                    ForEach(viewModel.countries) { country in
//                        NavigationLink(destination: CountryDetailView(country: country)) {
//                            CountryListContent(country: country)
//                            Divider()
//                                .background(Color.red)
//                                
//                        }
//                    }
//                }
//                
//               // .onDelete(perform: viewModel.removeCountry)
//            }
//            .navigationTitle("Countries")
////            .task {
////                await viewModel.fetchCountries()
////            }
//            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
//                Button("OK", role: .cancel) { }
//            } message: {
//                Text(viewModel.errorMessage ?? "")
//            }
//        }
//    }
//}
//
#Preview {
    let viewModel = CountryListViewModel()
    CountryListview(viewModel: viewModel)
}

import SwiftUI

struct CountryListview: View {
    
    @ObservedObject var viewModel: CountryListViewModel
    @State private var selectedCountry: Country?
    @State private var showDetails = false

    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $viewModel.searchText, searchText: "Search a country to add")
                    .padding(.horizontal)

                if viewModel.isLoading {
                    ProgressView("Loading...")
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }

                if viewModel.searchText.isEmpty && viewModel.countries.isEmpty {
                    Spacer()
                    Text("No Data Found!, Please search a country and add it your list.")
                        .font(.title.bold())
                        .padding(.horizontal)
                    Spacer()
                    
                } else {
                    List {
                        if !viewModel.searchText.isEmpty {
                            sectionView
                        }

                        if !viewModel.countries.isEmpty {
                            sectionView1
                        }
                    }
                    .listStyle(.plain)
                }
                
            }
            .navigationTitle("Countries")
            .navigationDestination(isPresented: $showDetails) {
                if let selected = selectedCountry {
                    CountryDetailView(country: selected)
                }
            }
        }
    }
}

extension CountryListview   {
    
    private var sectionView: some View {
        Section(header: Text("Search Results")) {
            ForEach(viewModel.searchResults) { country in
                Button(action: {
                    selectedCountry = country
                    showDetails = true
                }) {
                    CountryListContent(country: country, showAddButton: viewModel.countries.contains(where: { $0.id == country.id }), showDeleteButton: false, onTap: {
                        viewModel.addCountry(country)
                    })
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
    
    private var sectionView1: some View {
        Section(header: Text("Your Countries")) {
            ForEach(viewModel.countries) { country in
                Button(action: {
                    selectedCountry = country
                    showDetails = true
                }) {
                    CountryListContent(country: country, showAddButton: false, showDeleteButton: true, onTap: {
                        if let index = viewModel.countries.firstIndex(where: { $0.id == country.id }) {
                            viewModel.removeCountry(at: IndexSet(integer: index))
                        }
                    })
                    
                    
                    
                    //                    HStack {
                    //                        if let urlString = country.bestFlagURL,
                    //                           let url = URL(string: urlString) {
                    //                            AsyncImage(url: url)
                    //                                .frame(width: 30, height: 20)
                    //                                .cornerRadius(3)
                    //                        }
                    //                        Text(country.name.common)
                    //                        Spacer()
                    //                        Image(systemName: "trash")
                    //                            .foregroundColor(.red)
                    //                            .onTapGesture {
                    //                                if let index = viewModel.countries.firstIndex(where: { $0.id == country.id }) {
                    //                                    viewModel.removeCountry(at: IndexSet(integer: index))
                    //                                }
                    //                            }
                    //                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}
