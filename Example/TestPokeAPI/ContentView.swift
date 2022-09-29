//
//  ContentView.swift
//  TestPokeAPI
//
//  Created by Tino on 29/9/2022.
//

import SwiftUI
import SwiftPokeAPI

extension Name: Identifiable {
    public var id: String {
        "\(name)"
    }
}

struct ContentView: View {
    @State private var berry: Berry?
    var body: some View {
        Group {
            if let berry {
                VStack {
                    Text("Hello, world!")
                    Text("Berry: \(berry.name)")
                    Text("Berry id: \(berry.id)")
                    Text("Berry growth time: \(berry.growthTime)")
                    Text("Berry growth time: \(berry.growthTime)")
                    Text("Berry item url: \(berry.item.url)")
                }
                .padding()
            } else {
                Text("no language name set")
            }
        }
        .task {
            do {
                berry = try await Berry("cheri")
            } catch {
                print("\(error)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
