//
//  UserCellModel.swift
//  Racing
//
//  Created by Olga on 20.12.2023.
//

import Foundation
import UIKit

struct UserCellModel {
    var image: UIImage?
    var name: String?
    var onPickAvatar: () -> Void
    var didNameChanged: (String) -> Void
}
