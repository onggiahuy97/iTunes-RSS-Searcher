//
//  FeedModel.swift
//  iTunes Searcher
//
//  Created by Huy Ong on 8/16/20.
//

import Foundation
import Combine

class FeedModel: ObservableObject {
    
    @Published var feedSetting: FeedSetting {
        didSet {
            feedSettingDidChange()
            endpoint = feedSetting.endpoint()
        }
    }
    
    @Published var feed: GenericFeed 
    @Published var feedType: [FeedSetting.FeedType] = []
    @Published var genre: [FeedSetting.Genre] = []
    @Published var isSearching = false
    
    var endpoint: String?
    var cancellable: AnyCancellable?
    
    init() {
        feedSetting = FeedModel.initFeedSetting
        feed = .init(feed: .init(title: "Welcome", results: []))
        feedSetting = loadFeedSetting()
        feedSettingDidChange()
        endpoint = feedSetting.endpoint()
        fetchAPIUsingCombine()
    }
}

extension FeedModel {
    func saveFeedSetting() {
        let user = UserDefaults.standard
        
        do {
            let encodedFS = try JSONEncoder().encode(feedSetting)
            user.set(encodedFS, forKey: FeedSetting.Key)
        } catch {
            print(error)
        }
    }
    
    func loadFeedSetting() -> FeedSetting {
        let user = UserDefaults.standard
        
        guard let data = user.object(forKey: FeedSetting.Key) as? Data else {
            return FeedModel.initFeedSetting
        }
        
        do {
            let decodedSF = try JSONDecoder().decode(FeedSetting.self, from: data)
            return decodedSF
        } catch {
            print(error)
            return FeedModel.initFeedSetting
        }
    }
    
    func fetchAPIUsingCombine() {
        guard let url = URL(string: endpoint ?? "") else { return }
        self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: GenericFeed.self, decoder: JSONDecoder())
            .replaceError(with: .init(feed: .init(title: "Error", results: [])))
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .assign(to: \.feed, on: self)
        isSearching = false
    }
    
    func fetchAPIUsingFoundation() {
        guard let url = URL(string: endpoint ?? "") else { return }
        
        let task = URLSession.shared
        
        task.dataTask(with: url) { [weak self] (data, _, error) in
            guard let self = self else { return }
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let results = try JSONDecoder().decode(GenericFeed.self, from: data)
                DispatchQueue.main.async {
                    self.feed = results
                }
            } catch {
                print(error.localizedDescription)
                return
            }
            
        }
        .resume()
    }
    
    func feedSettingDidChange() {
        switch feedSetting.MediaType {
        case .books:
            feedType = [.topFree, .topPaid]
            genre = [.all]
        case .apps:
            feedType = [.newAppsWeLove, .newGamesWeLove, .topFree, .topPaid, .topFreeiPad, .topGrossing, .topGrossingiPad]
            genre = [.all, .games]
        case .iTunesMusic:
            feedType = [.hotTracks, .newMusic, .recentReleases, .topAlbums, .topSongs ]
            genre = [.all]
        case .appleMusic:
            feedType = [.comingSoon, .hotTracks, .newReleases, .topAlbums, .topSongs]
            genre = [.all, .country, .heavyMetal]
        case .audioBooks:
            feedType = [.topAudiobooks]
            genre = [.all]
        case .tvShows:
            feedType = [.topTVSeasons, .topTVEpisodes]
            genre = [.all]
        case .movies:
            feedType = [.topMovies]
            genre = [.all]
        case .iTunesU:
            feedType = [.topiTunesUCourse]
            genre = [.all]
        case .podcasts:
            feedType = [.topPodcasts]
            genre = [.all]
        case .musicVideos:
            feedType = [.topMusicVideos]
            genre = [.all]
        }
    }
}

extension FeedModel {
    static let initFeedSetting: FeedSetting =
        .init(Country: .us,
              MediaType: .apps,
              FeedType: .topFree,
              Genre: .all,
              ResultLimit: 15,
              AllowExplicit: true)
    
    func toString() -> String {
        let string = feedSetting.Country.rawValue       + " • " +
            feedSetting.MediaType.toString()            + " • " +
            feedSetting.FeedType.toString()             + " • " +
            "Limit: \(feedSetting.ResultLimit)"         + " • " +
            feedSetting.Genre.toString()                + " • " +
            "\(feedSetting.AllowExplicit ? "" : "Non-")Explicit"
        return string
    }
}
