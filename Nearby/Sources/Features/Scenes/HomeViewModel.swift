////
////  HomeViewModel.swift
////  Nearby
////
////  Created by Mateus Henrique Coelho de Paulo on 17/11/24.
////
//
//import Foundation
//import Foundation
//import CoreLocation
//
//class HomeViewModel {
//    private let baseURL = "http://127.0.0.1:3333"
//    var categories: [Category] = []
//    var places: [Place] = []
//    var filteredPlaces: [Place] = [] // Atualiza conforme o filtro
//    
//    var didUpdateCategories: (() -> Void)?
//    var didUpdatePlaces: (() -> Void)?
//    
//    func fetchCategories() {
//        guard let url = URL(string: "\(baseURL)/categories") else { return }
//        
//        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//            if let error = error {
//                print("Error fetching categories: \(error)")
//                return
//            }
//            guard let data = data else { return }
//            do {
//                self?.categories = try JSONDecoder().decode([Category].self, from: data)
//                DispatchQueue.main.async {
//                    self?.didUpdateCategories?()
//                }
//            } catch {
//                print("Error decoding categories: \(error)")
//            }
//        }.resume()
//    }
//    
//    func fetchPlaces(for categoryID: String, userLocation: CLLocationCoordinate2D) {
//        guard let url = URL(string: "\(baseURL)/markets/category/\(categoryID)") else { return }
//        
//        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//            if let error = error {
//                print("Error fetching places: \(error)")
//                return
//            }
//            guard let data = data else { return }
//            do {
//                self?.places = try JSONDecoder().decode([Place].self, from: data)
//                DispatchQueue.main.async {
//                    self?.didUpdatePlaces?()
//                }
//            } catch {
//                print("Error decoding places: \(error)")
//            }
//        }.resume()
//    }
//}
//
//struct Category: Decodable {
//    let id: String
//    let name: String
//}
