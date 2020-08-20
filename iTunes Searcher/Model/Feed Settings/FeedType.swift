//
//  FeedType.swift
//  iTunes Searcher
//
//  Created by Huy Ong on 8/19/20.
//

extension FeedSetting {
    enum FeedType: String, CaseIterable {
        case topFree            = "top-free"
        case topPaid            = "top-paid"
        case topGrossing        = "top-grossing"
        case newAppsWeLove      = "new-apps-we-love"
        case newGamesWeLove     = "new-games-we-love"
        case topFreeiPad        = "top-free-ipad"
        case topGrossingiPad    = "top-grossing-ipad"
        case hotTracks          = "hot-tracks"
        case newMusic           = "new-music"
        case recentReleases     = "recent-releases"
        case topAlbums          = "top-albums"
        case topSongs           = "top-songs"
        case comingSoon         = "coming-soon"
        case newReleases        = "new-releases"
        case topAudiobooks      = "top-audiobooks"
        case topTVEpisodes      = "top-tv-episodes"
        case topTVSeasons       = "top-tv-seasons"
        case topMovies          = "top-movies"
        case topiTunesUCourse   = "top-itunes-u-courses"
        case topPodcasts        = "top-podcasts"
        case topMusicVideos     = "top-music-videos"
        
        func toString() -> String {
            switch self {
            case .topFree:          return "Top Free"
            case .topPaid:          return "Top Paid"
            case .topGrossing:      return "Top Grossing"
            case .newAppsWeLove:    return "New Apps We Love"
            case .newGamesWeLove:   return "New Games We Love"
            case .topFreeiPad:      return "Top Free iPad"
            case .topGrossingiPad:  return "Top Grossing iPad"
            case .hotTracks:        return "Hot Tracks"
            case .newMusic:         return "New Music"
            case .recentReleases:   return "Recent Releases"
            case .topAlbums:        return "Top Albums"
            case .topSongs:         return "Top Songs"
            case .comingSoon:       return "Coming Soon"
            case .newReleases:      return "New Releases"
            case .topAudiobooks:    return "Audiobooks"
            case .topTVEpisodes:    return "Top TV Episodes"
            case .topTVSeasons:     return "Top TV Seasons"
            case .topMovies:        return "Top Movies"
            case .topiTunesUCourse: return "Top iTunes U Courses"
            case .topPodcasts:      return "Top Podcasts"
            case .topMusicVideos:   return "Top Music Videos"
            }
        }
    }
}
