//
//  NewsTableViewCell.swift
//  NewsApp
//

import UIKit

final class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!

    // Closure callback
    var bookmarkTapped: (() -> Void)?

    // Store article for UI state
    private var article: Article?

    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none

        newsImageView.layer.cornerRadius = 10
        newsImageView.clipsToBounds = true

        bookmarkButton.addTarget(self, action: #selector(bookmarkAction), for: .touchUpInside)
    }

    @objc private func bookmarkAction() {
        bookmarkTapped?()
    }

    // MARK: - Configure
    func configure(with article: Article) {
        self.article = article

        titleLabel.text = article.title
        subtitleLabel.text = article.source?.name ?? "News"

        updateBookmarkIcon()
    }

    // MARK: - Bookmark UI
    func updateBookmarkIcon() {
        guard let article else { return }

        let isSaved = BookmarkManager.shared.isBookmarked(article)
                let imageName = isSaved ? "bookmark.fill" : "bookmark"
                bookmarkButton.setImage(UIImage(systemName: imageName), for: .normal)
            }

            // MARK: - Reuse
            override func prepareForReuse() {
                super.prepareForReuse()

                newsImageView.image = UIImage(systemName: "photo")
                article = nil
            }
    }

