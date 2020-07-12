//
//  File.swift
//  
//
//  Created by wanglei on 2020/7/12.
//
import Vapor

struct MessageController: RouteCollection {
    public func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("msg")
        group.post("create", use: createGroup)
    }
}
