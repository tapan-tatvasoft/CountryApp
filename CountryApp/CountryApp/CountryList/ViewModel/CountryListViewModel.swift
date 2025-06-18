//
//  CountryListViewModel.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.
//

import SwiftUI
import SwiftData
import Combine

@MainActor
final class CountryListViewModel: ObservableObject {
    private let apiService: APIService
    private var cancellables = Set<AnyCancellable>()

    @Published var countries: [Country] = []
    @Published var searchResults: [Country] = []
    @Published var searchText: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    var locationCountryCode: String?
    private var modelContext: ModelContext?

    init(apiService: APIService = APIManager.shared, locationManager: LocationProviding) {
        self.apiService = apiService

        // Location integration
        locationManager.currentCountryCodePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] code in
                guard let self, let code else { return }
                self.locationCountryCode = code
                Task {
                    await self.selectInitialCountry(with: code, countryName: locationManager.countryName)
                }
            }
            .store(in: &cancellables)

        setupSearchBinding()
    }

    func setContext(_ context: ModelContext) {
        self.modelContext = context
        loadStoredCountries()
    }

    private func setupSearchBinding() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self else { return }
                Task {
                    await self.fetchCountries()
                }
            }
            .store(in: &cancellables)
    }

    // API Call
    func fetchCountries(countryName: String? = nil) async {
        guard !isLoading else { return }
        guard !(countryName ?? searchText).isEmpty else {
            self.searchResults = []
            return
        }

        self.isLoading = true
        self.errorMessage = nil

        do {
            let request = try CouontryListAPI.getCountries(searchName: countryName ?? searchText)
            let countryListResponse = try await apiService.execute(request)
            self.searchResults = countryListResponse
        } catch {
            self.errorMessage = error.localizedDescription
            self.searchResults = []
        }

        self.isLoading = false
    }

    func selectInitialCountry(with code: String, countryName: String?) async {
        // If already in saved countries, no need to fetch
        if countries.contains(where: { $0.countryCode == code }) {
            return
        }
        
        await fetchCountries(countryName: countryName)
        
        if let match = searchResults.first(where: { $0.countryCode == code || $0.name.common == countryName }) {
            addCountry(match)
        }
        
    }

    func addCountry(_ country: Country) {
        guard let context = modelContext else { return }
        let entity = CDCountry(model: country)
        context.insert(entity)

        do {
            try context.save()
            loadStoredCountries()
        } catch {
            print("Failed to save country: \(error.localizedDescription)")
        }
    }

    func removeCountry(at offsets: IndexSet) {
        guard let context = modelContext else { return }

        for index in offsets {
            let country = countries[index]
            let fetch = FetchDescriptor<CDCountry>(predicate: #Predicate { $0.id == country.id })

            if let toDelete = try? context.fetch(fetch).first {
                context.delete(toDelete)
            }
        }

        do {
            try context.save()
            loadStoredCountries()
        } catch {
            print("Failed to remove country: \(error.localizedDescription)")
        }
    }

    func loadStoredCountries() {
        guard let context = modelContext else { return }

        let fetch = FetchDescriptor<CDCountry>()
        if let stored = try? context.fetch(fetch) {
            self.countries = stored.map { $0.toModel() }
        }
    }
}
