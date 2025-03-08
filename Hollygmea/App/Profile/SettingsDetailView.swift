//
//  SettingsDetailView.swift
//  Hollygmea
//

import SwiftUI
import StoreKit

struct SettingsDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.requestReview) var requestReview
    let privacyLink: URL = URL(string: "https://www.privacypolicies.com/live/306c62e2-f3ed-40f2-adb8-5936c71913c7")!
    let appLink: URL = URL(string: "https://www.apple.com")!
    
    @ObservedObject var vm: ProfileViewModel
    
    var body: some View {
        VStack(spacing: 4.flexible()) {
            Link(destination: privacyLink) {
                getSettingLabel(for: "PRIVACY POLICY")
            }
            .simultaneousGesture(TapGesture().onEnded({ _ in
                vibrate()
            }))
            
            Link(destination: privacyLink) {
                getSettingLabel(for: "TERMS OF USE")
            }
            .simultaneousGesture(TapGesture().onEnded({ _ in
                vibrate()
            }))
            
            Button {
                vibrate()
                requestReview()
            } label: {
                getSettingLabel(for: "RATE THIS APP")
            }

            ShareLink(item: appLink) {
                getSettingLabel(for: "SHARE THIS APP")
            }
            .simultaneousGesture(TapGesture().onEnded({ _ in
                vibrate()
            }))
            
            Spacer()
            
            Button {
                vibrate()
                vm.clearUserData()
                dismiss()
            } label: {
                Text("CLEAR ALL DATA")
                    .font(.montserrat(16.flexible(), weight: .bold))
                    .foregroundStyle(.textRed)
                    .frame(height: 60.flexible())
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 16.flexible(), style: .continuous)
                            .fill(.darkPurple)
                    }
            }

        }
        .padding(.all, 16.flexible())
        .navigationContent("SETTINGS", showBackButton: true)
        .setDefaultBackground()
    }
    
    func getSettingLabel(for text: String) -> some View {
        Text(text)
            .font(.montserrat(16.flexible(), weight: .bold))
            .foregroundStyle(.white)
            .frame(height: 60.flexible())
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 16.flexible(), style: .continuous)
                    .fill(.darkPurple)
            }
    }
}
