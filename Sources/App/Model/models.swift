//
import Fluent
//  File.swift
//
//
//  Created by wanglei on 2020/7/11.
//
import Vapor

final class Group: Model,Content {
    static let schema = "group"

    @ID(key: .id)
    var id: UUID?
    @Field(key: "name")
    var name: String
    @Field(key: "avatar")
    var avatar: String?
    @Field(key: "type")
    var type: Int

    init() {}

    init(id: UUID? = nil, name: String, avatar: String? = nil, type: Int) {
        self.id = id
        self.name = name
        self.avatar = avatar
        self.type = type
    }
}

final class User: Model {
    static let schema = "user"

    @ID(key: .id)
    var id: UUID?
    @Field(key: "name")
    var name: String
    @Field(key: "avatar")
    var avatar: String?
    @Field(key: "online")
    var online: Bool?
    @Field(key: "conn")
    var conn: String?

    init() {}

    init(id: UUID? = nil, name: String, avatar: String? = nil, online: Bool?=false, conn: String?=nil) {
        self.id = id
        self.name = name
        self.avatar = avatar
        self.online = online
        self.conn = conn
    }
}

final class Message: Model {
    static let schema = "message"

    @ID(key: .id)
    var id: UUID?
    @Parent(key: "group_id")
    var group: Group
    @Parent(key: "sender_uid")
    var sender: User
    @Field(key: "content")
    var content: String
    @Field(key: "type")
    var type: Int

    init() {}

    init(id: UUID? = nil, groupId: UUID, senderId: UUID, content: String, type: Int) {
        self.id = id
        self.$group.id = groupId
        self.$sender.id = senderId
        self.content = content
        self.type = type
    }
}

final class GroupUserRel: Model {
    static let schema = "group_user"

    @ID(key: .id)
    var id: UUID?
    @Parent(key: "user_id")
    var user: User
    @Parent(key: "group_id")
    var group: Group
    @Field(key: "user_remark_name")
    var userRemarkName: String?
    @Field(key: "last_msg_id")
    
    //The lastMsgId maybe a offset if the user lost msg
    var lastMsgId: UUID?
    @Field(key: "owner")
    var owner:Bool

    init() {}

    init(id: UUID? = nil, userId: UUID, groupId: UUID, userRemarkName: String? = nil, lastMsgId: UUID?=nil, owner:Bool) {
        self.id = id
        self.$user.id = userId
        self.$group.id = groupId
        self.userRemarkName = userRemarkName
        self.lastMsgId = lastMsgId
        self.owner=owner
    }
}

final class MessageStatus: Model {
    static let schema = "message_status"

    @ID(key: .id)
    var id: UUID?
    @Field(key: "msg_id")
    var msgId: UUID
    @Field(key: "receiver_uid")
    var revUid: UUID
    @Field(key: "group_id")
    var groupId: UUID
    @Field(key: "send_status")
    var sendStatus:Int
    @Field(key: "read_status")
    var readStatus:Int

    init() {}

    init(id: UUID? = nil, msgId: UUID, receiverUid: UUID, groupId: UUID, sendStatus: Int, readStatus: Int) {
        self.id = id
        self.msgId = msgId
        self.revUid = receiverUid
        self.groupId = groupId
        self.sendStatus = sendStatus
        self.readStatus = readStatus
    }
}
