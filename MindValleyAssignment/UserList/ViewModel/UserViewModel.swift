//
//  UserViewModel.swift
//  MindValleyAssignment
//
//  Created by Soham Ray on 18/05/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation


class UserViewModel {
    let userCliet: UserListClient = UserListClient()
    var users : [UserListReponseElement] = []
    var failureMessage: String = ""
    init() {
        
    }
    
    func getUserData(completion: @escaping ((Bool) -> Void)) {
        userCliet.getUserListResponse(from: .userList) { (result) in
            switch result {
            case .success(let data):
                print(data)
                self.users = data.userList
                completion(true)
            case .failure(let error):
                self.failureMessage = error.localizedDescription
                completion(false)
            }
        }
    }
    
}
