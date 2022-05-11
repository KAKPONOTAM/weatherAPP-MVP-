protocol NetworkManagerDelegate: AnyObject {
    func fetchWeeklyWeatherData(lat: Double, lon: Double, completion: @escaping (Result<WeeklyWeatherData, Error>) -> ())
    func fetchCurrentWeatherData(lat: Double, lon: Double, completion: @escaping (CurrentWeatherInfo) -> ())
    func fetchDataForSelectedCityFromCityList(cityName: String, completion: @escaping (CurrentWeatherInfo?) -> ())
}

import Foundation

class NetworkManager: NetworkManagerDelegate {
    func fetchDataForSelectedCityFromCityList(cityName: String, completion: @escaping (CurrentWeatherInfo?) -> ()) {
        let dataString = "https://api.openweathermap.org/data/2.5/weather?lat=55.7522&lon=37.6156&q=\(cityName)&units=metric&appid=affb0db14f9a58a6476f7e151f373f8a".encodeUrl
        guard let url = URL(string: dataString) else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil,
               let data = data {
                do {
                    let currentWeatherData = try JSONDecoder().decode(CurrentWeatherInfo.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(currentWeatherData)
                    }
                    
                } catch {
                    
                    print(error.localizedDescription)
                }
            }
        }
        
        task.resume()
    }
    
    func fetchCurrentWeatherData(lat: Double, lon: Double, completion: @escaping (CurrentWeatherInfo) -> ()) {
        let dataString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric&appid=9f9bd273673c133c5d046f2157e4885f"
        guard let url = URL(string: dataString) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil,
               let data = data {
                do {
                    let weatherData = try JSONDecoder().decode(CurrentWeatherInfo.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(weatherData)
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        task.resume()
    }
    
    func fetchWeeklyWeatherData(lat: Double, lon: Double, completion: @escaping (Result<WeeklyWeatherData, Error>) -> ()) {
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=9f9bd273673c133c5d046f2157e4885f"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if error == nil,
               let data = data {
                do {
                    let weeklyWeatherData = try JSONDecoder().decode(WeeklyWeatherData.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(weeklyWeatherData))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
        
        task.resume()
    }
}
