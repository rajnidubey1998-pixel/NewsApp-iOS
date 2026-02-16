//
//  BookmarkManager.swift
//  NewsApp
//


import Foundation

final class BookmarkManager {

    static let shared = BookmarkManager()
    private let key = "saved_articles"

    private init() {}

    func getBookmarks() -> [Article] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([Article].self, from: data) else {
            return []
        }
        return decoded
    }

    func isBookmarked(_ article: Article) -> Bool {
        return getBookmarks().contains { $0.url == article.url }
    }

    func toggleBookmark(_ article: Article) {
        var saved = getBookmarks()

        if let index = saved.firstIndex(where: { $0.url == article.url }) {
            saved.remove(at: index)
        } else {
            saved.append(article)
        }

        if let encoded = try? JSONEncoder().encode(saved) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}
