import Foundation
protocol WeatherViewPresenterDelegate: AnyObject {
    func presentCityList()
    var weeklyWeatherData: WeeklyWeatherData? { get set }
    var currentWeatherData: CurrentWeatherInfo? { get set }
    var networkManager: NetworkManagerDelegate? { get set }
}

protocol WeatherViewDelegate: AnyObject {
    func presentCityButtonTapped()
}

class WeatherViewPresenter: WeatherViewPresenterDelegate {
    let view: WeatherViewDelegate
    var currentWeatherData: CurrentWeatherInfo?
    var weeklyWeatherData: WeeklyWeatherData?
    var networkManager: NetworkManagerDelegate?
    
    init(view: WeatherViewDelegate, weeklyWeatherData: WeeklyWeatherData, networkManager: NetworkManagerDelegate) {
        self.networkManager = networkManager
        self.view = view
        self.weeklyWeatherData = weeklyWeatherData
    }
    
    func presentCityList() {
        view.presentCityButtonTapped()
    }
}
