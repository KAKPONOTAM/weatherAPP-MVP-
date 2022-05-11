import Foundation
protocol JSONParseManagerDelegate: AnyObject {
    func citiesJSONAutoParts(completion: @escaping (CityNamesData?) -> ())
}

class JSONParseManager: JSONParseManagerDelegate {
    func citiesJSONAutoParts(completion: @escaping (CityNamesData?) -> ()) {
        guard let path = Bundle.main.path(forResource: "cities", ofType: "json") else { return }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let citiesInfo = try JSONDecoder().decode(CityNamesData.self, from: data)
            completion(citiesInfo)
        } catch {
            print(error.localizedDescription)
        }
    }
}
