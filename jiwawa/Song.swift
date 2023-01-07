//
//  Song.swift
//  NLNL
//
//  Created by steven on 2023/1/6.
//

import SwiftUI

struct Song: View {
    let url: URL
        
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController,
                                context: UIViewControllerRepresentableContext<SafariView>) {
        
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Song_Previews: PreviewProvider {
    static var previews: some View {
        Song()
    }
}
