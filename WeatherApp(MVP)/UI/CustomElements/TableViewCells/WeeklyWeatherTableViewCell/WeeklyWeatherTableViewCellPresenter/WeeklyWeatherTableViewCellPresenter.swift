import Foundation
protocol WeeklyWeatherTableViewPresenterDelegate: AnyObject {
    func configure(with weeklyWeatherData: WeeklyWeatherData, index: Int)
}

protocol WeeklyWeatherTableViewCellDelegate: AnyObject {
    func configure(with weeklyWeatherData: WeeklyWeatherData, index: Int)
}

class WeeklyWeatherTableViewCellPresenter: WeeklyWeatherTableViewPresenterDelegate {
    let cell: WeeklyWeatherTableViewCellDelegate
    
    init(cell: WeeklyWeatherTableViewCellDelegate) {
        self.cell = cell
    }
    
    func configure(with weeklyWeatherData: WeeklyWeatherData, index: Int) {
        cell.configure(with: weeklyWeatherData, index: index)
    }
}
