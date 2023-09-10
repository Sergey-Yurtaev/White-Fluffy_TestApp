//
//  DetailViewModel.swift
//  White&Fluffy_TestApp
//
//  Created by  Sergey Yurtaev on 08.09.2022.
//

import Foundation

protocol DetailViewModelProtocol {
    var favoritePhotoService: FavoritePhotoServiceProtocol{ get }
    var photo: Photo { get }
    var nameAuthorLabel: String { get }
    var dateCreateLabel: String { get }
    var locationLabel: String { get }
    var downloadsCountLabel: String { get }
    init(photo: Photo)
    
    func photoIsFavorite() -> Bool
    func deleteFavoritePhoto()
    func addToFavoritePhoto()
}

final class DetailViewModel: DetailViewModelProtocol {
    
    private let dataStoreManager = DataStoreManager()
    var favoritePhotoService: FavoritePhotoServiceProtocol {
        FavoritePhotoService(managedObjectContext: dataStoreManager.mainContext, dataStoreManager: dataStoreManager)
    }
    
    var idPhoto: String {
        photo.idPhoto ?? ""
    }
    
    let photo: Photo
    
    var nameAuthorLabel: String {
        "Author: \(photo.user?.name ?? "no information")"
    }
    
    var urlImage: String {
        photo.urls?.small ?? ""
    }
    
    var dateCreateLabel: String {
        return photo.createdAt ?? ""
    }
    
    var locationLabel: String {
        if let country = photo.location?.country, let city = photo.location?.city {
            return "Location: \(country), \(city)"
        } else if let country = photo.location?.country {
            return "Location: \(country)"
        } else if let nameLocation = photo.location?.name {
            return "Location: \(nameLocation)"
        }
        return "Location: 🌏"
    }
    
    var downloadsCountLabel: String {
        "Downloads: \(photo.downloads ?? 0)"
    }
    
    required init(photo: Photo) {
        self.photo = photo
    }
    
    func photoIsFavorite() -> Bool {
        if let favoritePhotos = favoritePhotoService.getFavoritePhotos() {
            return favoritePhotos.map { $0.idFavoritePhoto == idPhoto }.contains(true)
        }
        return false
    }
    
    func addToFavoritePhoto() {
        var parameters = [String: String]()
        parameters["idPhoto"] = idPhoto
        parameters["authorName"] = photo.user?.name
        parameters["dateCreate"] = dateCreateLabel
        parameters["location"] = photo.location?.name
        parameters["locationCountry"] = photo.location?.country
        parameters["locationCity"] = photo.location?.city
        parameters["downloads"] = "\(photo.downloads ?? 0)"
        parameters["urlImage"] = urlImage
        favoritePhotoService.addFavoritePhoto(parameters: parameters)
    }
    
    func deleteFavoritePhoto() {
        if let favoritePhotos = favoritePhotoService.getFavoritePhotos() {
            favoritePhotos.forEach { (photo) in
                if photo.idFavoritePhoto == idPhoto {
                    favoritePhotoService.deleteFavoritePhoto(favoritePhoto: photo)
                }
            }
        }
    }
    
    deinit {
        print("DetailViewModel has been dealocated")
    }
}
