//
//  FeedSetting.swift
//  iTunes Searcher
//
//  Created by Huy Ong on 8/16/20.
//

import Foundation

struct FeedSetting: Codable {
    var Country: Country
    var MediaType: MediaType
    var FeedType: FeedType
    var Genre: Genre
    var ResultLimit: Int
    var AllowExplicit: Bool
    
    static let Key = "FeedSettingKey"
}

extension FeedSetting: Equatable {
    
}

extension FeedSetting {
    func endpoint() -> String {
        var baseUrl = "https://rss.itunes.apple.com/api/v1"
        baseUrl.append("/\(self.Country)")
        baseUrl.append("/\(self.MediaType.rawValue)")
        baseUrl.append("/\(self.FeedType.rawValue)")
        baseUrl.append("/\(self.Genre.rawValue)")
        baseUrl.append("/\(self.ResultLimit)")
        baseUrl.append("/\(self.AllowExplicit ? "explicit" : "non-explicit")")
        baseUrl.append(".json")
        return baseUrl
    }
}
