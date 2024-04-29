//
//  URLImageView.swift
//  Movies
//
//  Created by Ignacio Paradisi on 4/29/24.
//

import UIKit

class URLImageView: UIImageView {
    private var task: Task<Void, Never>?
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)
    
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    deinit {
        task?.cancel()
    }
    
    private func initialize() {
        backgroundColor = .tertiarySystemGroupedBackground
        addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.hidesWhenStopped = true
        NSLayoutConstraint.activate([
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func load(from urlPath: String, repository: RepositoryProvider = MovieRepository()) {
        self.task?.cancel()
        self.task = nil
        self.image = nil
        let task = Task {
            await MainActor.run {
                loadingIndicator.startAnimating()
            }
            do {
                let data = try await repository.getImage(with: urlPath)
                await MainActor.run {
                    UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        self.image = UIImage(data: data)
                    }, completion: { _ in
                        self.loadingIndicator.stopAnimating()
                    })
                }
            } catch {
                await MainActor.run {
                    self.image = nil
                    loadingIndicator.stopAnimating()
                }
            }
        }
        self.task = task
    }
}
