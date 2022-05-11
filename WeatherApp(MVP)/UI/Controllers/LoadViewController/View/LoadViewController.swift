import UIKit
import CoreLocation

class LoadViewController: UIViewController {
    var presenter: LoadViewPresenterDelegate?
    private let locationManager = CLLocationManager()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubview()
        setupConstraints()
        geolocationRequest()
        presenter?.getWeatherData()
    }
    
    private func addSubview() {
        view.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func geolocationRequest() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        presenter?.lat = locationManager.location?.coordinate.latitude
        presenter?.lon = locationManager.location?.coordinate.longitude
    }
}

extension LoadViewController: LoadViewDelegate {
    func success() {
        if let weeklyWeatherData = presenter?.weeklyWeatherData,
           let currentWeatherData = presenter?.currentWeatherData {
            let weatherViewController = ModuleBuilder.createWeatherModule(weeklyWeatherData: weeklyWeatherData, currentWeatherData: currentWeatherData)
            weatherViewController.modalPresentationStyle = .overFullScreen
            present(weatherViewController, animated: true) {
                self.activityIndicator.isHidden = true
            }
        }
    }
    
    func failure(error: Error) {
        let alert = UIAlertController(title: AlertTitles.error.title, message: "\(AlertTitles.error.title): \(error.localizedDescription)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: AlertTitles.Ok.title, style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}

extension LoadViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager)  {
        
    }
    
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
}


