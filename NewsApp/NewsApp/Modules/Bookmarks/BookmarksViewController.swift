//
//  BookmarksViewController.swift
//  NewsApp
//

import UIKit

final class BookmarksViewController: UITableViewController {

    private var bookmarks: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bookmarks"

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadBookmarks()
    }

    private func loadBookmarks() {
        bookmarks = BookmarkManager.shared.getBookmarks()
        tableView.reloadData()

        tableView.separatorStyle = bookmarks.isEmpty ? .none : .singleLine
        // Empty state
        if bookmarks.isEmpty {
            let label = UILabel()
            label.text = "No bookmarks yet ⭐"
            label.textAlignment = .center
            label.textColor = .secondaryLabel
            tableView.backgroundView = label
        } else {
            tableView.backgroundView = nil
        }
    }
}


extension BookmarksViewController {

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        let article = bookmarks[indexPath.row]

        cell.titleLabel.text = article.title

        let source = article.source?.name ?? "Saved"
        let date = article.publishedAt?.prefix(10) ?? ""
        cell.subtitleLabel.text = "\(source) • \(date)"

        cell.newsImageView.loadImage(from: article.urlToImage)

        cell.bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)

        return cell
    }
}


extension BookmarksViewController {

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            let article = bookmarks[indexPath.row]

            BookmarkManager.shared.toggleBookmark(article)
            bookmarks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)

            if bookmarks.isEmpty {
                loadBookmarks()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {

        let vc = ArticleDetailViewController()
        vc.article = bookmarks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
