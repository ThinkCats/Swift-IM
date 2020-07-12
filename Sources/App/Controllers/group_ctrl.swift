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
    let group = try request.content.decode(Group.self)
    return group.create(on: request.db).map({group})
}
