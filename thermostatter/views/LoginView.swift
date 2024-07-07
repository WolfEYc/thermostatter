//
//  LoginView.swift
//  thermostatter
//
//  Created by wolfey on 7/4/24.
//

import SwiftUI


struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            if colorScheme == .dark {
                Color( red: 0.15, green: 0.15, blue: 0.15)
            } else {
                Color(.white)
            }
            
            VStack{
                Text("Thermostatter\n wants you to log in").multilineTextAlignment(.center).bold().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                AppleSignInComponent().padding()

                
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LoginView()
}
