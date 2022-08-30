//
//  WeatherListViewModel.swift
//  homework28 (shio andghuladze)
//
//  Created by shio andghuladze on 30.08.22.
//

import Foundation

class WeatherListViewModel{
    private let countryRepository = CountryRepositoryImpl.getInstance()
    
    func getCountries(onResponse: @escaping ([Country])-> Void){
        Task{
            let response = await countryRepository.getCountries()
            NetworkManager.parseResponse(response: response) { countries in
                onResponse(countries)
            }
        }
    }
}
