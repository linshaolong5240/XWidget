//
//  XWFileManagerHelper.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import Foundation
import CoreGraphics

extension FileManager {
    static let groupContainerURL: URL? = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Bundle.sharedContainerIdentifier)
    
    static let cacheDirectoryURL: URL? = groupContainerURL?.appendingPathComponent("Cache", isDirectory: true)
    static let imageCacheDirectoryURL: URL? = cacheDirectoryURL?.appendingPathComponent("Image", isDirectory: true)
    
    static func save(image: CrossImage, name: String? = nil, compressionQuality: CGFloat = 0.7) throws -> URL?  {
        guard let imageCacheDirectoryURL = FileManager.imageCacheDirectoryURL else {
            return nil
        }

        if !FileManager.default.fileExists(atPath: imageCacheDirectoryURL.path) {
            try FileManager.default.createDirectory(atPath: imageCacheDirectoryURL.path, withIntermediateDirectories: true, attributes: nil)
        }
        
        guard let imageData = image.jpegData(compressionQuality: 0.7) else {
            return nil
        }
        
        let fileName: String = name == nil ? imageData.md5() : name!
        let imageURL = imageCacheDirectoryURL.appendingPathComponent(fileName)
        
        try imageData.write(to: imageURL, options: [.atomic])
        return imageURL
    }
    
    static func save(imageData: Data, name: String? = nil) throws -> URL?  {
        guard let imageCacheDirectoryURL = FileManager.imageCacheDirectoryURL else {
            return nil
        }

        if !FileManager.default.fileExists(atPath: imageCacheDirectoryURL.path) {
            try FileManager.default.createDirectory(atPath: imageCacheDirectoryURL.path, withIntermediateDirectories: true, attributes: nil)
        }
        
        let fileName: String = name == nil ? imageData.md5() : name!
        
        let imageURL = imageCacheDirectoryURL.appendingPathComponent(fileName)
        
        try imageData.write(to: imageURL, options: [.atomic])
        return imageURL
    }
}
