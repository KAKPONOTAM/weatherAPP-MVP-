import Foundation

enum WeatherTableViewSections: Int, CaseIterable {
    case current
    case hourly
    case weekly
    case sunriseAndSunset
    
    static func getSectionsAmount() -> Int {
        return allCases.count
    }
    
    static func getRow(index: Int) -> Self {
        return allCases[index]
    }
}
