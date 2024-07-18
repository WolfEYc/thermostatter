//
//  LoginView.swift
//  thermostatter
//
//  Created by wolfey on 7/4/24.
//

import SwiftUI


struct LoginView: View {
    @State var username = ""
    @State var password = ""
    @State private var showAlert: Bool = false
    @Binding var user: User?
    
    private func handleSubmit() {
        Task {
            let submitted_username = username
            do {
                let res = try await authenticate(username: submitted_username, password: password)
                user = User(username: submitted_username, access_token: res.access_token)
            } catch {
                showAlert = true
            }
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Login").font(.title).fontWeight(.bold)
                Form {
                    TextField("Username", text: $username)
                        .textContentType(.username)
                        .textInputAutocapitalization(.never)
                    
                    SecureField("Password", text: $password)
                        .textContentType(.password)
                    
                    Button(action: handleSubmit) {
                        Text("Submit")
                    }
                }.scrollDisabled(true)
                NavigationLink(destination: RegisterView(user: $user)) {
                    Text("Need an account?")
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Login Failed"), dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview {
    @State var user: User?
    return LoginView(user: $user)
}
