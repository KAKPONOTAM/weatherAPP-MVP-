import Foundation

class CurrentWeatherInfo: Decodable {
    var weather: [Weather]?
    var main: Main?
    var wind: Wind?
    var name: String?
    var sys: SunriseAndSunsetTime?
    var coord: CurrentWeatherCoordinates?
}

class Weather: Decodable {
    var description: String?
    var icon: String?
}


class Main: Decodable {
    var temp: Double?
    var temp_max: Double?
    var temp_min: Double?
    var feels_like: Double?
}

class Wind: Decodable {
    var speed: Double?
}

class SunriseAndSunsetTime: Decodable {
    var sunrise: Int?
    var sunset: Int?
}

class CurrentWeatherCoordinates: Decodable {
    var lon: Double?
    var lat: Double?
}
