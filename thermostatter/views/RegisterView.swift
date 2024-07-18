//
//  RegisterView.swift
//  thermostatter
//
//  Created by wolfey on 7/17/24.
//

import SwiftUI

struct RequirementLabel: View {
    let text: String
    let checked: Bool
    
    var body: some View {
        Label(
            title: {
                Text(text)
                    .font(.callout)
            },
            icon: {
                Image(systemName: "checkmark")
                    .imageScale(.medium)
            }
        )
        .foregroundStyle(checked ? Color.green : Color.gray)
        .transition(.opacity)
        .animation(.linear, value: checked)
    }
}

struct RegisterView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var show_alert: Bool = false
    @Binding var user: User?
    
    @State private var is_username_valid = false
    @State private var is_email_valid = false
    @State private var is_password_valid = false
    
    private func is_form_valid() -> Bool {
        return is_username_valid && is_email_valid && is_password_valid
    }
    
    private func handleSubmit() {
        Task {
            let submitted_username = username
            do {
                let res = try await authenticate(username: submitted_username, password: password)
                user = User(username: submitted_username, access_token: res.access_token)
            } catch {
                show_alert = true
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("Register").font(.title).fontWeight(.bold)
            Form {
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .onChange(of: email) {
                        is_email_valid = validate_email(email)
                    }
                
                TextField("Username", text: $username)
                    .textContentType(.username)
                    .textInputAutocapitalization(.never)
                    .onChange(of: username) {
                        is_username_valid = validate_username(username)
                    }
                
                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .onChange(of: password) {
                        is_password_valid = validate_password(password)
                    }
                
                Section("REQUIREMENTS") {
                    RequirementLabel(text: "Email must be in valid format", checked: is_email_valid)
                    RequirementLabel(text: "Username must be between 2-30 characters", checked: is_username_valid)
                    RequirementLabel(text: "Password must be between 8-16 characters", checked: is_password_valid)
                }
                
                Button(action: handleSubmit) {
                    Text("Submit")
                }
            }.scrollDisabled(true)
        }
        .alert(isPresented: $show_alert) {
            Alert(title: Text("Login Failed"), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    @State var user: User?
    return RegisterView(user: $user)
}
