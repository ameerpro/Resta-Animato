//
//  ContentView.swift
//  Resta Animato
//
//  Created by Ameer Hamza on 02/01/2022.
//

import SwiftUI

extension Image {
    func asyncImageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
    func placeholderImageModifier() -> some View {
        self
            .asyncImageModifier()
            .foregroundColor(.purple)
            .opacity(0.5)
            .frame(maxWidth: 128)
    }
}

struct ContentView: View {
    private let imageUrl = "https://credo.academy/credo-academy@3x.png"
    
    var body: some View {
        //MARK: - 1. BASIC
//        AsyncImage(url: URL(string: imageUrl))
        
        //MARK: - 2. SCALE
//        AsyncImage(url: URL(string: imageUrl), scale: 3.0)
        
        //MARK: - 3. PLACEHOLDER
//        AsyncImage(url: URL(string: imageUrl)) {
//            image in image.asyncImageModifier()
//
//        } placeholder: {
//            Image(systemName: "photo.circle.fill").placeholderImageModifier()
//        }
//        .padding(40)
        
        //MARK: - 4. PHASE
        AsyncImage(url: URL(string: imageUrl), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))) { phase in
            
            switch phase {
            case .success(let image):
                image.asyncImageModifier().transition(.scale)
            case .empty:
                ProgressView().transition(.slide)
//                Image(systemName: "photo.circle.fill").placeholderImageModifier()
            case .failure(_):
                Image(systemName: "ant.circle.fill").placeholderImageModifier().transition(.slide)
            @unknown default:
                ProgressView()
            }
        
        }.padding(40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
