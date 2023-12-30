//
//  RecordCellModel.swift
//  Racing
//
//  Created by Olga on 16.12.2023.
//

import Foundation
import UIKit

struct RecordCellModel {
    static var dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter
    }()
    private let data: Score
    var name: String {
        data.gameSettings.userName ?? ""
    }
    var score: String {
        String(data.score)
    }
    var date: String {
        Self.dateFormatter.string(from: data.date)
    }
    var image: String? {
        data.gameSettings.imageName
    }
    
    init(data: Score) {
        self.data = data
    }
}
