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
    @Field(key: "onlineStatus")
    var onlineStatus: Int
    @Field(key: "conn")
    var conn: String

    init() {}

    init(id: UUID? = nil, name: String, avatar: String? = nil, onlineStatus: Int, conn: String) {
        self.id = id
        self.name = name
        self.avatar = avatar
        self.onlineStatus = onlineStatus
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
    @Parent(key: "last_msg_id")
    var message: Message

    init() {}

    init(id: UUID? = nil, userId: UUID, groupId: UUID, userRemarkName: String? = nil, lastMsgId: UUID) {
        self.id = id
        self.$user.id = userId
        self.$group.id = groupId
        self.userRemarkName = userRemarkName
        self.$message.id = lastMsgId
    }
}

final class MessageStatus: Model {
    static let schema = "message_status"

    @ID(key: .id)
    var id: UUID?
    @Parent(key: "msg_id")
    var message: Message
    @Parent(key: "receiver_uid")
    var user: User
    @Parent(key: "group_id")
    var group: Group
    @Field(key: "send_status")
    var sendStatus:Int
    @Field(key: "read_status")
    var readStatus:Int

    init() {}

    init(id: UUID? = nil, msgId: UUID, receiverUid: UUID, groupId: UUID, sendStatus: Int, readStatus: Int) {
        self.id = id
        self.$message.id = msgId
        self.$user.id = receiverUid
        self.$group.id = groupId
        self.sendStatus = sendStatus
        self.readStatus = readStatus
    }
}
