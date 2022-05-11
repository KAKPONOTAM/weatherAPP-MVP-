import Foundation
protocol LoadViewPresenterDelegate: AnyObject {
    var lon: Double? { get set }
    var lat: Double? { get set }
    var weeklyWeatherData: WeeklyWeatherData? { get set }
    var currentWeatherData: CurrentWeatherInfo? { get set }
    var ciyName: String? { get set }
    
    func getWeatherData()
}

protocol LoadViewDelegate: AnyObject {
    func success()
    func failure(error: Error)
}

class LoadViewPresenter: LoadViewPresenterDelegate {
    var weeklyWeatherData: WeeklyWeatherData?
    var currentWeatherData: CurrentWeatherInfo?
    var ciyName: String?
    let view: LoadViewDelegate
    var networkManager: NetworkManagerDelegate
   
    var lon: Double?
    var lat: Double?
    
    init(view: LoadViewDelegate, networkManager: NetworkManagerDelegate) {
        self.view = view
        self.networkManager = networkManager
    }
    
    func getWeatherData() {
        guard let lat = lat,
              let lon = lon else { return }
        networkManager.fetchCurrentWeatherData(lat: lat, lon: lon) { [weak self] currentWeatherData in
            self?.currentWeatherData = currentWeatherData
            guard let cityName = self?.currentWeatherData?.name else { return }
            self?.ciyName = cityName
            
            self?.networkManager.fetchWeeklyWeatherData(lat: lat, lon: lon) { [weak self] result in
                switch result {
                case .success(let weeklyWeatherData):
                    self?.weeklyWeatherData = weeklyWeatherData
                    self?.view.success()
                case .failure(let error):
                    self?.view.failure(error: error)
                }
            }
        }
    }
}
