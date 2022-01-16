//
//  OnBoardingView.swift
//  Resta Animato
//
//  Created by Ameer Hamza on 15/01/2022.
//

import SwiftUI

struct OnBoardingView: View {
    @AppStorage("onboarding") var isOnBoardingViewActive: Bool = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffSet: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var centerImageOffSet: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle: String = "Share."
    
    var body: some View {
        
        ZStack {
            Color("ColorBlue").ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {
                // MARK: HEADER
                
                Spacer()
                
                VStack(spacing: 0) {
                    Text(textTitle).font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    
                    Text("""
                        It's not how much we give but
                        how much love we put into giving
                        """)
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                } //: HEADER
                .opacity(isAnimating ? 1: 0)
                .offset(y: isAnimating ? 0: -40)
                .animation(.easeOut, value: isAnimating)
                
                // MARK: CENTER
                
                Spacer()
                
                ZStack {
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x: centerImageOffSet.width * -1)
                        .blur(radius: abs(centerImageOffSet.width / 5))
                        .animation(.easeOut(duration: 1), value: centerImageOffSet)
                    
                    Image("character-1")
                    .resizable()
                    .scaledToFit()
                    .opacity(isAnimating ? 1: 0)
                    .offset(x: centerImageOffSet.width * 1.2, y: 0)
                    .rotationEffect(.degrees(Double(centerImageOffSet.width / 20)))
                    .animation(.easeOut, value: isAnimating)
                    .gesture(
                        DragGesture().onChanged({ gesture in
                            if abs(centerImageOffSet.width) <= 80 {
                                centerImageOffSet = gesture.translation
                                withAnimation(.linear(duration: 0.25)) {
                                    textTitle = "Give."
                                    indicatorOpacity = 0
                                }
                                
                            }
                        })
                            .onEnded{ _ in
                                    centerImageOffSet = .zero
                                withAnimation(.linear(duration: 0.25)) {
                                    textTitle = "Share."
                                    indicatorOpacity = 1
                                }
                            }
                    ) // :DRAG-GESTURE
                    .animation(.easeOut(duration: 0.5), value: centerImageOffSet)
                    
                } // :CENTER
                .overlay(alignment: .bottom) {
                    
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(isAnimating ? indicatorOpacity : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                    
                }
                
                // MARK: FOOTER
                
                    ZStack{
                        
                        Capsule()
                            .fill(Color.white.opacity(0.2))
                        
                        Capsule()
                            .fill(Color.white.opacity(0.2)).padding(8)
                        
                        Text("Get Started")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .offset(x: 20)
                        
                        HStack{
                            Capsule()
                                .fill(Color("ColorRed"))
                                .frame(width: buttonOffSet + 80)
                            
                            Spacer()
                        }
                        
                        HStack {
                            ZStack{
                                Capsule()
                                    .fill(Color("ColorRed"))
                                Capsule()
                                    .fill(Color.black.opacity(0.15))
                                    .padding(8)
                                Image(systemName: "chevron.right.2")
                                    .font(.system(size: 24, weight: .bold))
                            }.foregroundColor(.white)
                            .frame(width: 80, height: 80, alignment: .center)
                            .offset(x: buttonOffSet)
                            .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if gesture.translation.width > 0 && buttonOffSet <=
                                        buttonWidth - 80 {
                                        buttonOffSet = gesture.translation.width
                                    }
                                }
                                .onEnded{ _ in
                                    
                                withAnimation(Animation.easeOut(duration: 0.4)) {
                                    if buttonOffSet > buttonWidth / 2 {
                                        buttonOffSet = buttonWidth - 80
                                        playSound(sound: "chimeup", type: "mp3")
                                        isOnBoardingViewActive = false
                                    }
                                    else {
                                        buttonOffSet = 0
                                    }
                                }
                            }
                        )
                            
                        Spacer()

                    }//: HSTACK
                } //: FOOTER
                    .frame(width: buttonWidth, height: 80, alignment: .center)
                    .padding()
                    .opacity(isAnimating ? 1: 0)
                    .offset(y: isAnimating ? 0: 40)
                    .animation(.easeOut, value: isAnimating)
            
                
            } //: VSTACK
        } //: ZSTACK
        .onAppear{
            isAnimating = true
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
