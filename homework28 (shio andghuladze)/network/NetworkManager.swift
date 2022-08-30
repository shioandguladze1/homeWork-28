//
//  NetworkResponse.swift
//  homework28 (shio andghuladze)
//
//  Created by shio andghuladze on 30.08.22.
//

import Foundation

protocol NetworkResponse{}

struct SuccessResponse<T>: NetworkResponse{
    let data: T
}

struct ErrorResponse: NetworkResponse{
    let errorMessage: String
}

actor NetworkManager{
    private static let session = URLSession.shared
    private static let decoder = JSONDecoder()
    
    static func getResponse<T: Decodable>(dataType: T.Type,request: URLRequest) async-> NetworkResponse{
        do {
            let response = try await session.data(for: request)
            let statusCode = (response.1 as? HTTPURLResponse)?.statusCode ?? -1
            if (200...300).contains(statusCode) {
                if let data = decodeData(responseData: response.0, dataType: dataType) {
                    return SuccessResponse(data: data)
                }else {
                    return ErrorResponse(errorMessage: "Could not decode data" + (String(data: response.0, encoding: .utf8) ?? ""))
                }
            } else {
                return ErrorResponse(errorMessage: "error status code \(statusCode)")
            }
        }catch {
            return ErrorResponse(errorMessage: error.localizedDescription)
        }
    }
    
    private static func decodeData<T: Decodable>(responseData: Data, dataType: T.Type)-> T?{
        do {
            let data = try decoder.decode(dataType, from: responseData)
            return data
        }catch {
            print(error)
            return nil
        }
    }
    
    static func parseResponse<T>(response: NetworkResponse, onSuccess: (T)-> Void, onError: (String)-> Void = { print($0) }){
        if let data = (response as? SuccessResponse<T>)?.data{
            onSuccess(data)
            return
        }
        
        if let errorMessage = (response as? ErrorResponse)?.errorMessage {
            onError(errorMessage)
            return
        }
        
        onError("Unknown error")
    }
    
}
