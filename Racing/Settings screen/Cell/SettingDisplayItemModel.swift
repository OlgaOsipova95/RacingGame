//
//  SettingDisplayItemModel.swift
//  Racing
//
//  Created by Olga on 30.12.2023.
//

import Foundation

struct SettingsDisplayItemModel {
    let title: String
    let value: () -> String
    let allValues: [String]
    let didChanged: (Int) -> Void
}
