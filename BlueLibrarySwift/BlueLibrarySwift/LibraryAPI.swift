//
//  LibraryAPI.swift
//  BlueLibrarySwift
//
//  Created by Yukui ye on 12/15/14.
//  Copyright (c) 2014 Raywenderlich. All rights reserved.
//

import UIKit

class LibraryAPI: NSObject {
   //singleton class
    class var sharedInstance: LibraryAPI {
        struct Singleton {
            static let instance = LibraryAPI()
        }
        return Singleton.instance
    }
    
    private let persisstencyManager: PersistencyManager
    private let httpClient: HTTPClient
    private let isOnline: Bool
    
    override init() {
        persisstencyManager = PersistencyManager()
        httpClient = HTTPClient()
        isOnline = false
        
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "downloadImage:", name: "BLDownloadImageNotification", object: nil)
    }
    
    func getAlbums() -> [Album] {
        return persisstencyManager.getAlbums()
    }
    
    func addAlbum(album: Album, index: Int) {
        persisstencyManager.addAlbum(album, index: index)
        if isOnline {
            httpClient.postRequest("/api/addAlbum", body: album.description())
        }
    }
    
    func deleteAlbum(index: Int) {
        persisstencyManager.deleteAlbumAtIndex(index)
        if isOnline {
            httpClient.postRequest("/api/deleteAlbum", body: "\(index)")
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func downloadImage(notification: NSNotification) {
        let userInfo = notification.userInfo as [String: AnyObject]
        var imageView = userInfo["imageView"] as UIImageView?
        let coverUrl = userInfo["coverUrl"] as NSString
        
        if let imageViewUnWrapped = imageView {
            imageViewUnWrapped.image = persisstencyManager.getImage(coverUrl.lastPathComponent)
            if imageViewUnWrapped.image == nil {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                    let downloadedImage = self.httpClient.downloadImage(coverUrl)
                    dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                        imageViewUnWrapped.image = downloadedImage
                        self.persisstencyManager.saveImage(downloadedImage, filename: coverUrl.lastPathComponent)
                    })
                })
            }
        }
    }
    
    func saveAlbums() {
        persisstencyManager.saveAlbums()
    }
}

