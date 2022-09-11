//
//  CellPhotoViewModel.swift
//  White&Fluffy_TestApp
//
//  Created by  Sergey Yurtaev on 07.09.2022.
//

import Foundation

protocol CellPhotoViewModelProtocol {
    
    var photo: Photo { get }
    
    init(photo: Photo)
}

class CellPhotoViewModel: CellPhotoViewModelProtocol {
    
    let photo: Photo
    
    required init(photo: Photo) {
        self.photo = photo
    }
}
