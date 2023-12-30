//
//  RecordsPresenter.swift
//  Racing
//
//  Created by Olga on 30.12.2023.
//

import Foundation

protocol RecordsPresenterProtocol {
    func countCells() -> Int
    func getDataCell(index: Int) -> RecordCellModel
}

final class RecordsPresenter: RecordsPresenterProtocol {
    let model = RecordsModel()
    
    func countCells() -> Int {
        model.getCellsCount()
    }
    func getDataCell(index: Int) -> RecordCellModel {
        RecordCellModel(data: model.getCellData(index: index)) 
    }
    deinit {
        print("deinit \(self)")
    }
}
