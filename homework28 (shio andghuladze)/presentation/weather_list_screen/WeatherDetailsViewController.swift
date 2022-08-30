//
//  WeatherDetailsViewController.swift
//  homework28 (shio andghuladze)
//
//  Created by shio andghuladze on 30.08.22.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    private let viewModel = WeatherDetailsViewModel()
    @IBOutlet weak var countryNameLbl: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    var country: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryNameLbl.text = country?.name
        getWeather()
    }
    
    private func getWeather(){
        viewModel.getCountryWeather(country: country) { weather in
            DispatchQueue.main.async {
                self.tempLabel.text = "Temperature - \(weather.main.temp) farenheit"
                self.windLabel.text = "Wind Speed - \(weather.wind.speed)"
                self.descLabel.text = weather.weather.first?.description
            }
        }
    }

}
