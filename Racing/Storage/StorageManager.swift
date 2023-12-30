//
//  StorageManager.swift
//  Racing
//
//  Created by Olga on 29.12.2023.
//

import Foundation
import UIKit

final class StorageManager {
    
    func saveImage(_ image: UIImage) throws -> String? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let name = UUID().uuidString
        let fileURL = directory.appendingPathComponent(name)
        guard let data = image.pngData() else { return nil }
        try data.write(to: fileURL)
        return name
    }
    
    func loadImage(_ imageID: String) -> UIImage? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let imageURL = directory.appendingPathComponent(imageID).path
        return UIImage(contentsOfFile: imageURL)
    }
    
}
