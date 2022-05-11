import Foundation
protocol CurrentWeatherPresenterDelegate: AnyObject {
    func configure(with currentWeatherData: CurrentWeatherInfo, index: Int)
}

protocol CurrentWeatherCellDelegate: AnyObject {
    func configuration(with currentWeatherData: CurrentWeatherInfo, index: Int)
}

class CurrentWeatherTableViewCellPresenter: CurrentWeatherPresenterDelegate {
    let cell: CurrentWeatherCellDelegate
    
    init(cell: CurrentWeatherCellDelegate) {
        self.cell = cell
    }
    
    func configure(with currentWeatherData: CurrentWeatherInfo, index: Int) {
        cell.configuration(with: currentWeatherData, index: index)
    }
}
