//
//  File.swift
//  
//
//  Created by wanglei on 2020/7/12.
//
import Vapor

struct ApiResult<T:Codable> :Content {
    var success:Bool
    var data:T
    var msg:String?

    
    init(success:Bool, data:T,msg:String?=nil) {
        self.success = success
        self.data = data
        self.msg = msg
    }
    
}
