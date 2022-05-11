import UIKit

class HourlyWeatherCollectionViewCell: UICollectionViewCell {
    var presenter: HourlyWeatherCollectionViewPresenterDelegate?
    
    private let weatherDescriptionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let hourLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: - override init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(weatherDescriptionImageView)
        contentView.addSubview(hourLabel)
        contentView.addSubview(temperatureLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - methods
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            hourLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            hourLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            hourLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1 / 4),
            hourLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            weatherDescriptionImageView.topAnchor.constraint(equalTo: hourLabel.bottomAnchor, constant: 5),
            weatherDescriptionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            weatherDescriptionImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            weatherDescriptionImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1 / 3)
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: weatherDescriptionImageView.bottomAnchor, constant: 5),
            temperatureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            temperatureLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1 / 3),
            temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
}

extension HourlyWeatherCollectionViewCell: HourlyWeatherCollectionViewDelegate {
    func configure(with weeklyWeatherData: WeeklyWeatherData, indexPath: IndexPath) {
        guard let date = weeklyWeatherData.hourly?[indexPath.item].dt,
              let hourWeatherIconId = weeklyWeatherData.hourly?[indexPath.row].weather.first?.icon,
              let hourWeatherDescriptionIconIdUrl = URL(string: "https://openweathermap.org/img/wn/\(hourWeatherIconId)@2x.png"),
              let timezoneOffset = weeklyWeatherData.timezoneOffset,
              let temperature = weeklyWeatherData.hourly?[indexPath.item].temp else { return }
        
        let correctHour = Date.getCorrectHour(unixTime: date, timezoneOffset: timezoneOffset)
        hourLabel.text = correctHour
        weatherDescriptionImageView.kf.setImage(with: hourWeatherDescriptionIconIdUrl)
        temperatureLabel.text = """
                                Temp:
                                \(Int(temperature))°C
                                """
    }
}

