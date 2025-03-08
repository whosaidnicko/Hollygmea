//
//  OnboardingStep.swift
//  HollywoodSports
//

import SwiftUI

enum OnboardingStep: Int, CaseIterable {
    case plan
    case track
    case challenge
    
    var title: String {
        switch self {
        case .plan:
            return "Plan your workouts every day"
        case .track:
            return "Keep track of the results and achieve more"
        case .challenge:
            return "Challenge yourself and win"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .plan:
            return "Continue"
        case .track:
            return "Next"
        case .challenge:
            return "Let's go"
        }
    }
    
    var backgroundImage: ImageResource {
        switch self {
        case .plan:
            return .onboardingPlan
        case .track:
            return .onboardingTrack
        case .challenge:
            return .onboardingChallenge
        }
    }
}
