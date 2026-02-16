//
//  NewsListViewController.swift
//  NewsApp
//


import UIKit

final class NewsListViewController: UITableViewController {
    
    private let viewModel = NewsListViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.backgroundColor = .systemGroupedBackground
        setupSearch()
        bindViewModel()
        
        Task {
            await viewModel.fetchNews()
        }
    }
    
    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.onError = { error in
            print("Error:", error)
        }
    }
    
    private func setupSearch() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
}

// MARK: - TableView
extension NewsListViewController {
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfArticles
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "NewsCell",
            for: indexPath
        ) as! NewsTableViewCell

        let article = viewModel.article(at: indexPath.row)

        // Configure cell (title, subtitle, bookmark state)
        cell.configure(with: article)

        // Load image
        cell.newsImageView.loadImage(from: article.urlToImage)

        // Bookmark action
        cell.bookmarkTapped = { [weak cell] in
            BookmarkManager.shared.toggleBookmark(article)
            cell?.updateBookmarkIcon()
        }

        return cell
    }

    // Pagination
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.articles.count - 1 {
            Task {
                await viewModel.fetchNews()
            }
        }
    }
    
    // Open detail
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ArticleDetailViewController()
        vc.article = viewModel.articles[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension NewsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           let trimmed = searchText.trimmingCharacters(in: .whitespaces)

           if trimmed.isEmpty {
               viewModel.query = nil
           } else {
               viewModel.query = trimmed
           }

           Task {
               await viewModel.fetchNews(reset: true)
           }
       }

       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           searchBar.text = ""
           viewModel.query = nil

           Task {
               await viewModel.fetchNews(reset: true)
           }
       }
}

extension NewsListViewController{
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height - 200 {
            guard viewModel.canLoadMore else { return }

            Task {
                await viewModel.fetchNews()
            }
        }
    }
}

//extension NewsListViewController{
//    func loadImage(from urlString: String?, into imageView: UIImageView) {
//        guard let urlString,
//              let url = URL(string: urlString) else {
//            imageView.image = UIImage(systemName: "photo")
//            return
//        }
//
//        imageView.image = UIImage(systemName: "photo") // placeholder
//
//        URLSession.shared.dataTask(with: url) { data, _, _ in
//            guard let data, let image = UIImage(data: data) else { return }
//
//            DispatchQueue.main.async {
//                imageView.image = image
//            }
//        }.resume()
//    }
//}
