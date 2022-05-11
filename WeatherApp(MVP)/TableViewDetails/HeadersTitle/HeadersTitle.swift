import Foundation

enum HeadersTitle {
    case current
    case hourly
    case weekly
    case sunriseAndSunset
    
    var title: String {
        switch self {
        case .current:
            return "current weather info"
        case .hourly:
            return "hourly weather info"
        case .weekly:
            return "weekly weather info"
        case .sunriseAndSunset:
            return "sunrise and sunset time"
        }
    }
}
