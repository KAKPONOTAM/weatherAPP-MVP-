import UIKit

class WeatherViewController: UIViewController {
    var presenter: WeatherViewPresenterDelegate?
    
    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.text = presenter?.currentWeatherData?.name ?? ""
        return label
    }()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.backgroundColor = .white
        button.setImage(Images.presentCityListButtonTitleImage.titleImage, for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(presentCityList), for: .touchUpInside)
        return button
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.image = Images.weatherViewControllerTitleImage.titleImage
        return imageView
    }()
    
    private lazy var weatherInfoTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CurrentWeatherTableViewCell.self, forCellReuseIdentifier: CurrentWeatherTableViewCell.identifier)
        tableView.register(HourlyWeatherTableViewCell.self, forCellReuseIdentifier: HourlyWeatherTableViewCell.identifier)
        tableView.register(WeeklyWeatherTableViewCell.self, forCellReuseIdentifier: WeeklyWeatherTableViewCell.identifier)
        tableView.register(SunriseAndSunsetTableViewCell.self, forCellReuseIdentifier: SunriseAndSunsetTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubview()
        setupConstraints()
    }
    
    private func addSubview() {
        view.addSubview(backgroundImageView)
        view.addSubview(weatherInfoTableView)
        view.addSubview(cityNameLabel)
        view.addSubview(exitButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            weatherInfoTableView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 100),
            weatherInfoTableView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor),
            weatherInfoTableView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor),
            weatherInfoTableView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            exitButton.bottomAnchor.constraint(equalTo: weatherInfoTableView.topAnchor, constant: -10),
            exitButton.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 20),
            exitButton.widthAnchor.constraint(equalToConstant: 50),
            exitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            cityNameLabel.bottomAnchor.constraint(equalTo: weatherInfoTableView.topAnchor),
            cityNameLabel.leadingAnchor.constraint(equalTo: exitButton.trailingAnchor),
            cityNameLabel.trailingAnchor.constraint(equalTo: weatherInfoTableView.trailingAnchor, constant: -50),
            cityNameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func presentCityList() {
        presenter?.presentCityList()
    }
}

extension WeatherViewController: WeatherViewDelegate {
    func presentCityButtonTapped() {
        let cityListViewController = ModuleBuilder.createCityListViewController()
        cityListViewController.delegate = self
        present(cityListViewController, animated: true)
    }
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = WeatherTableViewSections.getRow(index: section)
        
        switch section {
        case .current:
            return 1
        case .hourly:
            return 1
        case .weekly:
            return presenter?.weeklyWeatherData?.daily?.count ?? 0
        case .sunriseAndSunset:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WeatherTableViewSections.getRow(index: indexPath.section)
        
        switch cell {
        case .current:
            guard let currentWeatherCell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherTableViewCell.identifier, for: indexPath) as? CurrentWeatherTableViewCell else { return UITableViewCell() }
            guard let currentWeatherData = presenter?.currentWeatherData else { return UITableViewCell() }
            
            let currentWeatherPresenter = CurrentWeatherTableViewCellPresenter(cell: currentWeatherCell)
            currentWeatherPresenter.configure(with: currentWeatherData, index: indexPath.row)
            currentWeatherCell.presenter = currentWeatherPresenter
            
            return currentWeatherCell
            
        case .hourly:
            guard let hourlyWeatherCell = tableView.dequeueReusableCell(withIdentifier: HourlyWeatherTableViewCell.identifier, for: indexPath) as? HourlyWeatherTableViewCell else { return UITableViewCell() }
            
            guard let weeklyWeatherData = presenter?.weeklyWeatherData else { return UITableViewCell() }
            
            let hourlyWeatherPresenter = HourlyWeatherTableViewCellPresenter(cell: hourlyWeatherCell)
            hourlyWeatherCell.hourlyWeatherPresenter = hourlyWeatherPresenter
            hourlyWeatherPresenter.weeklyWeatherData = weeklyWeatherData
            
            return hourlyWeatherCell
            
        case .weekly:
            guard let weeklyWeatherCell = tableView.dequeueReusableCell(withIdentifier: WeeklyWeatherTableViewCell.identifier, for: indexPath) as? WeeklyWeatherTableViewCell else { return UITableViewCell() }
            guard let weeklyWeatherData = presenter?.weeklyWeatherData else { return UITableViewCell() }
            
            let weeklyWeatherPresenter = WeeklyWeatherTableViewCellPresenter(cell: weeklyWeatherCell)
            weeklyWeatherCell.presenter = weeklyWeatherPresenter
            weeklyWeatherPresenter.configure(with: weeklyWeatherData , index: indexPath.row)
            
            return weeklyWeatherCell
            
        case .sunriseAndSunset:
            guard let sunriseAndSunsetWeatherCell = tableView.dequeueReusableCell(withIdentifier: SunriseAndSunsetTableViewCell.identifier, for: indexPath) as? SunriseAndSunsetTableViewCell else { return UITableViewCell() }
            guard let currentWeatherData = presenter?.currentWeatherData else { return UITableViewCell() }
            
            let sunriseAndSunsetPresenter = SunriseAndSunsetTableViewCellPresenter(cell: sunriseAndSunsetWeatherCell)
            sunriseAndSunsetWeatherCell.configure(with: currentWeatherData)
            sunriseAndSunsetWeatherCell.presenter = sunriseAndSunsetPresenter
            
            return sunriseAndSunsetWeatherCell
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return WeatherTableViewSections.getSectionsAmount()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.heightForSection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = WeatherTableViewSections.getRow(index: indexPath.section)
        
        switch cell {
        case .current:
            return Constants.usualHeightForCell
        case .hourly:
            return Constants.usualHeightForCell
        case .weekly:
            return Constants.usualHeightForCell
        case .sunriseAndSunset:
            return Constants.usualHeightForCell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let cell = WeatherTableViewSections.getRow(index: section)
        
        switch cell {
        case .current:
            return HeadersTitle.current.title
        case .hourly:
            return HeadersTitle.hourly.title
        case .weekly:
            return HeadersTitle.weekly.title
        case .sunriseAndSunset:
            return HeadersTitle.sunriseAndSunset.title
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .white
            headerView.textLabel?.font = UIFont.systemFont(ofSize: 15)
        }
    }
}

extension WeatherViewController: CityListViewControllerDelegate {
    func presentDataForSelectedCity(cityName: String) {
        cityNameLabel.text = cityName
        
        presenter?.networkManager?.fetchDataForSelectedCityFromCityList(cityName: cityName, completion: { [weak self] currentWeather in
            self?.presenter?.currentWeatherData = currentWeather
            
            guard let lat = self?.presenter?.currentWeatherData?.coord?.lat,
                  let lon = self?.presenter?.currentWeatherData?.coord?.lon else { return }
            
            self?.presenter?.networkManager?.fetchWeeklyWeatherData(lat: lat, lon: lon, completion: { [weak self] result in
                switch result {
                case .success(let weeklyWeatherData):
                    self?.presenter?.weeklyWeatherData = weeklyWeatherData
                    self?.weatherInfoTableView.reloadData()
                case .failure(let error):
                    let alert = UIAlertController(title: AlertTitles.error.title, message: AlertTitles.error.title + ": \(error)", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: AlertTitles.Ok.title, style: .default)
                    alert.addAction(okAction)
                    
                    self?.present(alert, animated: true)
                }
            })
        })
    }
}
