//
//  NewsListViewModel.swift
//  NewsApp
//

import Foundation

@MainActor
final class NewsListViewModel {

    // MARK: - Data
    private(set) var articles: [Article] = []

    // Pagination
    private var page = 1
    private var isLoading = false
    private var hasMoreData = true

    // Search
    var query: String?

    // Callbacks
    var onUpdate: (() -> Void)?
    var onError: ((String) -> Void)?

    // MARK: - Helpers
    func article(at index: Int) -> Article {
        if index < articles.count {
            return articles[index]
        }
        return articles.last!
    }

    var numberOfArticles: Int {
        return articles.count
    }

    var canLoadMore: Bool {
        return hasMoreData && !isLoading
    }

    // MARK: - Fetch
    func fetchNews(reset: Bool = false) async {
        guard !isLoading else { return }

        if reset {
            page = 1
            articles.removeAll()
            hasMoreData = true
        }

        isLoading = true

        do {
            let newArticles = try await APIClient.shared.fetchTopHeadlines(
                page: page,
                query: query
            )

            if newArticles.isEmpty {
                hasMoreData = false
            } else {
                articles.append(contentsOf: newArticles)
                page += 1
            }

            DispatchQueue.main.async {
                self.onUpdate?()
            }

        } catch {
            DispatchQueue.main.async {
                self.onError?(error.localizedDescription)
            }
        }

        isLoading = false
    }

}

