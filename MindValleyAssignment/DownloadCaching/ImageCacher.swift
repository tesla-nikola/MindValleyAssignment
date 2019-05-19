//
//  ImageCacher.swift
//  MindValleyAssignment
//
//  Created by Soham Ray on 17/05/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import UIKit
public typealias ImageDownloadCompletion = (UIImage?) -> Void

public final class ImageCacher {
    
    /// The shared instance of ImageCacher
    public static let shared = ImageCacher()
    
    public let cache: Cache
    public let downloader: Downloader
    
    /// Initialize a new instance of ImageCacher.
    ///
    /// - Parameter cache: The cache to use. Uses the `default` instance if nothing is passed
    /// - Parameter downloader: The downloader to use. Users the `default` instance if nothing is passed
    public init(cache: Cache = .default, downloader: Downloader = .default) {
        self.cache = cache
        self.downloader = downloader
    }
    
    /// Download or retrieve an image from cache
    ///
    /// - Parameters:
    ///     - url: The URL to load an image from
    ///     - progress: An optional closure to track the download progress
    ///     - completion: The closure to call once the download is done
    public func image(with url: URL,
                      progress: DownloadProgress?,
                      completion: @escaping ImageDownloadCompletion) {
        fetchImage(with: url, progress: progress, completion: completion)
    }
    
    private func fetchImage(with url: URL,
                            progress: DownloadProgress?,
                            completion: ImageDownloadCompletion?) {
        let key = url.absoluteString
        cache.retrieveImage(forKey: key) {[weak self] (image) in
            guard let image = image else {
                self?.downloader.download(url, progress: progress, completion: { data in
                    guard let self = self, let data = data, let image = UIImage(data: data) else {
                        completion?(nil)
                        return
                    }
                    
                    self.cache.store(image, forKey: url.absoluteString)
                    completion?(image)
                })
                return
            }
            completion?(image)
        }
    }
}
