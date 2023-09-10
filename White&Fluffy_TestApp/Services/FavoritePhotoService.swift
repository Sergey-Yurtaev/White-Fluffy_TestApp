//
//  FavoritePhotoService.swift
//  White&Fluffy_TestApp
//
//  Created by  Sergey Yurtaev on 09.09.2022.
//

import Foundation
import CoreData

protocol FavoritePhotoServiceProtocol {
    @discardableResult
    func addFavoritePhoto (parameters: [String: String]) -> FavoritePhoto
    func deleteFavoritePhoto(favoritePhoto: FavoritePhoto)
    func getFavoritePhotos() -> [FavoritePhoto]?
    func exportPhoto(result: FavoritePhoto) -> Photo
}

final class FavoritePhotoService: FavoritePhotoServiceProtocol {
    
    // MARK: Properties
    private let managedObjectContext: NSManagedObjectContext
    private let dataStoreManager: DataStoreManager
    
    // MARK: - Initializers
    public init(managedObjectContext: NSManagedObjectContext, dataStoreManager: DataStoreManager) { 
        self.managedObjectContext = managedObjectContext
        self.dataStoreManager = dataStoreManager
    }
    
    // MARK: - Public methods
    @discardableResult
    public func addFavoritePhoto(parameters: [String: String]) -> FavoritePhoto {
        let favoritePhoto = FavoritePhoto(context: managedObjectContext)
        
        favoritePhoto.urlImage = parameters["urlImage"]
        favoritePhoto.authorName = parameters["authorName"]
        favoritePhoto.createdDate = parameters["dateCreate"]
        favoritePhoto.downloads = parameters["downloads"]
        favoritePhoto.idFavoritePhoto = parameters["idPhoto"]
        favoritePhoto.locationName = parameters["location"]
        favoritePhoto.locationCity = parameters["locationCity"]
        favoritePhoto.locationCountry = parameters["locationCountry"]
        dataStoreManager.saveContext(managedObjectContext)
        return favoritePhoto
    }
    
    public func deleteFavoritePhoto(favoritePhoto: FavoritePhoto) {
        managedObjectContext.delete(favoritePhoto)
        dataStoreManager.saveContext(managedObjectContext)
    }
    
    public func getFavoritePhotos() -> [FavoritePhoto]? {
        let favoritePhotoFetch: NSFetchRequest<FavoritePhoto> = FavoritePhoto.fetchRequest()
        do {
            let rates = try managedObjectContext.fetch(favoritePhotoFetch)
            return rates
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
    }
    
    //manual model conversion(hardcore version)
    public func exportPhoto(result: FavoritePhoto) -> Photo {
        
        let location = Location(name: result.locationName, city: result.locationCity, country: result.locationCountry)
        let urls = Urls(full: "", regular: "", small: result.urlImage)
        let user = User(name: result.authorName)
        let photo = Photo(idPhoto: result.idFavoritePhoto,
                          createdAt: result.createdDate,
                          urls: urls,
                          user: user,
                          location: location,
                          downloads: Int(result.downloads ?? "0"))
        return photo
    }
}
