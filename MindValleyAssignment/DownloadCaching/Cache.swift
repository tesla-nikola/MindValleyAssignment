//
//  Cache.swift
//  MindValleyAssignment
//
//  Created by Soham Ray on 16/05/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import UIKit

public final class Cache {
    
    private static let prefix = "com.mindvalley.Cache."
    
    /// The default `Cache` singleton
    public static let `default` = Cache(name: "default")
        
    private let memory = NSCache<NSString, AnyObject>()
    
    /// Construct a new instance of the cache
    ///
    /// - Parameter name: The name of the cache.
    public init(name: String) {
        let cacheName = Cache.prefix + name
        memory.name = cacheName

        NotificationCenter.default.addObserver(self, selector: #selector(clearMemory),
                                               name: UIApplication.didReceiveMemoryWarningNotification, object: nil)
    }
    
    /// Stores an image in the cache. Images will be added to memory.
    ///
    /// - Parameters
    ///     - image: The image to cache
    ///     - key: The unique identifier of the image
    ///     - completion: An optional closure called once the image has been saved to memory. Runs on the main queue.
    public func store(_ image: UIImage, forKey key: String,
                      completion: (() -> Void)? = nil) {
        memory.setObject(image, forKey: key as NSString)
    }
    
    private func storeToMemory(_ image: UIImage, forKey key: String) {
        memory.setObject(image, forKey: key as NSString)
    }
    
    /// Retrieve an image from cache.
    ///
    /// - Parameters
    ///     - key: The unique identifier of the image
    ///     - completion: The completion called once the image has been retrieved from the cache
    public func retrieveImage(forKey key: String, completion: (UIImage?) -> Void) {
        if let image = memory.object(forKey: key as NSString) as? UIImage {
            completion(image)
            return
        }
        completion(nil)
    }
    
    @objc public func clearMemory() {
        memory.removeAllObjects()
    }
    
}
