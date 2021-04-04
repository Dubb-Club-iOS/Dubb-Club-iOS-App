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
    var body: some View {
        ZStack() {
            Color(.black).ignoresSafeArea()
            VStack() {
                Image("DubbClub Logo Black").resizable().scaledToFit().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding()
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
                    .padding(.bottom)
                
                VStack(spacing: 0){
                    
                    TextField("Username", text: self.$username)
                        .modifier(PlaceholderStyle(showPlaceHolder: username.isEmpty, placeholder: "Username"))
                        .foregroundColor(.gray)
                        .frame(width: 400.0, height: 50.0)
                        .background(Color(.black))
                        .fixedSize(horizontal: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    Divider().background(Color.gray).frame(width: 400)
                    TextField(" Email", text: self.$email)
                        .modifier(PlaceholderStyle(showPlaceHolder: email.isEmpty, placeholder: "Email"))
                        .foregroundColor(.gray)
                        .frame(width: 400.0, height: 50.0)
                        .background(Color(.black))
                        .fixedSize(horizontal: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    
                    
                    Divider().background(Color.gray).frame(width: 400)
                        SecureField(" Password", text: self.$password)
                            .modifier(PlaceholderStyle(showPlaceHolder: password.isEmpty, placeholder: "Password"))
                            .foregroundColor(.gray)
                            .frame(width: 400.0, height: 50.0)
                            .background(Color(.black))
                            .fixedSize(horizontal: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            .padding(.leading, 0)
                            

                    Divider().background(Color.gray).frame(width: 400, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Sign Up")
                        .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                        .fontWeight(.regular)
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.blue)
                        .cornerRadius(12.0)
                        .padding(.top, 200.0)
                    
                    
                }).padding(.bottom, 10.0)
                
            }
        }
    }
}

struct RegisterUIView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterUIView()
    }
}
