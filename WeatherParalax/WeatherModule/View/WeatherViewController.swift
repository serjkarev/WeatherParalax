//
//  WeatherViewController.swift
//  WeatherParalax
//
//  Created by skarev on 31.08.2022.
//

import UIKit

protocol WeatherViewProtocol: AnyObject {
    func succesMapDownload()
    func failure(title: String, description: String)
}

final class WeatherViewController: UIViewController {
    
    var presenter: WeatherViewPresenterProtocol?
    
    // MARK: - Constants
    struct Constants {
//        static fileprivate let headerHeight: CGFloat = UIScreen.main.bounds.height / 3
        static fileprivate let headerHeight: CGFloat = UIApplication.shared.windows[0].safeAreaLayoutGuide.layoutFrame.height / 3
    }

    // MARK: - Properties
    private var scrollView: UIScrollView!
    
    private var headerContainerView: UIView!
    private var headerImageView: UIImageView!
    
    private var containerView: UIView!
    private var mainStackView: UIStackView!
    private var currTempLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var labelsStackView: UIStackView!
    
    private var paramLabelsStackView: UIStackView!
    private var minTempLabel: UILabel!
    private var maxTempLabel: UILabel!
    private var airHumidityLabel: UILabel!
    private var windSpeedLabel: UILabel!
    
    private var valueLabelsStackView: UIStackView!
    private var minTempValueLabel: UILabel!
    private var maxTempValueLabel: UILabel!
    private var airHumidityValueLabel: UILabel!
    private var windSpeedValueLabel: UILabel!
    
    private var headerTopConstraint: NSLayoutConstraint!
    private var headerHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        createUIElements()
        addUIElements()
        arrangeConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        headerImageView.image = presenter?.cityImage
    }
}

// MARK: - UIScrollView delegate methods
extension WeatherViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0.0 {
            headerHeightConstraint?.constant = Constants.headerHeight - scrollView.contentOffset.y
        } else {
            let parallaxFactor: CGFloat = 0.25
            let offsetY = scrollView.contentOffset.y * parallaxFactor
            let minOffsetY: CGFloat = 8.0
            let availableOffset = min(offsetY, minOffsetY)
            let contentRectOffsetY = availableOffset / Constants.headerHeight
            headerTopConstraint?.constant = view.frame.origin.y
            headerHeightConstraint?.constant = Constants.headerHeight - scrollView.contentOffset.y
            headerImageView.layer.contentsRect = CGRect(x: 0, y: -contentRectOffsetY, width: 1, height: 1)
        }
    }
}

// MARK: - WeatherViewProtocol methods
extension WeatherViewController: WeatherViewProtocol {
    func succesMapDownload() {
        headerImageView.image = presenter?.cityImage
    }

