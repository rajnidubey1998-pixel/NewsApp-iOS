//
//  UIImageView+Load.swift
//  NewsApp
//


import Foundation
import UIKit

extension UIImageView {

    func loadImage(from urlString: String?) {

        self.image = UIImage(systemName: "photo")

        guard let urlString = urlString,
              let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self,
                  let data = data,
                  let image = UIImage(data: data) else { return }

            DispatchQueue.main.async {
                UIView.transition(with: self,
                                  duration: 0.2,
                                  options: .transitionCrossDissolve) {
                    self.image = image
                }
            }
        }.resume()
    }
}
