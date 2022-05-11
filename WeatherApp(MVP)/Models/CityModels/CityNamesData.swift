import Foundation

struct CityNamesData: Decodable {
    let city: [CityNames]
}

struct CityNames: Decodable {
    let name: String
}

