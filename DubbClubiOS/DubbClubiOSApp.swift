//
//  DubbClubiOSApp.swift
//  DubbClubiOS
//
//  Created by Chris Koehne on 3/22/21.
//

import SwiftUI

@main
struct DubbClubiOSApp: App {
    
    init() {
        refreshToken()
    }
    
    func refreshToken() {
        
        let token = UserDefaults.standard.object(forKey: "JWT") as? String
        if token == nil {
            print("No user logged in!")
            return
        }
        
        let url = URL(string: "https://api.dubb.club/api/auth/refresh")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.addValue(UserDefaults.standard.object(forKey: "JWT") as! String, forHTTPHeaderField: "x-access-token")
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode != 200 {
                    print("User token expired!")
                    UserDefaults.standard.set(nil, forKey:"JWT")
                    UserDefaults.standard.set(nil, forKey:"Username")
                    return
                }
            }
            
            if let error = error {
                // Handle HTTP request error
                print("Error: \(error.localizedDescription)")
            } else if let data = data {
                print("Successful refresh of JWT!")
                let refreshReturn: RefreshReturn = try! JSONDecoder().decode(RefreshReturn.self, from: data)
                UserDefaults.standard.set(refreshReturn.accessToken, forKey:"JWT")
            } else {
                print("Unexpected error!")
            }
        }.resume()
    }
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn() {
                HomeStream()
            } else {
               LoginUIView()
            }
   //         HomeStream()
        }
    }
    
    func isLoggedIn() -> Bool {
        let token = UserDefaults.standard.object(forKey: "JWT") as? String
        if token == nil {
            return false

        }
        return true
    }
}
