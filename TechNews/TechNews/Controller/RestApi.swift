//
//  RestApi.swift
//  TechNews
//
//  Created by Rahul Anand on 09/05/21.
//

import Foundation

class RestApi {
    
    private var hostUrl: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "TC-Info", ofType: "plist") else {
                fatalError("TC-Info.plist can not be found")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "HOST") as? String else {
                fatalError("Host not found inside TC-Info.plist")
            }
            return value
        }
    }
    private var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "TC-Info", ofType: "plist") else {
                fatalError("TC-Info.plist can not be found")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError("Api key not found inside TC-Info.plist")
            }
            if value.starts(with: "_") {
                fatalError("Please Get a New API KEY")
            }
            return value
        }
    }
    
    func getUrlForNews() -> URL? {
        
        let resourceString = "\(hostUrl)\(apiKey)"
        if let url = URL(string: resourceString) {
            return url
        } else {
            return nil
        }
    }
    
}
