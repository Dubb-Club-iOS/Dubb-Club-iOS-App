//
//  LoginUIView.swift
//  DubbClubiOS
//
//  Created by Batuhan Hakan on 3/31/21.
//

import SwiftUI

struct LoginUIView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showSignUp = false
    
    var body: some View {
        NavigationView {
            ZStack() {
                Color(.black).ignoresSafeArea()
                VStack() {
                    Image("DubbClub Logo Black").resizable().scaledToFit().frame(width: 100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center).padding()
                    
                    Text("Login")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding()
                    Text("Welcome back!")
                        .foregroundColor(.gray)
                    Text("Sign In to continue")
                        .foregroundColor(.gray)
                        .padding(.bottom)
                    VStack(spacing: 0){
                        
                        TextField(" Email", text: self.$email)
                            .modifier(PlaceholderStyle(showPlaceHolder: email.isEmpty, placeholder: "Username or Email"))
                            .foregroundColor(.gray)
                            .frame(width: 400.0, height: 50.0)
                            .background(Color(.black))
                            .fixedSize(horizontal: true/*@END_MENU_TOKEN@*/, vertical: /*@START_MENU_TOKEN@*/true)
                        
                        
                        Divider().background(Color.gray).frame(width: 400)
                        HStack(){
                            SecureField(" Password", text: self.$password)
                                .modifier(PlaceholderStyle(showPlaceHolder: password.isEmpty, placeholder: "Password"))
                                .foregroundColor(.gray)
                                .frame(width: 250.0, height: 50.0)
                                .background(Color(.black))
                                .fixedSize(horizontal: true/*@END_MENU_TOKEN@*/, vertical: /*@START_MENU_TOKEN@*/true)
                            Button(action: {}, label: {
                                Text("Forgot Password?")
                                    .font(.headline)
                                    .fontWeight(.regular)
                                    .foregroundColor(Color.blue)
                                    .padding(.trailing, 10)
                                
                                
                                
                                
                                
                            })
                        }
                        Divider().background(Color.gray).frame(width: 400, height: 0, alignment: .center)
                    }
                    
                    
                    Button(action: {}, label: {
                        Text("Sign In")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50, alignment: .center)
                            .background(Color.blue)
                            .cornerRadius(12.0)
                            .padding(.top, 200.0)
                            .onTapGesture(perform: {
                                showSignUp = true
                            })
                        
                        
                    }).padding(.bottom, 10.0)
                    
                    
                    HStack(spacing: 4){
                        Text("Don't have an account?")
                            .foregroundColor(.gray)
                        NavigationLink(
                            destination: RegisterUIView(),
                            label: {
                                Text("Sign Up")
                            })
                    }
                }
            }
        }
    }
}

struct LoginUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoginUIView()
    }
}
public struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                    .padding(.horizontal, 5)
            }
            content
                .foregroundColor(Color.white)
                .padding(5.0)
        }
    }
}
