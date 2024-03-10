//
//  ContentView.swift
//  RepurposeVids
//
//  Created by George Quentin on 10/03/2024.
//

import SwiftUI

struct ContentView: View {
    @State var isPresented = false
    
    var body: some View {
        VStack {
            Button("Start Facebook Login") {
                isPresented = true
            }
            .sheet(isPresented: $isPresented) {
                FaceBookLoginView()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
