//
//  Show.swift
//  NLNL
//
//  Created by steven on 2023/1/6.
//

import SwiftUI



struct Show: View {
    @Binding var show: Bool
    var body: some View {
        Link("神曲點此", destination: URL(string: "https://www.youtube.com/watch?v=Nl4lAO-HFJo")!)
    }
}

struct Show_Previews: PreviewProvider {
    static var previews: some View {
        Show(show: .constant(true))
    }
}
