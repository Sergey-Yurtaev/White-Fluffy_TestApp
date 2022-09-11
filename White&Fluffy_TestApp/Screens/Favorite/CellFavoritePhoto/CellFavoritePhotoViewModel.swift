//
//  CellFavoritePhotoViewModel.swift
//  White&Fluffy_TestApp
//
//  Created by  Sergey Yurtaev on 09.09.2022.
//

import Foundation

protocol CellFavoritePhotoViewModelProtocol {
    
    var photo: Photo { get }
    var nameAuthorLabel: String { get }
    
    init(photo: Photo)
}

class CellFavoritePhotoViewModel: CellFavoritePhotoViewModelProtocol {
    
    let photo: Photo
    
    var nameAuthorLabel: String {
        "Author: \(photo.user?.name ?? "no info")"
    }
    
    required init(photo: Photo) {
        self.photo = photo
    }
    
}
