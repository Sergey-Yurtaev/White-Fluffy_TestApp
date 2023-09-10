//
//  LikeViewModel.swift
//  White&Fluffy_TestApp
//
//  Created by  Sergey Yurtaev on 09.09.2022.
//

import Foundation

protocol FavoriteViewModelProtocol: AnyObject {

    func numberOfRows() -> Int
    var favoritePhotoService: FavoritePhotoServiceProtocol{ get }
    func getPictures() -> [FavoritePhoto]?
    func cellViewModel(at indexPath: IndexPath) -> CellFavoritePhotoViewModelProtocol?
    func viewModelForSelectedRow(at indexPath: IndexPath) -> DetailViewModelProtocol?
}

final class FavoriteViewModel: FavoriteViewModelProtocol {
    
    private let dataStoreManager = DataStoreManager()
    
    var favoritePhotoService: FavoritePhotoServiceProtocol {
        FavoritePhotoService(managedObjectContext: dataStoreManager.mainContext, dataStoreManager: dataStoreManager)
    }
    
    func numberOfRows() -> Int {
        getPictures()?.count ?? 0
    }
    
    func getPictures() -> [FavoritePhoto]? {
        favoritePhotoService.getFavoritePhotos()
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CellFavoritePhotoViewModelProtocol? {
        guard let photoCoreData = getPictures()?[indexPath.row] else { return nil }
        let photo = favoritePhotoService.exportPhoto(result: photoCoreData)
        return CellFavoritePhotoViewModel(photo: photo)
    }
    func viewModelForSelectedRow(at indexPath: IndexPath) -> DetailViewModelProtocol? {
        guard let photoCoreData = getPictures()?[indexPath.row] else { return nil }
        let photo = favoritePhotoService.exportPhoto(result: photoCoreData)
        return DetailViewModel(photo: photo)
    }
}
