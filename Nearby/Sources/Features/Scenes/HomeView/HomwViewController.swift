//
//  HomwViewController.swift
//  Nearby
//
//  Created by Mateus Henrique Coelho de Paulo on 12/11/24.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    private var places: [Place] = [
        Place(imageName: "burger", title: "rocketBurger", description: "Na compra de um combo superRocket, leve outro combo de graça"),
        Place(imageName: "coffee", title: "RocketCoffee", description: "Na compra de qualquer lanche, ganhe um café grátis.")
    ]
    
    private let homeView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = homeView
        
        homeView.configureTableViewDelegate(self, dataSource: self)
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.identifier, for: indexPath) as? PlaceTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: places[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
