import Foundation
import UIKit
protocol CityListPresenterDelegate: AnyObject {
    var cityList: [String]? { get set }
    var filteredCityList: [String]? { get set }
    
    func searchCities(searchText: String)
}

protocol CityListViewDelegate: AnyObject {
   
}

class CityListPresenter: CityListPresenterDelegate {
    
    var cityList: [String]?
    var filteredCityList: [String]?
    let view: CityListViewDelegate
    let jsonManager: JSONParseManagerDelegate
    
    init(view: CityListViewDelegate, jsonManager: JSONParseManagerDelegate) {
        self.view = view
        self.jsonManager = jsonManager
        
        jsonManager.citiesJSONAutoParts { [weak self] cityList in
            self?.cityList = cityList?.city.map { $0.name }
            self?.filteredCityList = self?.cityList
        }
    }
    
    func searchCities(searchText: String) {
        switch searchText.isEmpty {
        case true:
            filteredCityList = cityList
            
        case false:
            filteredCityList = cityList?.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }

}
