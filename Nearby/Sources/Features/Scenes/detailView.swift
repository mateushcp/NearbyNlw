import UIKit

class DetailsViewController: UIViewController {
    var place: Place?

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray100
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleLG
        label.textColor = .black
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.textSM
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private let infoTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleMD
        label.textColor = Colors.gray500
        label.text = "Informações"
        return label
    }()
    
    private let regulationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleMD
        label.textColor = Colors.gray500
        label.text = "Regulamento"
        return label
    }()
    
    private let couponTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleMD
        label.textColor = Colors.gray500
        label.text = "Utilize esse cupom"
        return label
    }()
    
    private let infoStackView = UIStackView()
    
    private let regulationLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.textSM
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private let couponStackView: UIStackView = {
        let iconImageView = UIImageView(image: UIImage(named: "ticket"))
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = Colors.greenBase
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true


        let stackView = UIStackView(arrangedSubviews: [iconImageView])
        stackView.axis = .horizontal
        stackView.backgroundColor = Colors.greenExtraLight
        stackView.layer.cornerRadius = 8
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    private let couponCodeLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleMD
        label.textColor = Colors.gray600
        label.textAlignment = .center
        return label
    }()
    
    private let qrCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ler QR Code", for: .normal)
        button.backgroundColor = Colors.greenBase
        button.titleLabel?.font = Typography.action
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray200
        return view
    }()
    
    private let divider2: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray200
        return view
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.greenBase
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        
        let arrowImage = UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysTemplate)
        let arrowImageView = UIImageView(image: arrowImage)
        arrowImageView.tintColor = Colors.gray100
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(arrowImageView)

        NSLayoutConstraint.activate([
            arrowImageView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            arrowImageView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 20),
            arrowImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configurePlaceData()
        setupBackButton()
        self.navigationController?.navigationBar.isHidden = true
    }

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(coverImageView)
        contentView.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(infoTitleLabel)
        containerView.addSubview(infoStackView)
        containerView.addSubview(divider)
        containerView.addSubview(regulationTitleLabel)
        containerView.addSubview(regulationLabel)
        containerView.addSubview(divider2)
        containerView.addSubview(couponTitleLabel)
        containerView.addSubview(couponStackView)
//        containerView.addSubview(couponCodeLabel)
        containerView.addSubview(qrCodeButton)
        
        couponStackView.addArrangedSubview(couponCodeLabel)
        infoStackView.axis = .vertical
        infoStackView.spacing = 8
        
        // Layout com Auto Layout
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        infoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        divider.translatesAutoresizingMaskIntoConstraints = false
        regulationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        regulationLabel.translatesAutoresizingMaskIntoConstraints = false
        divider2.translatesAutoresizingMaskIntoConstraints = false
        couponTitleLabel.translatesAutoresizingMaskIntoConstraints = false
//        couponCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        qrCodeButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            coverImageView.topAnchor.constraint(equalTo: view.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coverImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4),

            containerView.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: -20),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),

            infoTitleLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            infoTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),

            infoStackView.topAnchor.constraint(equalTo: infoTitleLabel.bottomAnchor, constant: 12),
            infoStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            infoStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),

            divider.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 16),
            divider.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            divider.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            divider.heightAnchor.constraint(equalToConstant: 1),

            regulationTitleLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 24),
            regulationTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),

            regulationLabel.topAnchor.constraint(equalTo: regulationTitleLabel.bottomAnchor, constant: 12),
            regulationLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            regulationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),

            divider2.topAnchor.constraint(equalTo: regulationLabel.bottomAnchor, constant: 16),
            divider2.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            divider2.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            divider2.heightAnchor.constraint(equalToConstant: 1),

            couponTitleLabel.topAnchor.constraint(equalTo: divider2.bottomAnchor, constant: 16),
            couponTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            
            couponStackView.topAnchor.constraint(equalTo: couponTitleLabel.bottomAnchor, constant: 12),
            couponStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            couponStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            couponStackView.heightAnchor.constraint(equalToConstant: 40),

//            couponCodeLabel.topAnchor.constraint(equalTo: couponTitleLabel.bottomAnchor, constant: 12),
//            couponCodeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
//            couponCodeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
//            couponCodeLabel.heightAnchor.constraint(equalToConstant: 40),

            qrCodeButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            qrCodeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            qrCodeButton.heightAnchor.constraint(equalToConstant: 44),
            qrCodeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -32)
        ])
    }
    
    private func setupBackButton() {
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    private func configurePlaceData() {
        guard let place = place else { return }
        titleLabel.text = place.name
        descriptionLabel.text = place.description
        
        // InfoStackView com ícones
        infoStackView.addArrangedSubview(createInfoRow(iconName: "ticket", text: "\(place.coupons) cupons disponíveis"))
        infoStackView.addArrangedSubview(createInfoRow(iconName: "mapIcon", text: place.address))
        infoStackView.addArrangedSubview(createInfoRow(iconName: "phone", text: place.phone))

        regulationLabel.text = """
        • Válido apenas para consumo no local
        
        • Disponível até 31/12/2024
        """
        couponCodeLabel.text = place.id

        if let url = URL(string: place.cover) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.coverImageView.image = image
                    }
                }
            }.resume()
        }
    }

    private func createInfoRow(iconName: String, text: String) -> UIStackView {
        let iconImageView = UIImageView(image: UIImage(named: iconName))
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = Colors.gray500
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true

        let label = UILabel()
        label.text = text
        label.font = Typography.textSM
        label.textColor = .darkGray

        let stackView = UIStackView(arrangedSubviews: [iconImageView, label])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }
}
