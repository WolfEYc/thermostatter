//
//  LoginView.swift
//  thermostatter
//
//  Created by wolfey on 7/4/24.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .foregroundStyle(Color.pink)
                    .rotationEffect(Angle(degrees: 15))
                    
                VStack {
                    Text("Thermostatter")
                        .font(.system(size: 50))
                        .foregroundStyle(Color.white)
                        .bold()
                }.padding(.top, 30)
            }.frame(width: UIWindow.current.screen.bounds.width * 3, height: 300).offset(y: -100)
            Spacer()
        }
    }
}

#Preview {
    LoginView()
}
