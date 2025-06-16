//
//  CountryListViewModel.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.
//

import Foundation
import Combine

@MainActor
class CountryListViewModel: ObservableObject {
    @Published var countries: [Country] = []               // User-added countries
    @Published var searchText: String = ""
    @Published var searchResults: [Country] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private var cancellables = Set<AnyCancellable>()
    private let apiService: APIService

    init(apiService: APIService = APIManager.shared) {
        self.apiService = apiService
        setupSearchBinding()
    }

    private func setupSearchBinding() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self = self else { return }
                Task {
                    await self.fetchCountries()
                }
            }
            .store(in: &cancellables)
    }

    func fetchCountries() async {
        guard !isLoading else { return }
        guard !searchText.isEmpty else {
            searchResults = []
            return
        }
        isLoading = true
        errorMessage = nil
        do {
            let request = try CouontryListAPI.getCountries(searchName: searchText)
            let countryListResponse = try await apiService.execute(request)
            self.searchResults = countryListResponse
        } catch {
            self.errorMessage = error.localizedDescription
            self.searchResults = []
        }
        isLoading = false
    }

    func addCountry(_ country: Country) {
        guard !countries.contains(where: { $0.id == country.id }),
              countries.count < 5 else { return }
        countries.append(country)
    }

    func removeCountry(at indexSet: IndexSet) {
        countries.remove(atOffsets: indexSet)
    }
}
