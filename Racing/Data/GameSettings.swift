//
//  GameSettings.swift
//  Racing
//
//  Created by Olga on 29.12.2023.
//

import Foundation

struct GameSettings: Codable {
    private static var key = "gameSettingsKey"
    var userName: String?
    var imageName: String?
    var carColor: ColorsCar
    var typeObstacles: TypeObstacles
    var level: Level
    var control: Control
    
    static func fromUD(userDefaults: UserDefaults) -> GameSettings {
        return userDefaults.get(GameSettings.self, forKey: key) ?? GameSettings(userName: "", imageName: nil, carColor: .red, typeObstacles: .tree, level: .easy, control: .swipe)
    }
    
    func setToUD(userDefaults: UserDefaults) {
        userDefaults.set(self, forKey: Self.key)
    }
    
    enum ColorsCar: String, Codable, CaseIterable {
        case red, green, blue
        func displayString() -> String {
            switch self {
            case .red:
                return "settings.carColor.red".localized()
            case .green:
                return "settings.carColor.green".localized()
            case .blue:
                return "settings.carColor.blue".localized()
            }
        }
    }
    
    enum TypeObstacles: String, Codable, CaseIterable {
        case tree, bush
        func displayString()  -> String {
            switch self {
            case .tree:
                return "settings.typeObstacle.tree".localized()
            case .bush:
                return "settings.typeObstacle.stone".localized()
            }
        }
    }
    enum Level: String, Codable, CaseIterable {
        case easy, medium, hard
        func displayString()  -> String {
            switch self {
            case .easy:
                return "settings.level.light".localized()
            case .medium:
                return "settings.level.medium".localized()
            case .hard:
                return "settings.level.hard".localized()
            }
        }
    }
    enum Control: String, Codable, CaseIterable {
        case swipe, tap, accelerometer
        func displayString() -> String {
            switch self {
            case .swipe:
                return "settings.control.swipe".localized()
            case .tap:
                return "settings.control.tap".localized()
            case .accelerometer:
                return "settings.control.accelerometer".localized()
            }
        }
    }
}
