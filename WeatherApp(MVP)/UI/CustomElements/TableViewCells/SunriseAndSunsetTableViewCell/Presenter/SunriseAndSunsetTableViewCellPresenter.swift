import Foundation
import CoreText
protocol SunriseAndSunsetPresenterDelegate: AnyObject {
    func configure(with currentWeatherData: CurrentWeatherInfo)
}

protocol SunriseAndSunsetCellDelegate: AnyObject {
    func configure(with currentWeatherData: CurrentWeatherInfo)
}

class SunriseAndSunsetTableViewCellPresenter: SunriseAndSunsetPresenterDelegate {
    let cell: SunriseAndSunsetCellDelegate
    
    init(cell: SunriseAndSunsetCellDelegate) {
        self.cell = cell
    }
    
    func configure(with currentWeatherData: CurrentWeatherInfo) {
        cell.configure(with: currentWeatherData)
    }
}
