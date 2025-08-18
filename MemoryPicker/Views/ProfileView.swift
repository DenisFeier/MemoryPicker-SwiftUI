//
//  ProfileView.swift
//  MemoryPicker
//
//  Created by Denis Feier on 11.08.2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: AuthVM
    
    var body: some View {
        VStack {
            Spacer()
            
            Button(role: .destructive) {
                withAnimation(.easeInOut) {
                    appState.logout()
                }
            } label: {
                Text("Log Out")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("Profile")
    }
}

struct ProfileScreen: View {
    var body: some View {
        NavigationStack {
            ProfileView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    LoginBackground()
                )
                .navigationBarHidden(true)
        }
    }
}

#Preview {
    ProfileScreen()
}
