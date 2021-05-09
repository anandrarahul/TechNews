//
//  RestApi.swift
//  TechNews
//
//  Created by Rahul Anand on 09/05/21.
//

import Foundation

class RestApi {
    
    private let baseUrl = "http://newsapi.org/v2/top-headlines?"
    private let source = "techcrunch"
    private let apiKey = "c2dc28e08dac4fc2ad7eb8b22b1854f4"
    
    
    func getUrlForNews() -> URL? {
        
        let resourceString = "\(baseUrl)sources=\(source)&apiKey=\(apiKey)"
        if let url = URL(string: resourceString) {
            return url
        } else {
            return nil
        }
    }
    
}
