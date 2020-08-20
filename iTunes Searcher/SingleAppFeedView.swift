//
//  SingleAppFeedView.swift
//  iTunes Searcher
//
//  Created by Huy Ong on 8/18/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct SingleFeedView: View {
    @EnvironmentObject var model: FeedModel
    var result: FeedResult
    @State var isAnimating: Bool = true
    
    var width: CGFloat {
        switch model.feedSetting.MediaType {
        case .Apps, .iTunesMusic: return 57
        case .Books: return 80
        }
    }
    
    var height: CGFloat {
        switch model.feedSetting.MediaType {
        case .Apps, .iTunesMusic: return 57
        case .Books: return 120
        }
    }

    var body: some View {
        return HStack {
            WebImage(url: URL(string: result.artworkUrl100))
                .resizable()
                .frame(width: width, height: height)
                .cornerRadius(9)
            VStack(alignment: .leading) {
                Text(result.artistName).font(.subheadline)
                Text(result.name).font(.caption).foregroundColor(.secondary)
            }
        }
    }
}
