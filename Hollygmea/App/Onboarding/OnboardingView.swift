//
//  OnboardingView.swift
//  Training
//

import SwiftUI

struct OnboardingView: View {
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    @State private var isLaunchLoading: Bool = true
    @State private var currentStep: OnboardingStep = .plan
    @State private var pushMain: Bool = false
    
    @State private var dotsCount: Int = 1
    
    var dots: String {
        var dotsString = ""
        for _ in 0..<dotsCount {
            dotsString.append(".")
        }
        return dotsString
    }
    
    var body: some View {
        ZStack {
            if isLaunchLoading {
                launchView
            } else {
                onboardingView
            }
        }
        .adaptdievas()
        .onAppear() {
            print("siape")
        }
    }
    
    var onboardingView: some View {
        TabView(selection: $currentStep) {
            ForEach(OnboardingStep.allCases, id: \.self) { step in
                VStack {
                    Text(step.title.uppercased())
                        .font(.montserrat(32.flexible(), weight: .black))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 40)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.default, value: currentStep)
        .background {
            Image(currentStep.backgroundImage)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea()
                .animation(.easeInOut, value: currentStep)
                .transition(.opacity)
        }
        .overlay(alignment: .bottom) {
            GreenButton(title: currentStep.buttonTitle.uppercased(), size: .large) {
                tapNextButton()
            }
            .padding([.horizontal, .bottom], 32)
        }
        .ignoresSafeArea()
        .navigationDestination(isPresented: $pushMain) {
            TabBarView()
        }
    }
    
    var launchView: some View {
        VStack {
            Text("Wait, please".uppercased())
                .font(.montserrat(24.flexible(), weight: .bold))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Text("Loading\(dots)".uppercased())
                .font(.montserrat(22.flexible(), weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 132, height: 70, alignment: .leading)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(LinearGradient.horizontalGray)
                }
                .onReceive(timer) { value in
                    if dotsCount == 3 {
                        dotsCount = 1
                    } else {
                        dotsCount += 1
                    }
                }
        }
        .frame(maxWidth: .infinity)
        .padding([.horizontal, .bottom], 32)
        .padding(.top, 90)
        .background {
            Image(.launchBackground)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea()
                .animation(.easeInOut, value: currentStep)
                .transition(.opacity)
        }
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 4...6)) {
                withAnimation(.easeInOut) {
                    isLaunchLoading = false
                }
            }
        }
    }
    
    func tapNextButton() {
        vibrate()
        switch currentStep {
        case .plan:
            currentStep = .track
        case .track:
            currentStep = .challenge
        case .challenge:
            UserDefaults.standard.set(true, forKey: "isSecondLaunch")
            pushMain = true
        }
    }
}

#Preview {
    OnboardingView()
}
