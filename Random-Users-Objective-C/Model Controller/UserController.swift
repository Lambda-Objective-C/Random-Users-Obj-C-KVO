//
//  UserController.swift
//  Random-Users-Objective-C
//
//  Created by Seschwan on 11/13/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

import Foundation

@objc (CESUserController)
class UserController: NSObject {
    
    @objc (CESUsersArray)
    var usersArray = [CESUser]()
    
    private let baseURL = URL(string: "https://randomuser.me/api/?format=json&inc=name,email,phone,picture&results=100")!
    
    @objc (sharedController) static let shared = UserController()
    
    @objc (fetchuser:)
    func fetchUsers(completion: @escaping ([CESUser]?, Error?) -> Void) {
        URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("Response Code: \(response.statusCode)")
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    NSLog("Error fetching data: \(error)")
                    completion(nil, error)
                    return
                }
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    NSLog("Error with the data in dataTask in fetchUsers")
                    completion(nil, error)
                }
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    let error = NSError(domain: "UserController", code: 0, userInfo: nil)
                    
                    throw error
                }
                
                guard let userDictionaries = dictionary["results"] as? [[String : Any]] else {
                    let error = NSError(domain: "UserController", code: 0, userInfo: nil)
                    
                    throw error
                }
                
                for userDictionary in userDictionaries {
                    let user = CESUser(dictionary: userDictionary)
                    self.usersArray.append(user!)
                }
                
                DispatchQueue.main.async {
                    completion(self.usersArray, nil)
                    //print(self.usersArray)
                }
                
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
