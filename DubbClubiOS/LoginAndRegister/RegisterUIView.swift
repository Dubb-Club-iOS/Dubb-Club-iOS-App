//
//  RegisterUIView.swift
//  DubbClubiOS
//
//  Created by Batuhan Hakan on 3/31/21.
//

import SwiftUI

struct RegisterUIView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var registrationSuccessful = false
    @State private var showRegistrationError = false
    @State private var errorMessage = ""
    
    func signup() {
        
        let signUpInfo = RegistrationBody(email: self.email, username: self.username, password: self.password)
        guard let signUpEnc = try? JSONEncoder().encode(signUpInfo) else {
            print("Failed to encode login information")
            return
        }
        
        let url = URL(string: "https://api.dubb.club/api/auth/signup")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = signUpEnc
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    self.errorMessage = "Invalid registration"
                    self.showRegistrationError = true
                    return
                }
            }
            
            
            if let error = error {
                // Handle HTTP request error
                print("Error: \(error.localizedDescription)")
            } else if let data = data {
                // Handle HTTP request response
                self.registrationSuccessful = true
            } else {
                print("Unexpected error!")
            }
        }.resume()
    }
    
    var body: some View {
//        NavigationView {
            ZStack() {
                ColorManager.backgroundGray.ignoresSafeArea()
                GeometryReader { geometry in
                    VStack() {
                        
                        Image("DubbClub Logo PNG").resizable().scaledToFill().frame(width: geometry.size.width / 3, height: geometry.size.width / 3)
                            .padding(.top, geometry.size.height * -0.1)
                        Text("Create an account")
                            .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .padding()
                        Text("We’re glad to see you’re joining the Dubb Club!")
                            .foregroundColor(.gray)
                            .font(.callout)
                        Text("Fill out the information below to create an account.")
                            .foregroundColor(.gray)
                            .font(.callout)
                            .padding(.bottom, geometry.size.height / 25)
                        
                        VStack(spacing: 0){
                            
                            TextField("", text: self.$username)
                                .modifier(PlaceholderStyle(showPlaceHolder: username.isEmpty, placeholder: "Username"))
                                .foregroundColor(.gray)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .padding()
                            
                            Divider().background(Color.gray)
                            TextField("", text: self.$email)
                                .modifier(PlaceholderStyle(showPlaceHolder: email.isEmpty, placeholder: "Email"))
                                .foregroundColor(.gray)
                                .autocapitalization(.none)
                                .padding()
                            
                            
                            Divider().background(Color.gray)
                            SecureField("", text: self.$password)
                                .modifier(PlaceholderStyle(showPlaceHolder: password.isEmpty, placeholder: "Password"))
                                .foregroundColor(.gray)
                                .padding()
                            
                            
                            Divider().background(Color.gray)
                        }
                        
                        
                        //                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        //                    Text("Sign Up")
                        //                        .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                        //                        .fontWeight(.regular)
                        //                        .foregroundColor(Color.white)
                        //                        .frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        //                        .background(Color.blue)
                        //                        .cornerRadius(12.0)
                        //                        .padding(.top, 200.0)
                        //
                        //
                        //                }).padding(.bottom, 10.0)
                        
                        Text(self.errorMessage).padding(.top, 20).foregroundColor(Color.red).opacity(self.showRegistrationError ? 1 : 0).animation(.easeInOut, value: showRegistrationError)
                        Spacer()
                        
                        NavigationLink(destination: LoginUIView(), isActive: $registrationSuccessful) {
                            Button(action: {}, label: {
                                Text("Sign Up")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .frame(width: geometry.size.width / 3, height: geometry.size.width / 8, alignment: .center)
                                    .foregroundColor(Color.white)
                                    .background(Color.blue)
                                    .cornerRadius(12.0)
                                    .onTapGesture(perform: {
                                        self.signup()
                                    })
                            })
                        }
                        Spacer()
//                        HStack(spacing: 4){
//                            Text("Already joined?")
//                                .foregroundColor(.gray)
//                            NavigationLink(
//                                destination: LoginUIView(),
//                                label: {
//                                    Text("Sign In")
//                                })
//                        }.padding(.bottom, geometry.size.height / 10)
                        
                    }
                }
            }
        }
//        .navigationBarHidden(true)
//        .navigationBarBackButtonHidden(true)
//    }
}

struct RegisterUIView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterUIView()
    }
}
