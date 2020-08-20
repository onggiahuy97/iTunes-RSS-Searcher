//
//  Feed.swift
//  iTunes Searcher
//
//  Created by Huy Ong on 8/17/20.
//

import UIKit

struct GenericFeed: Decodable {
    var feed: Feed
}

struct Feed: Decodable {
    let title: String
    var results: [FeedResult]
}

struct FeedResult: Decodable, Hashable {
    let artistName: String?
    let name: String
    let artworkUrl100: String
    let url: String
}
