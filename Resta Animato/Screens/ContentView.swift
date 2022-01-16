//
//  ContentView.swift
//  Resta Animato
//
//  Created by Ameer Hamza on 02/01/2022.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var isOnBoardingViewActive: Bool = false
    
    var body: some View {
        if isOnBoardingViewActive {
            OnBoardingView()
        } else {
            HomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
