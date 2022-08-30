//
//  CountryRepository.swift
//  homework28 (shio andghuladze)
//
//  Created by shio andghuladze on 30.08.22.
//

import Foundation

protocol CountryRepository{
    
    func getCountries() async-> NetworkResponse
    
}

actor CountryRepositoryImpl: CountryRepository{
    
    static func getInstance()-> CountryRepository {
        return CountryRepositoryImpl()
    }
    
    nonisolated func getCountries() async -> NetworkResponse {
        
        guard let url = URL(string: countriesUrl) else{
            return ErrorResponse(errorMessage: "Could not convert \(countriesUrl) into url")
        }
        
        let request = URLRequest(url: url)
        let response = await NetworkManager.getResponse(dataType: [Country].self, request: request)
        return response
    }
    
}
