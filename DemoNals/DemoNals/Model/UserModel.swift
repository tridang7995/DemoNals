//
//  UserModel.swift
//  DemoNals
//
//  Created by Tri Dang on 30/12/2021.
//

import Foundation

struct UserModel: Codable {
    var login: String
    var id: Int
    var name: String
    var avatarUrl: String
    var publicRepos: Int
    var publicGists: Int
    var followers: Int
    var following: Int
    var location: String
}
