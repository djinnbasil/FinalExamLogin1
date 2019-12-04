//
//  User.swift
//  FinalExamLogin
//
//  Created by macbook on 2019-12-04.
//  Copyright © 2019 macbook. All rights reserved.
//

import Foundation



class User {
    
    var id: Int
    var username: String?
    var password: String?
    var email: String?
    var bio: String?
    
    init(id: Int, username: String?,email: String?,password: String?,bio: String?){
        self.id = id
        self.username = username
        self.email = email
        self.password = password
        self.bio = bio
    }
}
