//
//  UIImageView+Extension.swift
//  Movies
//
//  Created by Ignacio Paradisi on 4/25/24.
//

import UIKit


extension UIImageView {
    @discardableResult
    func load(from urlPath: String, repository: RepositoryProvider = MovieRepository()) -> Task<Void, Error>? {
        self.image = nil
        let task = Task {
            let data = try await repository.getImage(with: urlPath)
            await MainActor.run {
                self.image = UIImage(data: data)
            }
        }
        Task.detached {
            try await task.value
        }
        return task
    }
}
