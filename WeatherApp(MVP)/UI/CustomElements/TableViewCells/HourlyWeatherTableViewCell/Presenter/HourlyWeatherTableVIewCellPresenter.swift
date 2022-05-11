import Foundation
protocol HourlyWeatherTableViewPresenterDelegate: AnyObject {
    var weeklyWeatherData: WeeklyWeatherData? { get set }
}

protocol HourlyWeatherTableViewCellDelegate: AnyObject {
    
}

class HourlyWeatherTableViewCellPresenter: HourlyWeatherTableViewPresenterDelegate {
    var weeklyWeatherData: WeeklyWeatherData? 
    let cell: HourlyWeatherTableViewCellDelegate
    
    init(cell: HourlyWeatherTableViewCellDelegate) {
        self.cell = cell
    }
}
