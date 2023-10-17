//
//  ContentView.swift
//  RefreshDemo
//
//  Created by czi on 2023/10/17.
//

import SwiftUI
import LSRefreshable

class ViewModel: ObservableObject {
   @Published var isRefresh: Bool = false
}

@available(iOS 14.0, *)
struct ContentView: View {
    let array = ["text1", "text2", "text3"]
    @StateObject private var vm = ViewModel()

    var body: some View {
       ScrollView {
           ForEach(0..<array.count, id: \.self) { index in
               let text = array[index]
               HStack {
                   Text(text)
               }
           }
       }
       .makeRefreshable {
           try? await Task.sleep(nanoseconds: 2_000_000_000)
       }
    }

}

#Preview {
    ContentView()
}

