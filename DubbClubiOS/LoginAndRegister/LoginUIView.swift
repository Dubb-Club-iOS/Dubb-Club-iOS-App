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
    @State var isLoggedIn = false
    @State private var showErrorMessage = false
    @State private var errorMessage = ""
    
    // TODO: use elsewhere
    func getFavoriteTeams() {
        let url = URL(string: "https://api.dubb.club/api/user/favoriteteamlist")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.addValue(UserDefaults.standard.object(forKey: "JWT") as! String, forHTTPHeaderField: "x-access-token")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 404 {
                    print("Invalid login!")
                    return
                } else if httpResponse.statusCode == 500 {
                    print("Database failure!")
                    return
                }
            }
            
            
            if let error = error {
                // Handle HTTP request error
                print("Error: \(error.localizedDescription)")
            } else if let data = data {
                // Handle HTTP request response
                let ret: FavoriteTeamsParent = try! JSONDecoder().decode(FavoriteTeamsParent.self, from: data)
                print("Fav Teams: ")
                for team in ret.favoriteTeams.NBA {
                    print(team)
                }
            } else {
                print("Unexpected error!")
            }
        }.resume()
    }
    
    func login() {
        
        let token = UserDefaults.standard.object(forKey: "JWT") as? String
        if token != nil {
            getFavoriteTeams()
            return
        }
        
        let loginInfo = LoginInfo(username: self.email, password: self.password)
        guard let loginEnc = try? JSONEncoder().encode(loginInfo) else {
            print("Failed to encode login information")
            return
        }
        
        let url = URL(string: "https://api.dubb.club/api/auth/login")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = loginEnc
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                
                print(httpResponse.statusCode)
                
                if httpResponse.statusCode == 500 {
                    self.errorMessage = "Database failure"
                    self.showErrorMessage = true
                    return
                } else if httpResponse.statusCode != 200 {
                    self.errorMessage = "Invalid login credentials"
                    self.showErrorMessage = true
                    return
                }
            }
            
            
            if let error = error {
                // Handle HTTP request error
                print("Error: \(error.localizedDescription)")
            } else if let data = data {
                // Handle HTTP request response
                let loginReturn: LoginReturn = try! JSONDecoder().decode(LoginReturn.self, from: data)
                UserDefaults.standard.set(loginReturn.accessToken, forKey:"JWT")
                self.isLoggedIn = true
                self.showErrorMessage = false
            } else {
                print("Unexpected error!")
            }
        }.resume()
    }
    
    var body: some View {
        NavigationView {
            ZStack() {
                ColorManager.backgroundGray.ignoresSafeArea()
                GeometryReader { geometry in
                    VStack() {
                        Image("DubbClub Logo").resizable().scaledToFill().frame(width: geometry.size.width / 3, height: geometry.size.width / 3)
                        
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
                            
                            TextField("", text: self.$email)
                                .modifier(PlaceholderStyle(showPlaceHolder: email.isEmpty, placeholder: "Username or Email"))
                                .foregroundColor(.gray).padding()
                            
                            
                            
                            Divider().background(Color.gray)
                            HStack(){
                                SecureField("", text: self.$password)
                                    .modifier(PlaceholderStyle(showPlaceHolder: password.isEmpty, placeholder: "Password"))
                                    .foregroundColor(.gray)
                                    .padding()
                                
                                Button(action: {}, label: {
                                    Text("Forgot Password?")
                                        .font(.headline)
                                        .foregroundColor(Color.blue)
                                        .padding()
                                })
                            }
                            Divider().background(Color.gray)
                        }
                        
                        Spacer()
                        
                        Text(self.errorMessage).padding(.top, 20).foregroundColor(Color.red).opacity(self.showErrorMessage ? 1 : 0).animation(.easeInOut, value: self.showErrorMessage)
                        Spacer()

                        
                        NavigationLink(destination: ProfileTab(), isActive: $isLoggedIn) {
                            Button(action: {}, label: {
                                Text("Sign In")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                                    .frame(width: geometry.size.width / 3, height: geometry.size.width / 8, alignment: .center)
                                    .background(Color.blue)
                                    .cornerRadius(12.0)
                                    .onTapGesture(perform: {
                                        showSignUp = true
                                        self.login()
                                    })
                                    .padding()
                            })
                        }
                        
                        
                        
                        HStack(spacing: 4){
                            Text("Don't have an account?")
                                .foregroundColor(.gray)
                            NavigationLink(
                                destination: RegisterUIView(),
                                label: {
                                    Text("Sign Up")
                                })
                        }.padding(.bottom, geometry.size.height / 10)
                    }
                }
            }
        }.navigationBarHidden(true)
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
