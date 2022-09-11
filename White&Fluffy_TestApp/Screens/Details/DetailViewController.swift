//
//  DetailViewController.swift
//  White&Fluffy_TestApp
//
//  Created by  Sergey Yurtaev on 08.09.2022.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    //MARK: Private properties
    var viewModel: DetailViewModelProtocol! {
        didSet {
            nameAuthorLabel.text = viewModel.nameAuthorLabel
            DispatchQueue.main.async {
                self.setup(for: self.viewModel.photo)
            }
        }
    }
    
    private lazy var imagePhoto: UIImageView = {
        let imagePhoto = UIImageView()
        imagePhoto.contentMode = .scaleAspectFit
        imagePhoto.translatesAutoresizingMaskIntoConstraints = false
        imagePhoto.layer.cornerRadius = 15
        return imagePhoto
    }()
    
    private lazy var nameAuthorLabel: UILabel = {
        let nameAuthorLabel = UILabel()
        nameAuthorLabel.textAlignment = .left
        nameAuthorLabel.textColor = .blueCustom
        nameAuthorLabel.font = UIFont(name: customFont.markProMedium.rawValue, size: 20)
        nameAuthorLabel.translatesAutoresizingMaskIntoConstraints = false
        nameAuthorLabel.adjustsFontSizeToFitWidth = true
        return nameAuthorLabel
    }()
    
    private lazy var dateCreateLabel: UILabel = {
        let dateCreateLabel = UILabel()
        dateCreateLabel.textColor = .blueCustom
        dateCreateLabel.textAlignment = .left
        dateCreateLabel.font = UIFont(name: customFont.markProRegular.rawValue, size: 16)
        dateCreateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateCreateLabel
    }()
    
    private lazy var downloadsCountLabel: UILabel = {
        let downloadsCountLabel = UILabel()
        downloadsCountLabel.textColor = .blueCustom
        downloadsCountLabel.textAlignment = .left
        downloadsCountLabel.font = UIFont(name: customFont.markProRegular.rawValue, size: 16)
        downloadsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        return downloadsCountLabel
    }()
    
    private lazy var locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.textColor = .blueCustom
        locationLabel.textAlignment = .left
        locationLabel.numberOfLines = 0
        locationLabel.font = UIFont(name: customFont.markProRegular.rawValue, size: 16)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.adjustsFontSizeToFitWidth = true
        return locationLabel
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Selector methods
    @objc func tapButton() {
        if viewModel.photoIsFavorite() {
            callAlert(message: "Remove like?") { [favoriteButton, viewModel] in
                favoriteButton.heartButtonEmpty()
                viewModel?.deleteFavoritePhoto()
            }
        } else {
            callAlert(message: "Give a like?") { [favoriteButton, viewModel] in
                favoriteButton.heartButtonFill()
                viewModel?.addToFavoritePhoto()
            }
        }
    }
    
    // MARK: - Override methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteCustom
        setupSubviews()
        setConstraints()
        setupUI()
    }
    
    // MARK: - Private methods
    private func setup(for photo: Photo) {
        imagePhoto.kf.indicatorType = .activity
        imagePhoto.kf.setImage(with: URL(string: photo.urls?.small ?? ""))
    }
    
    private func setButton() {
        if viewModel.photoIsFavorite() {
            favoriteButton.heartButtonFill()
        } else {
            favoriteButton.heartButtonEmpty()
        }
    }
    
    private func setupUI() {
        nameAuthorLabel.text = viewModel.nameAuthorLabel
        dateCreateLabel.text = "Date of creation: " + (viewModel.dateCreateLabel.createDate() ?? "")
        downloadsCountLabel.text = viewModel.downloadsCountLabel
        locationLabel.text = viewModel.locationLabel
    }
    
    private func setupSubviews() {
        view.addSubview(imagePhoto)
        view.addSubview(nameAuthorLabel)
        view.addSubview(dateCreateLabel)
        view.addSubview(downloadsCountLabel)
        view.addSubview(locationLabel)
        view.addSubview(favoriteButton)
    }
    
    private func setConstraints() {
        let saveAreaView = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            imagePhoto.topAnchor.constraint(equalTo: saveAreaView.topAnchor, constant: 10),
            imagePhoto.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            imagePhoto.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8),
            imagePhoto.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2),
            
            nameAuthorLabel.heightAnchor.constraint(equalToConstant: 50),
            nameAuthorLabel.topAnchor.constraint(equalTo: self.imagePhoto.bottomAnchor),
            nameAuthorLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -16),
            nameAuthorLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            dateCreateLabel.heightAnchor.constraint(equalToConstant: 30),
            dateCreateLabel.topAnchor.constraint(equalTo: self.nameAuthorLabel.bottomAnchor),
            dateCreateLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -16),
            dateCreateLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            downloadsCountLabel.heightAnchor.constraint(equalToConstant: 30),
            downloadsCountLabel.topAnchor.constraint(equalTo: self.dateCreateLabel.bottomAnchor),
            downloadsCountLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -16),
            downloadsCountLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            locationLabel.heightAnchor.constraint(equalToConstant: 30),
            locationLabel.topAnchor.constraint(equalTo: self.downloadsCountLabel.bottomAnchor),
            locationLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -16),
            locationLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            favoriteButton.widthAnchor.constraint(equalToConstant: 50),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50),
            favoriteButton.centerYAnchor.constraint(equalTo: self.dateCreateLabel.centerYAnchor),
            favoriteButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
        ])
    }
    
    deinit {
        print("DetailViewController has been dealocated")
    }
}
    // MARK: - AlertController
extension DetailViewController {
    private func callAlert(message: String, complition: @escaping () -> Void) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let add = UIAlertAction(title: "Yes", style: .default) {_ in
            complition()
        }
    
        let cancel = UIAlertAction(title: "No", style: .cancel) {_ in }
        alertController.addAction(add)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
}
