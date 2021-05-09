//
//  NewsDetails.swift
//  TechNews
//
//  Created by Rahul Anand on 08/05/21.
//

import Foundation

struct Articles: Decodable {
    
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    let source: [String: String]
    
    private enum CodingKeys: String, CodingKey {
        
        case source = "source"
        case author = "author"
        case title = "title"
        case description = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case content = "content"
    }
    
}



struct Result: Decodable {
    
    let status: String?
    let totalResults: Int?
    let articles: [Articles]?
    
    private enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case totalResults = "totalResults"
        case articles = "articles"
        
    }
    
}
