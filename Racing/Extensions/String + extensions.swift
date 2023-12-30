//
//  String + extensions.swift
//  Racing
//
//  Created by Olga on 29.12.2023.
//

import Foundation

extension String {
    func localized() -> String {
        NSLocalizedString(self, comment: "")
    }
}
