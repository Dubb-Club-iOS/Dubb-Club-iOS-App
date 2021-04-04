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
    var body: some View {
        ZStack() {
            Color(.black).ignoresSafeArea()
            VStack() {
                Image("DubbClub Logo Black").resizable().scaledToFit().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding()
            
                Text("Login")
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
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
                        .fixedSize(horizontal: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    
                    
                    Divider().background(Color.gray).frame(width: 400)
                    HStack(){
                        SecureField(" Password", text: self.$password)
                            .modifier(PlaceholderStyle(showPlaceHolder: password.isEmpty, placeholder: "Password"))
                            .foregroundColor(.gray)
                            .frame(width: 250.0, height: 50.0)
                            .background(Color(.black))
                            .fixedSize(horizontal: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Forgot Password?")
                                .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                                .fontWeight(.regular)
                                .foregroundColor(Color.blue)
                                .padding(.trailing, 10)
                                
                            
                            
                            
                            
                        })
                    }
                    Divider().background(Color.gray).frame(width: 400, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Sign In")
                        .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                        .fontWeight(.regular)
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.blue)
                        .cornerRadius(12.0)
                        .padding(.top, 200.0)
                    
                    
                }).padding(.bottom, 10.0)
                
                
                HStack(spacing: 4){
                    Text("Don't have an account?")
                        .foregroundColor(.gray)
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Sign Up")
                    })
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
