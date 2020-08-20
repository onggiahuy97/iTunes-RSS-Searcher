//
//  FeedSettingView.swift
//  iTunes Searcher
//
//  Created by Huy Ong on 8/16/20.
//

import SwiftUI

struct FeedSettingView: View {
    @ObservedObject var model: FeedModel
    @Environment(\.presentationMode) var presentation
    @State private var sliderValue: CGFloat = 0.15
    
    var body: some View {
        NavigationView {
            container
                .navigationTitle(Text("Feed Settings"))
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button(action: {
                    startFetching()
                }) {
                    Text("Filter")
                })
        }
    }
    
    private func startFetching() {
        model.feed.feed = .init(title: "Loading", results: [])
        model.fetchAPIUsingCombine()
        presentation.wrappedValue.dismiss()
    }
    
    var container: some View {
        Form {
            Section(header: Text("Country")) {
                Picker("Country", selection: $model.feedSetting.Country) {
                    ForEach(FeedSetting.Country.allCases, id: \.self) {
                        Text($0.rawValue).tag($0)
                    }
                }
            }
            
            Section(header: Text("Media")) {
                Picker("Media Type", selection: $model.feedSetting.MediaType) {
                    ForEach(FeedSetting.MediaType.allCases, id: \.self) {
                        Text($0.toString()).tag($0)
                    }
                }
            }
            
            Section(header: Text("Feed")) {
                Picker("Feed Type", selection: $model.feedSetting.FeedType) {
                    ForEach(model.feedType, id: \.self) {
                        Text($0.toString()).tag($0)
                    }
                }
            }
            
            Section(header: Text("Genre")) {
                Picker("Genre", selection: $model.feedSetting.Genre) {
                    ForEach(model.genre, id: \.self) {
                        Text($0.toString()).tag($0)
                    }
                }
            }
            
            Section(header: Text("Result Limit")) {
                Stepper("Limit: \(Int(sliderValue * 100))",
                        value: $model.feedSetting.ResultLimit, in: 1...50) { _ in
                    sliderValue = CGFloat(model.feedSetting.ResultLimit) / 100
                }
                Slider(value: $sliderValue, in: 0.01...0.5) { (bool) in
                    if !bool { model.feedSetting.ResultLimit = Int(sliderValue * 100) }
                }
            }
            .onAppear {
                sliderValue = CGFloat(model.feedSetting.ResultLimit) / 100
            }
            
            Section(header: Text("Allow Explicit")) {
                Toggle("Allow Explicit", isOn: $model.feedSetting.AllowExplicit)
            }
        }
    }
}

struct FeedSettingView_Previews: PreviewProvider {
    static var previews: some View {
        FeedSettingView(model: FeedModel())
    }
}
