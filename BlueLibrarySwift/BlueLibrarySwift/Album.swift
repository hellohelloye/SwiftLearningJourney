//
//  Album.swift
//  BlueLibrarySwift
//
//  Created by Yukui ye on 12/15/14.
//  Copyright (c) 2014 Raywenderlich. All rights reserved.
//

import UIKit

class Album: NSObject, NSCoding {
    var title: String!
    var artist: String!
    var genre: String!
    var coverUrl: String!
    var year: String!
    
    init(title: String, artist: String, genre: String, coverUrl: String, year: String) {
        super.init()
        
        self.title = title
        self.artist = artist
        self.genre = genre
        self.coverUrl = coverUrl
        self.year = year
    }
    
    required init(coder decoder: NSCoder) {
        super.init()
        self.title = decoder.decodeObjectForKey("title") as String?
        self.artist = decoder.decodeObjectForKey("artist") as String?
        self.genre = decoder.decodeObjectForKey("genre") as String?
        self.coverUrl = decoder.decodeObjectForKey("cover_url") as String?
        self.year = decoder.decodeObjectForKey("year") as String?
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(artist, forKey: "artist")
        aCoder.encodeObject(genre, forKey: "genre")
        aCoder.encodeObject(coverUrl, forKey: "cover_url")
        aCoder.encodeObject(year, forKey: "year")
    }
    
    func description() -> String {
      return "title: \(title)" + "artist: \(artist)" + "genre: \(genre)" + "coverUrl: \(coverUrl)" + "year: \(year)"
    }
}

extension Album {
    func ae_tableRepresentation() -> (titles:[String], values:[String]) {
        return (["Artist", "Album", "Genre", "Year"], [artist, title, genre, year])
    }
}
