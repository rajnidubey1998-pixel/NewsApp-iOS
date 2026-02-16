//
//  APIClient.swift
//  NewsApp
//


import Foundation

final class APIClient {
    
    static let shared = APIClient()
    private init() {}
    
    private let apiKey = "dad29f9c7c8e4020a237ae373c9cd5b4"
    
    func fetchTopHeadlines(page: Int, query: String? = nil) async throws -> [Article] {
        var components = URLComponents(string: "https://newsapi.org/v2/top-headlines")!
        var queryItems = [
            URLQueryItem(name: "country", value: "us"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        if let query = query, !query.isEmpty {
            queryItems.append(URLQueryItem(name: "q", value: query))
        }
        
        components.queryItems = queryItems
        
        let (data, _) = try await URLSession.shared.data(from: components.url!)
        let decoded = try JSONDecoder().decode(NewsResponse.self, from: data)
        return decoded.articles
    }
}
