//
//  OutpanAPI.swift
//  OutpanAPI
//
//  Created by Martin Rehder on 06.01.2017.
/*
 * Copyright 2017-present Martin Jacob Rehder.
 * http://www.rehsco.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

import Foundation

open class OutpanAPI {
    private let base = "api.outpan.com"
    private let apiKey: String
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    // MARK: - Search Function

    public func lookup(for gtin: String, completion: @escaping (OutpanAPIResult<AnyObject, OutpanAPISearchError>) -> Void) -> URLSessionTask? {
        
        let params = parameters()
        
        guard let url = URLWithParameters(params, productID: gtin) else {
            completion(.failure(.invalidURL))
            return nil
        }

        // create data task
        let task = searchTask(withURL: url, gtin: gtin, completion: completion)
        
        // start task
        task.resume()
        
        return task
    }
    
    // MARK: - Helper
    
    private func searchTask(withURL url: URL, gtin: String, completion: @escaping (OutpanAPIResult<AnyObject, OutpanAPISearchError>) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async { completion(.failure(.invalidServerResponse)) }
                return
            }
            
            guard 200...299 ~= httpResponse.statusCode else {
                DispatchQueue.main.async { completion(.failure(.serverError(httpResponse.statusCode))) }
                return
            }
            
            guard let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject else {
                    DispatchQueue.main.async { completion(.failure(.invalidJSON)) }
                    return
            }
            
            DispatchQueue.main.async { completion(.success(OutpanObject(from: json, gtin: gtin))) }
        }
    }
    
    private func parameters() -> [String : String] {
        let parameters = [ "apikey" : self.apiKey ]
        return parameters
    }
    
    private func URLWithParameters(_ parameters: [String : String], productID: String, path: String = "/v2/products") -> URL? {
        var components  = URLComponents()
        components.scheme = "https"
        components.host   = base
        components.path   = path + "/" + productID
        components.queryItems = parameters.map { URLQueryItem(name: $0.0, value: $0.1) }
        return components.url
    }
}
