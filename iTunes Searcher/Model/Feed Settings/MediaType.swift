//
//  MediaType.swift
//  iTunes Searcher
//
//  Created by Huy Ong on 8/19/20.
//

extension FeedSetting {
    enum MediaType: String, CaseIterable, Codable {
        case books          = "books"
        case apps           = "ios-apps"
        case iTunesMusic    = "itunes-music"
        case appleMusic     = "apple-music"
        case audioBooks     = "audiobooks"
        case tvShows        = "tv-shows"
        case movies         = "movies"
        case iTunesU        = "itunes-u"
        case podcasts       = "podcasts"
        case musicVideos    = "music-videos"
        
        func toString() -> String {
            switch self {
            case .apps:         return "📱 iOS Apps"
            case .books:        return "📚 Books"
            case .iTunesMusic:  return "🎵 iTunes Music"
            case .appleMusic:   return "🎶 Apple Music"
            case .audioBooks:   return "🎧 Audiobooks"
            case .tvShows:      return "📺 TV Shows"
            case .movies:       return "🎞 Movies"
            case .iTunesU:      return "💿 iTunes U"
            case .podcasts:     return "🎙 Podcasts"
            case .musicVideos:  return "📹 Music Videos"
            }
        }
    }
}
