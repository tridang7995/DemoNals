//
//  DataModel.swift
//  UIKitDemoNals
//
//  Created by Tri Dang on 28/12/2021.
//

import Foundation

struct DataModel: Codable {
    var login: String
    var id: Int
    var nodeId: String
    var avatarUrl: String
    var gravatarId: String
    var url: String
    var htmlUrl: String
    var followersUrl: String
    var followingUrl: String
    var gistsUrl: String
    var starredUrl: String
    var subscriptionsUrl: String
    var organizationsUrl: String
    var reposUrl: String
    var eventsUrl: String
    var receivedEventsUrl: String
    var type: String
    var siteAdmin: Bool
}

struct ArraySaved: Codable {
    var datas: [DataModel] = []
}
