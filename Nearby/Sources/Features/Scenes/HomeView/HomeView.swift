//
//  HomeView.swift
//  Nearby
//
//  Created by Mateus Henrique Coelho de Paulo on 12/11/24.
//

import Foundation
import MapKit

class HomeView: UIView {
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private let filterScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let filterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fill
        return stackView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.gray100
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let dragIndicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints
        view.layer.cornerRadius = 3
        view.backgroundColor = Colors.gray300
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Explore locais perto de você"
        label.font = Typography.textMD
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let placesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: PlaceTableViewCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var containerTopConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupButtons()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        addSubview(mapView)
        addSubview(filterScrollView)
        addSubview(containerView)
        
        filterScrollView.addSubview(filterStackView)
        
        containerView.addSubview(dragIndicatorView)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(placesTableView)
        
        setupConstraints()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        containerView.addGestureRecognizer(panGesture)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65),
            
            filterScrollView.topAnchor.constraint(equalTo: topAnchor, constant: 65),
            filterScrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            filterScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterScrollView.heightAnchor.constraint(equalToConstant: 36),
            
            filterStackView.topAnchor.constraint(equalTo: filterScrollView.topAnchor),
            filterStackView.leadingAnchor.constraint(equalTo: filterScrollView.leadingAnchor),
            filterStackView.trailingAnchor.constraint(equalTo: filterScrollView.trailingAnchor),
            filterStackView.bottomAnchor.constraint(equalTo: filterScrollView.bottomAnchor),
            filterStackView.heightAnchor.constraint(equalTo: filterScrollView.heightAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        containerTopConstraint = containerView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -16)
        containerTopConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            dragIndicatorView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            dragIndicatorView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            dragIndicatorView.widthAnchor.constraint(equalToConstant: 80),
            dragIndicatorView.heightAnchor.constraint(equalToConstant: 4),
            
            descriptionLabel.topAnchor.constraint(equalTo: dragIndicatorView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant:  24),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:  -24),
            
            placesTableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            placesTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            placesTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            placesTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    private func setupButtons() {
        let buttons = [
        createFilterButton(title: "Alimentação", iconName: "fork.knife"),
        createFilterButton(title: "Compras", iconName: "cart"),
        createFilterButton(title: "Hospedagem", iconName: "bed.double"),
        createFilterButton(title: "Saúde", iconName: "heart"),
        createFilterButton(title: "Educação", iconName: "book")
        ]
        
        buttons.forEach { button in
            filterStackView.addArrangedSubview(button)
        }
    }
    
    private func createFilterButton(title: String, iconName: String) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setImage(UIImage(systemName: iconName), for: .normal)
        button.tintColor = Colors.gray100
        button.layer.cornerRadius = 8
        button.backgroundColor = Colors.greenBase
        button.titleLabel?.font = Typography.textSM
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.heightAnchor.constraint(equalToConstant: 13).isActive = true
        button.imageView?.widthAnchor.constraint(equalToConstant: 11).isActive = true
        button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 8)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        return button
    }
    
    func configureTableViewDelegate(_ delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        placesTableView.delegate = delegate
        placesTableView.dataSource = dataSource
    }
    
    @objc
    private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        let velocity = gesture.velocity(in: self)
        
        switch gesture.state {
        case .changed:
            let newConstant = containerTopConstraint.constant + translation.y
            if newConstant <= 0 && newConstant >= frame.height * 0.5 {
                containerTopConstraint.constant = newConstant
                gesture.setTranslation(.zero, in: self)
            }
        case .ended:
            let halfScreeenHeight = -frame.height * 0.25
            let finalPosition: CGFloat
            
            if velocity.y > 0 {
                finalPosition = 0
            } else {
                finalPosition = halfScreeenHeight
            }
            
            UIView.animate(withDuration: 0.3, animations: {
                self.containerTopConstraint.constant = finalPosition
                self.layoutIfNeeded()
            })
        default:
            break
            
        }
    }
    
}
