//
//  File.swift
//
//
//  Created by wanglei on 2020/7/12.
//
import Vapor

struct GroupCreate: Content {
    var name: String
    var avatar: String?
    var type: Int
    var ownerUid: UUID
    var userSet: Set<UUID>

    init(name: String, avatar: String? = nil, type: Int, ownerUid: UUID, userSet: Set<UUID>) {
        self.name = name
        self.avatar = avatar
        self.type = type
        self.ownerUid = ownerUid
        self.userSet = userSet
    }
}
