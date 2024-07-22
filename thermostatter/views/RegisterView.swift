//
//  RegisterView.swift
//  thermostatter
//
//  Created by wolfey on 7/17/24.
//

import SwiftUI



struct RegisterView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var show_alert: Bool = false
    @Binding var user: User?
    
    @State private var is_username_valid = false
    @State private var is_email_valid = false
    @State private var is_password_valid = false
    
    @State var error_message = ""
    
    private func is_form_valid() -> Bool {
        return is_username_valid && is_email_valid && is_password_valid
    }
    
    private func handleSubmit() {
        if !is_form_valid() {
            error_message = "Form requirements not met"
            show_alert = true
            return
        }
        let submitted_username = username
        Task {
            do {
                let res = try await register(email: email, username: submitted_username, password: password)
                user = User(username: submitted_username, access_token: res.access_token)
            } catch {
                error_message = "Registration Failed"
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
        .alert("Registration Failed", isPresented: $show_alert) {
            Text("OK")
        }
    }
}

#Preview {
    @State var user: User?
    return RegisterView(user: $user)
}
