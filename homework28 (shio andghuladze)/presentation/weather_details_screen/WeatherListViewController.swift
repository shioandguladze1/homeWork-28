//
//  WeatherListViewController.swift
//  homework28 (shio andghuladze)
//
//  Created by shio andghuladze on 30.08.22.
//

import UIKit

class WeatherListViewController: UIViewController {
    @IBOutlet weak var countriesTableView: UITableView!
    private var countries = [Country]()
    private let viewModel = WeatherListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        getCountries()
    }
    
    private func getCountries(){
        viewModel.getCountries {[weak self] countries in
            self?.countries = countries
            DispatchQueue.main.async {
                self?.countriesTableView.reloadData()
            }
        }
    }
    
    private func setUpTableView(){
        countriesTableView.register(UINib(nibName: "CountriesTableViewCell", bundle: nil), forCellReuseIdentifier: "CountriesTableViewCell")
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
    }

}

extension WeatherListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CountriesTableViewCell") as? CountriesTableViewCell{
            cell.setUp(name: countries[indexPath.row].name)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WeatherDetailsViewController") as? WeatherDetailsViewController{
            vc.country = countries[indexPath.row]
            present(vc, animated: true)
        }
    }
}
