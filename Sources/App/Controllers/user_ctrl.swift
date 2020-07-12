//
//  File.swift
//  
//
//  Created by wanglei on 2020/7/12.
//

import Vapor


struct UserController: RouteCollection {
    public func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("user")
        group.post("create", use: createUser)
        //group.post("online", use: )
    }
}

func createUser(request:Request) throws -> EventLoopFuture<ApiResult<User>>{
    logger.info("User Create Route")
    let user = try request.content.decode(User.self)
    return user.create(on: request.db).map({ ApiResult(success: true, data: user)})
}

