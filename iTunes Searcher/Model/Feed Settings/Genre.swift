//
//  Genre.swift
//  iTunes Searcher
//
//  Created by Huy Ong on 8/19/20.
//

extension FeedSetting {
    enum Genre: String, CaseIterable {
        case all            = "all"
        case games          = "games"
        case country        = "country"
        case heavyMetal     = "heavy-metal"
        
        func toString() -> String {
            switch self {
            case .all   :       return "♾ All"
            case .games :       return "🎮 Games"
            case .country:      return "🏴 Country"
            case .heavyMetal:   return "🤯 Heavy Metal"
            }
        }
    }
}

