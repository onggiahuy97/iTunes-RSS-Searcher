//
//  SingleAppFeedView.swift
//  iTunes Searcher
//
//  Created by Huy Ong on 8/18/20.
//

import SwiftUI
import Combine

struct SingleFeedView: View {
    @EnvironmentObject var model: FeedModel
    
    var result: FeedResult
    
    var width: CGFloat {
        switch model.feedSetting.MediaType {
        case .apps, .iTunesMusic, .appleMusic, .audioBooks, .tvShows, .podcasts, .musicVideos:
            return 67
        case .books, .movies, .iTunesU:
            return 87
        }
    }
    
    var height: CGFloat {
        switch model.feedSetting.MediaType {
        case .apps, .iTunesMusic, .appleMusic, .audioBooks, .tvShows, .podcasts, .musicVideos:
            return 67
        case .books, .movies, .iTunesU:
            return 120
        }
    }
    
    var body: some View {
        let url = URL(string: result.artworkUrl100)!
        return HStack {
            AsyncImage(url: url, placeholder: ProgressView())
                .frame(width: width, height: height)
                .cornerRadius(12)
            VStack(alignment: .leading) {
                Text(result.name)
                    .font(.subheadline)
                    .lineLimit(2)
                Text(result.artistName ?? "Play list")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
            }
        }
    }
}

