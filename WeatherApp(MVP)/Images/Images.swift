import Foundation
import UIKit

enum Images {
    case weatherViewControllerTitleImage
    case presentCityListButtonTitleImage
    case sunriseImage
    case sunsetImage
    
    var titleImage: UIImage? {
        switch self {
        case .weatherViewControllerTitleImage:
            return UIImage(named: "backgroundImage")
        case .presentCityListButtonTitleImage:
            return UIImage(systemName: "magnifyingglass")
        case .sunriseImage:
            return UIImage(named: "sunrise")
        case .sunsetImage:
            return UIImage(named: "sunset")
        }
    }
}
