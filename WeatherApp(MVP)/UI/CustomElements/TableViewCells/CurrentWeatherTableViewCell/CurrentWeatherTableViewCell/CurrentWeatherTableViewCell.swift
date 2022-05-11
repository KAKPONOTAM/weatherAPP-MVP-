import UIKit
import Kingfisher

class CurrentWeatherTableViewCell: UITableViewCell {
    var presenter: CurrentWeatherPresenterDelegate?
    
    private let currentWeatherInfoContainer: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: effect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let weatherDescriptionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureFeelsLikeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - override inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        setupConstraints()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addSubview() {
        contentView.addSubview(currentWeatherInfoContainer)
        currentWeatherInfoContainer.contentView.addSubview(temperatureLabel)
        currentWeatherInfoContainer.contentView.addSubview(temperatureFeelsLikeLabel)
        currentWeatherInfoContainer.contentView.addSubview(windSpeedLabel)
        currentWeatherInfoContainer.contentView.addSubview(weatherDescriptionLabel)
        currentWeatherInfoContainer.contentView.addSubview(weatherDescriptionImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            currentWeatherInfoContainer.topAnchor.constraint(equalTo: self.topAnchor),
            currentWeatherInfoContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            currentWeatherInfoContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            currentWeatherInfoContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            weatherDescriptionImageView.topAnchor.constraint(equalTo: currentWeatherInfoContainer.topAnchor),
            weatherDescriptionImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherDescriptionImageView.heightAnchor.constraint(equalTo: currentWeatherInfoContainer.heightAnchor, multiplier: 1 / 3)
        ])
        
        NSLayoutConstraint.activate([
            weatherDescriptionLabel.topAnchor.constraint(equalTo: currentWeatherInfoContainer.topAnchor),
            weatherDescriptionLabel.leadingAnchor.constraint(equalTo: currentWeatherInfoContainer.leadingAnchor, constant: 5),
            weatherDescriptionLabel.widthAnchor.constraint(equalTo: currentWeatherInfoContainer.widthAnchor, multiplier: 1 / 4),
            weatherDescriptionLabel.bottomAnchor.constraint(equalTo: temperatureLabel.topAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: weatherDescriptionImageView.bottomAnchor, constant: 10),
            temperatureLabel.leadingAnchor.constraint(equalTo: currentWeatherInfoContainer.leadingAnchor, constant: 5),
            temperatureLabel.widthAnchor.constraint(equalTo: currentWeatherInfoContainer.widthAnchor, multiplier: 1 / 3),
            temperatureLabel.bottomAnchor.constraint(equalTo: currentWeatherInfoContainer.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            temperatureFeelsLikeLabel.topAnchor.constraint(equalTo: weatherDescriptionImageView.bottomAnchor, constant: 10),
            temperatureFeelsLikeLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 10),
            temperatureFeelsLikeLabel.widthAnchor.constraint(equalTo: currentWeatherInfoContainer.widthAnchor, multiplier: 1 / 3),
            temperatureFeelsLikeLabel.bottomAnchor.constraint(equalTo: currentWeatherInfoContainer.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            windSpeedLabel.topAnchor.constraint(equalTo: weatherDescriptionImageView.bottomAnchor, constant: 10),
            windSpeedLabel.leadingAnchor.constraint(equalTo: temperatureFeelsLikeLabel.trailingAnchor, constant: 10),
            windSpeedLabel.widthAnchor.constraint(equalTo: currentWeatherInfoContainer.widthAnchor, multiplier: 1 / 3),
            windSpeedLabel.bottomAnchor.constraint(equalTo: currentWeatherInfoContainer.bottomAnchor, constant: -5)
        ])
    }
}

extension CurrentWeatherTableViewCell: CurrentWeatherCellDelegate {
    func configuration(with currentWeatherData: CurrentWeatherInfo, index: Int) {
        guard let temperature = currentWeatherData.main?.temp,
              let feelsLikeTemperature = currentWeatherData.main?.feels_like,
              let iconId = currentWeatherData.weather?.first?.icon,
              let iconUrl = URL(string: "https://openweathermap.org/img/wn/\(iconId)@2x.png"),
              let description = currentWeatherData.weather?.first?.description,
              let windSpeed = currentWeatherData.wind?.speed else { return }
        
        temperatureLabel.text = """
                                Temp:
                                \(Int(temperature))°C
                                """
        temperatureFeelsLikeLabel.text = """
                                         FL:
                                         \(Int(feelsLikeTemperature))°C
                                         """
        
        windSpeedLabel.text = """
                              Wind:
                              \(Int(windSpeed)) m/s
                              """
        weatherDescriptionLabel.text = description
        weatherDescriptionImageView.kf.setImage(with: iconUrl)
    }
}
