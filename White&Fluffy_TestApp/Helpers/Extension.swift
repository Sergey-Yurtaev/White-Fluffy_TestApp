//
//  UIButton + Extension.swift
//  White&Fluffy_TestApp
//
//  Created by  Sergey Yurtaev on 09.09.2022.
//

import UIKit
extension UIButton {
    public func heartButtonEmpty() {
        let configuration = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .large)
        let image = UIImage(systemName: "suit.heart", withConfiguration: configuration)?.withTintColor(.red, renderingMode: .alwaysOriginal)
        self.setImage(image, for: .normal)
    }

    public func heartButtonFill() {
        let configuration = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .large)
        let image = UIImage(systemName: "suit.heart.fill", withConfiguration: configuration)?.withTintColor(.red, renderingMode: .alwaysOriginal)
        self.setImage(image, for: .normal)
    }
}

extension Formatter {

    static let date: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
}

extension String {
    public func createDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if self.isEmpty {
            return Formatter.date.string(from: Date())

        } else {
            return Formatter.date.string(from: dateFormatter.date(from: self) ?? Date())
        }
    }
}

