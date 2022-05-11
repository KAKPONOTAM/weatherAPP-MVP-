import Foundation

struct WeeklyWeatherData: Decodable {
    let timezoneOffset: Int?
    let daily: [WeeklyWeatherTemperatureTypes]?
    let windSpeed: Double?
    let hourly: [HourlyWeatherDescription]?
    let current: Current?
    
    enum CodingKeys: String, CodingKey {
        case timezoneOffset = "timezone_offset"
        case daily
        case windSpeed = "wind_speed"
        case hourly
        case current
    }
}

struct Current: Decodable {
    let temp: Double
    let feelsLike: Double
    let windSpeed: Double
    
    enum CodingKeys: String, CodingKey {
        case feelsLike = "feels_like"
        case windSpeed = "wind_speed"
        case temp
    }
}

struct WeeklyWeatherTemperatureTypes: Decodable {
    let dt: Int
    let temp: Temperature
    let feelsLike: TemperatureFeelsLike
    let weather: [WeeklyWeatherDescriptionIcon]
    
    enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case feelsLike = "feels_like"
        case weather
    }
}

struct Temperature: Decodable {
    let min: Double
    let max: Double
    let day: Double
    
    enum CodingKeys: String, CodingKey {
        case min
        case max
        case day
    }
}

struct TemperatureFeelsLike: Decodable {
    let day: Double
    
    enum CodingKeys: String, CodingKey {
        case day
    }
}

struct WeeklyWeatherDescriptionIcon: Decodable {
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case icon
    }
}


struct HourlyWeatherDescription: Decodable {
    var dt: Int
    var temp: Double
    var weather: [HourlyWeatherImageDescription]
}

struct HourlyWeatherImageDescription: Decodable {
    var icon: String
}