    func failure(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Priavte methods
private extension WeatherViewController {
    func setupNavBar() {
        self.title = presenter?.cityName
    }
    
    func createUIElements() {
        createScrollView()
        createHeaderContainerView()
        createHeaderImageView()
        createcontainerView()
        createStacks()
        createLabels()
    }
    
    func createScrollView() {
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
    }

    func createHeaderContainerView() {
        headerContainerView = UIView()
        headerContainerView.clipsToBounds = true
        headerContainerView.translatesAutoresizingMaskIntoConstraints = false
    }

    func createHeaderImageView() {
        headerImageView = UIImageView()
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
    }

    func createcontainerView() {
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .green
    }

    func createStacks() {
        mainStackView = UIStackView()
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillProportionally
        mainStackView.spacing = 40
        
        labelsStackView = UIStackView()
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.axis = .horizontal
        labelsStackView.distribution = .fillProportionally
        labelsStackView.spacing = 2
        
        paramLabelsStackView = UIStackView()
        paramLabelsStackView.translatesAutoresizingMaskIntoConstraints = false
        paramLabelsStackView.axis = .vertical
        paramLabelsStackView.spacing = 20
        
        valueLabelsStackView = UIStackView()
        valueLabelsStackView.translatesAutoresizingMaskIntoConstraints = false
        valueLabelsStackView.axis = .vertical
        valueLabelsStackView.spacing = 20
    }
    
    func createLabels() {
        currTempLabel = UILabel()
        currTempLabel.translatesAutoresizingMaskIntoConstraints = false
        currTempLabel.textAlignment = .center
        currTempLabel.font = UIFont.boldSystemFont(ofSize: 60.0)
        currTempLabel.text = "32"
        
        descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        descriptionLabel.text = "description"
        
        minTempLabel = UILabel()
        minTempLabel.translatesAutoresizingMaskIntoConstraints = false
        minTempLabel.textAlignment = .left
        minTempLabel.text = "Min temperature:"
        
        maxTempLabel = UILabel()
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTempLabel.textAlignment = .left
        maxTempLabel.text = "Max temperature:"
        
        airHumidityLabel = UILabel()
        airHumidityLabel.translatesAutoresizingMaskIntoConstraints = false
        airHumidityLabel.textAlignment = .left
        airHumidityLabel.text = "Air humidity:"
        
        windSpeedLabel = UILabel()
        windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        windSpeedLabel.textAlignment = .left
        windSpeedLabel.text = "Wind speed:"
        
        minTempValueLabel = UILabel()
        minTempValueLabel.translatesAutoresizingMaskIntoConstraints = false
        minTempValueLabel.textAlignment = .right
        
        maxTempValueLabel = UILabel()
        maxTempValueLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTempValueLabel.textAlignment = .right
        
        airHumidityValueLabel = UILabel()
        airHumidityValueLabel.translatesAutoresizingMaskIntoConstraints = false
        airHumidityValueLabel.textAlignment = .right
        
        windSpeedValueLabel = UILabel()
        windSpeedValueLabel.translatesAutoresizingMaskIntoConstraints = false
        windSpeedValueLabel.textAlignment = .right
    }
    
    func addUIElements() {
        view.addSubview(scrollView)
        scrollView.addSubview(headerContainerView)
        headerContainerView.addSubview(headerImageView)
        
        scrollView.addSubview(containerView)
        containerView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(currTempLabel)
        mainStackView.addArrangedSubview(descriptionLabel)
        mainStackView.addArrangedSubview(labelsStackView)
        labelsStackView.addArrangedSubview(paramLabelsStackView)
        labelsStackView.addArrangedSubview(valueLabelsStackView)

        paramLabelsStackView.addArrangedSubview(minTempLabel)
        paramLabelsStackView.addArrangedSubview(maxTempLabel)
        paramLabelsStackView.addArrangedSubview(airHumidityLabel)
        paramLabelsStackView.addArrangedSubview(windSpeedLabel)

        valueLabelsStackView.addArrangedSubview(minTempValueLabel)
        valueLabelsStackView.addArrangedSubview(maxTempValueLabel)
        valueLabelsStackView.addArrangedSubview(airHumidityValueLabel)
        valueLabelsStackView.addArrangedSubview(windSpeedValueLabel)
    }
    
    func arrangeConstraints() {
        let scrollViewConstraints: [NSLayoutConstraint] = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(scrollViewConstraints)

        headerTopConstraint = headerContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        headerHeightConstraint = headerContainerView.heightAnchor.constraint(equalToConstant: Constants.headerHeight)
        let headerContainerViewConstraints: [NSLayoutConstraint] = [
            headerTopConstraint,
            headerContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            headerHeightConstraint
        ]
        NSLayoutConstraint.activate(headerContainerViewConstraints)

        let headerImageViewConstraints: [NSLayoutConstraint] = [
            headerImageView.topAnchor.constraint(equalTo: headerContainerView.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(headerImageViewConstraints)

        let containerViewConstraints: [NSLayoutConstraint] = [
            containerView.topAnchor.constraint(equalTo: headerContainerView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(containerViewConstraints)
        
        let mainStackViewConstraints: [NSLayoutConstraint] = [
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(mainStackViewConstraints)
    }
}
