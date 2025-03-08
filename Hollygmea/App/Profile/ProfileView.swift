//
//  ProfileView.swift
//  Hollygmea
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    
    @ObservedObject var vm: ProfileViewModel
    
    var body: some View {
        GeometryReader { _ in
            VStack {
                VStack(spacing: 0) {
                    HStack(spacing: 24.flexible()) {
                        VStack {
                            if let icon = vm.icon {
                                Image(uiImage: icon)
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fill)
                            } else {
                                Image(systemName: "person.crop.square")
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                        .frame(width: 100.flexible(), height: 100.flexible())
                        .clipShape(.rect(cornerRadius: 10, style: .continuous))
                        
                        PhotosPicker(selection: $vm.pickerItem, matching: .images) {
                            BorderedLabel(title: "UPLOAD PHOTO")
                        }
                        .simultaneousGesture(TapGesture().onEnded { _ in
                            vibrate()
                            UIApplication.shared.endEditing()
                        })
                        .onChange(of: vm.pickerItem) { item in
                            guard let item else { return }
                            Task {
                                if let data = try? await item.loadTransferable(type: Data.self) {
                                    vm.icon = UIImage(data: data)
                                } else {
                                    print("Failed")
                                }
                                vm.pickerItem = nil
                            }
                        }
                    }
                    
                    VStack(spacing: 8.flexible()) {
                        BrandTextField(placeholder: "NAME", text: $vm.name)
                        
                        DatePickerView(date: $vm.dateOfBirth) { date in
                            Text(date.formatted(.dateTime.month(.twoDigits).day(.twoDigits).year()))
                                .font(.montserrat(15.flexible(), weight: .bold))
                                .foregroundStyle(.white)
                                .frame(height: 52.flexible())
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 16.flexible())
                                .background {
                                    RoundedRectangle(cornerRadius: 8.flexible(), style: .continuous)
                                        .fill(.lightPurple)
                                }
                        }
                        .simultaneousGesture(TapGesture().onEnded { _ in
                            UIApplication.shared.endEditing()
                        })
                    }
                    .padding(.top, 24.flexible())
                    
                    Toggle(isOn: $vm.enableNotifications) {
                        Text("ENABLE NOTIFICATIONS")
                            .font(.montserrat(15.flexible(), weight: .bold))
                            .foregroundStyle(.white)
                    }
                    .toggleStyle(BrandToggleStyle())
                    .simultaneousGesture(TapGesture().onEnded { _ in
                        UIApplication.shared.endEditing()
                    })
                    .padding(.top, 24.flexible())
                    
                    VStack {
                        if vm.hasCanges {
                            GreenButton(title: "SAVE CHANGES", size: .medium) {
                                UIApplication.shared.endEditing()
                                vm.saveUserData()
                            }
                        }
                    }
                    .animation(.default, value: vm.hasCanges)
                    .padding(.top, 24.flexible())
                }
                .padding(.all, 16.flexible())
                .background {
                    RoundedRectangle(cornerRadius: 16.flexible(), style: .continuous)
                        .fill(.darkPurple)
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: SettingsDetailView(vm: vm)) {
                        BorderedLabel(title: "SETTINGS")
                            .frame(width: 125.flexible())
                    }
                    .simultaneousGesture(TapGesture().onEnded({ _ in
                        vibrate()
                    }))
                }
            }
            .padding([.bottom, .horizontal], 16.flexible())
            .padding(.top, 24.flexible())
            .setDefaultBackground()
            .dismissKeyboardOnTap()
        }
    }
}
