//
//  File.swift
//  
//
//  Created by wanglei on 2020/7/12.
//

import Vapor

struct GroupController: RouteCollection {
    public func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("group")
        group.post("create", use: createGroup)
    }
}

func createGroup(request:Request) throws -> EventLoopFuture<Group>{
    logger.info("Group Create Route")
    let groupCreate = try request.content.decode(GroupCreate.self)
    logger.info("Content:\(groupCreate)")
    
    //create group
    let group = Group(name: groupCreate.name,avatar: groupCreate.avatar, type: groupCreate.type)
    let result = group.create(on: request.db).map({group})
    
    //create group user rel
    let groupId = group.id
    for tmpUser in groupCreate.userSet {
        let owner = tmpUser.uuidString == groupCreate.ownerUid.uuidString
        let groupUserRel = GroupUserRel(userId: tmpUser, groupId: groupId!, owner:owner)
        let _ = groupUserRel.create(on: request.db)
    }
    
    return result
}
