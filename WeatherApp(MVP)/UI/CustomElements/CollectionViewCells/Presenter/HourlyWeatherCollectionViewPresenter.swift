import Foundation
protocol HourlyWeatherCollectionViewPresenterDelegate: AnyObject {
    func configure(with weeklyWeatherData: WeeklyWeatherData, indexPath: IndexPath)
}

protocol HourlyWeatherCollectionViewDelegate: AnyObject {
    func configure(with weeklyWeatherData: WeeklyWeatherData, indexPath: IndexPath)
}

class HourlyWeatherCollectionViewPresenter: HourlyWeatherCollectionViewPresenterDelegate {
    let cell: HourlyWeatherCollectionViewDelegate
    
    init(cell: HourlyWeatherCollectionViewDelegate) {
        self.cell = cell
    }
    
    func configure(with weeklyWeatherData: WeeklyWeatherData, indexPath: IndexPath) {
        cell.configure(with: weeklyWeatherData, indexPath: indexPath)
    }
}
