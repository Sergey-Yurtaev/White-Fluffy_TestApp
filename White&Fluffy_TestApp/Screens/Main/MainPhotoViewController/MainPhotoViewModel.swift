//
//  MainPhotoViewModel.swift
//  White&Fluffy_TestApp
//
//  Created by  Sergey Yurtaev on 07.09.2022.
//

import Foundation

protocol MainPhotoViewModelProtocol {
    
    var allPhotos: [Photo] { get }
    func numberOfRows() -> Int
    func fetchPhoto(searchTerm: String, completion: @escaping() -> Void)
    func cellViewModel(at indexPath: IndexPath) -> CellPhotoViewModelProtocol?
    func viewModelForSelectedRow(at indexPath: IndexPath) -> DetailViewModelProtocol?
}

final class MainPhotoViewModel: MainPhotoViewModelProtocol {

    var allPhotos: [Photo] = []
    
    func fetchPhoto(searchTerm: String, completion: @escaping () -> Void) { 
        NetworkManager.shared.getData(searchTerm: searchTerm) { [weak self] photos in
            self?.allPhotos = photos
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func numberOfRows() -> Int {
        allPhotos.count
    }
        
    func cellViewModel(at indexPath: IndexPath) -> CellPhotoViewModelProtocol? {
        let photo = allPhotos[indexPath.row]
        return CellPhotoViewModel(photo: photo)
    }
    
    func viewModelForSelectedRow(at indexPath: IndexPath) -> DetailViewModelProtocol? {
        let photo = allPhotos[indexPath.row]
        return DetailViewModel(photo: photo)
    }
}
