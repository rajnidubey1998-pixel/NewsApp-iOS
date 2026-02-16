//
//  ArticleDetailViewController.swift
//  NewsApp
//

import UIKit
import WebKit

final class ArticleDetailViewController: UIViewController {
    
    var article: Article?
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = webView
        
        if let urlString = article?.url,
           let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "bookmark"),
            style: .plain,
            target: self,
            action: #selector(toggleBookmark)
        )
    }
    
    @objc private func toggleBookmark() {
        guard let article else { return }
        BookmarkManager.shared.toggleBookmark(article)
    }
}

