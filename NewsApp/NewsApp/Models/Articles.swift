//
//  Articles.swift
//  NewsApp
//
//

import Foundation

struct NewsResponse: Codable {
    let articles: [Article]
}

struct Article: Codable, Equatable {
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let source: Source?
}

struct Source: Codable, Equatable {
    let name: String?
}
