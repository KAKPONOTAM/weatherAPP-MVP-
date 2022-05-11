import Foundation
import UIKit
protocol CityListViewControllerDelegate: AnyObject {
    func presentDataForSelectedCity(cityName: String)
}

class CityListViewController: UIViewController {
    var presenter: CityListPresenterDelegate?
    weak var delegate: CityListViewControllerDelegate?
    
    private lazy var searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        return tableView
    }()
    
    private let searchTextField: UISearchTextField = {
        let textField = UISearchTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "search"
        textField.addTarget(self, action: #selector(searchCities), for: .editingChanged)
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubview()
        setupConstraints()
    }
    
    private func addSubview() {
        view.addSubview(searchTableView)
        view.addSubview(searchTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            searchTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchTextField.bottomAnchor.constraint(equalTo: searchTableView.topAnchor, constant: -10)
        ])
    }
    
    @objc private func searchCities() {
        guard let searchText = searchTextField.text else { return }
        presenter?.searchCities(searchText: searchText)
        searchTableView.reloadData()
    }
}

extension CityListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.filteredCityList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = presenter?.filteredCityList?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedCity = presenter?.filteredCityList?[indexPath.row] else { return }
        print(selectedCity)
        delegate?.presentDataForSelectedCity(cityName: selectedCity)
        dismiss(animated: true)
    }
}

extension CityListViewController: CityListViewDelegate {
   
}
