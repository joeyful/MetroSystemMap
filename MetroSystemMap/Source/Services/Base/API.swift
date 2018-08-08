//
//  API.swift
//  MetroSystemMap
//
//  Created by Joey Wei on 8/7/18.
//  Copyright © 2018 Joey Wei. All rights reserved.
//

import Foundation

protocol API {
    
    var baseURL : URL { get }

    func send<T : Decodable>(_ request: APIRequest, success : @escaping (T, URL) -> Void, error errorCallback: @escaping (String) -> Void)
}

extension API {
    
    private var session : URLSession {
        
        let configuration = URLSessionConfiguration.default
        
        configuration.timeoutIntervalForRequest = 15 // Time out after 15 seconds
        
        return URLSession(configuration: configuration)
    }
    
    func send<T : Decodable>(_ request: APIRequest, success : @escaping (T, URL) -> Void, error errorCallback: @escaping (String) -> Void) {
        
        send(request, success: { (data, url) in
            self.decode(data: data, url: url, success: success, error: errorCallback)
        }, error: errorCallback)
    }
    
    private func send(_ request: APIRequest, success: @escaping (Data, URL) -> Void, error errorCallback :@escaping (String) -> Void) {
        
        guard let urlRequest = request.urlRequest(base: baseURL), let fullURL = urlRequest.url else {
            errorCallback("Network Error: Invalid URL")
            return
        }
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                errorCallback(error.localizedDescription)
            }
            else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400 {
                errorCallback("HTTP Error: \(httpResponse.statusCode)")
            }
            else if let data = data {
                success(data, fullURL)
            }
            else {
                errorCallback("Network Error: No data is returned")
            }
        }
        
        task.resume()
    }
    
    private func decode<T : Decodable>(data: Data, url : URL, success : @escaping (T, URL) -> Void, error errorCallback: @escaping (String) -> Void) {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            success(result, url)
        }
        catch (_) {
            errorCallback("Parse Error: Invalid Data Format")
        }
    }
}

