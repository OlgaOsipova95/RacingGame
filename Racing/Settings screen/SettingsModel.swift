//
//  SettingsModel.swift
//  Racing
//
//  Created by Olga on 25.12.2023.
//

import Foundation

class SettingsModel {
    private var gameSettings: GameSettings
    private var items: [SettingsDisplayItemModel] = []
    var userAvatarName: String? {
        get {
            gameSettings.imageName
        }
        set {
            gameSettings.imageName = newValue
            gameSettings.setToUD(userDefaults: UserDefaults.standard)
        }
    }
    var userName: String? {
        get {
            gameSettings.userName
        }
        set {
            gameSettings.userName = newValue
            gameSettings.setToUD(userDefaults: UserDefaults.standard)
        }
    }
    var carColor: GameSettings.ColorsCar {
        get {
            gameSettings.carColor
        }
        set {
            gameSettings.carColor = newValue
            gameSettings.setToUD(userDefaults: UserDefaults.standard)
        }
    }
    var typeObstacle: GameSettings.TypeObstacles {
        get {
            gameSettings.typeObstacles
        }
        set {
            gameSettings.typeObstacles = newValue
            gameSettings.setToUD(userDefaults: UserDefaults.standard)
        }
    }
    var level: GameSettings.Level {
        get {
            gameSettings.level
        }
        set {
            gameSettings.level = newValue
            gameSettings.setToUD(userDefaults: UserDefaults.standard)
        }
    }
    var control: GameSettings.Control {
        get {
            gameSettings.control
        }
        set {
            gameSettings.control = newValue
            gameSettings.setToUD(userDefaults: UserDefaults.standard)
        }
    }
    
    init(){
        gameSettings = GameSettings.fromUD(userDefaults: UserDefaults.standard)
        buildData()
    }
    
    private func buildData() {
        items.append(SettingsDisplayItemModel(title: "settingsScreen.carColor".localized(), value: {
            self.carColor.displayString()
        }, allValues: GameSettings.ColorsCar.allCases.map({ $0.displayString() }), didChanged: { index in
            let allCases = GameSettings.ColorsCar.allCases
            self.carColor = allCases[index]
        }))
        items.append(SettingsDisplayItemModel(title: "settingsScreen.typeObstacle".localized(), value: {
            self.typeObstacle.displayString()
        }, allValues: GameSettings.TypeObstacles.allCases.map({ $0.displayString() }), didChanged: { index in
            let allCases = GameSettings.TypeObstacles.allCases
            self.typeObstacle = allCases[index]
        }))
        items.append(SettingsDisplayItemModel(title: "settingsScreen.level".localized(), value: {
            self.level.displayString()
        }, allValues: GameSettings.Level.allCases.map({ $0.displayString() }), didChanged: { index in
            let allCases = GameSettings.Level.allCases
            self.level = allCases[index]
        }))
        items.append(SettingsDisplayItemModel(title: "settingsScreen.typeControl".localized(), value: {
            self.control.displayString()
        }, allValues: GameSettings.Control.allCases.map({ $0.displayString() }), didChanged: { index in
            let allCases = GameSettings.Control.allCases
            self.control = allCases[index]
        }))
    }
    func getItem(index: Int) -> SettingsDisplayItemModel {
        items[index]
    }
    func getItemsCount() -> Int {
        items.count
    }
}
