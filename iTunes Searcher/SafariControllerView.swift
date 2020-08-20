//
//  SafariControllerView.swift
//  iTunes Searcher
//
//  Created by Huy Ong on 8/19/20.
//

import SwiftUI
import SafariServices

struct SafariControllerView: View {
    @Environment(\.presentationMode) var presentation
    
    var url: String
    
    @State private var isPresenting = true
    
    var body: some View {
        SafariView(url: url, isPresenting: $isPresenting)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onChange(of: isPresenting) { _ in
                presentation.wrappedValue.dismiss()
            }
    }
    
    struct SafariView: UIViewControllerRepresentable {
        var url: String
        
        @Binding var isPresenting: Bool
        
        func makeUIViewController(context: Context) -> SFSafariViewController {
            let url = URL(string: self.url) ?? URL(string: "")
            let sfVC = SFSafariViewController(url: url!)
            sfVC.delegate = context.coordinator
            return sfVC
        }
        
        func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
            
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(isPresenting: $isPresenting)
        }
        
        class Coordinator: NSObject, SFSafariViewControllerDelegate {
            @Binding var isPresenting: Bool
            
            init(isPresenting: Binding<Bool>) {
                _isPresenting = isPresenting
            }
            
            func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
                isPresenting = false
            }
        }
    }
}

