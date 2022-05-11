import Foundation
import UIKit

typealias loadViewController = LoadViewDelegate & LoadViewController
typealias weatherViewController = WeatherViewDelegate & WeatherViewController
typealias cityListViewController = CityListViewDelegate & CityListViewController

protocol ModuleBuilderDelegate: AnyObject {
    static func createLoadModule() -> loadViewController
    static func createWeatherModule(weeklyWeatherData: WeeklyWeatherData, currentWeatherData: CurrentWeatherInfo) -> weatherViewController
    static func createCityListViewController() -> cityListViewController
}

class ModuleBuilder: ModuleBuilderDelegate {
    static func createLoadModule() -> loadViewController {
        let view = LoadViewController()
        let networkManager = NetworkManager()
        let presenter = LoadViewPresenter(view: view, networkManager: networkManager)
        view.presenter = presenter
        presenter.networkManager = networkManager
        
        return view
    }
    
    static func createWeatherModule(weeklyWeatherData: WeeklyWeatherData, currentWeatherData: CurrentWeatherInfo) -> weatherViewController {
        let view = WeatherViewController()
        let networkManager = NetworkManager()
        let presenter = WeatherViewPresenter(view: view, weeklyWeatherData: weeklyWeatherData, networkManager: networkManager)
        presenter.currentWeatherData = currentWeatherData
        view.presenter = presenter
        
        return view
    }
    
    static func createCityListViewController() -> cityListViewController {
        let view = CityListViewController()
        let jsonManager = JSONParseManager()
        let presenter = CityListPresenter(view: view, jsonManager: jsonManager)
        view.presenter = presenter
        
        return view
    }
}
