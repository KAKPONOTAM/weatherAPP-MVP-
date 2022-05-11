import Foundation

enum AlertTitles {
    case error
    case Ok
    
    var title: String {
        switch self {
        case .error:
            return "Error"
        case .Ok:
            return "Ok"
        }
    }
}
