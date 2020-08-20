//
//  ContentView.swift
//  iTunes Searcher
//
//  Created by Huy Ong on 8/15/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model: FeedModel
    @State private var showFilter = false
    
    var body: some View {
        let gesture = DragGesture().onEnded { value in
            if value.translation.width > 0 { showFilter = true }
        }
        return NavigationView {
            container
                .gesture(gesture)
                .sheet(isPresented: $showFilter) {
                    FeedSettingView(model: model)
                }
                .navigationTitle(Text(model.feed.feed.title))
                .navigationBarItems(trailing: filterButton)
        }
    }
    
    @ViewBuilder
    private var container: some View {
        switch model.feed.feed.title {
        case "Error":
            ProgressView("Please check filter")
        case "Loading":
            ProgressView("Loading...")
        default:
            listView
        }
    }
    
    private var filterButton: some View {
        Button(action: { showFilter = true }) { Text("Filter") }
    }
    
    private var listView: some View {
        List {
            infoView
            ForEach(model.feed.feed.results, id: \.self) { result in
                Button(action: {
                    let url = URL(string: result.url)!
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }) {
                    SingleFeedView(result: result)
                        .environmentObject(model)
                }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var infoView: some View {
        return ScrollView(.horizontal, showsIndicators: false) { Text(model.toString()) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: FeedModel())
    }
}
