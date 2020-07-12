//
//  File.swift
//
//
//  Created by wanglei on 2020/7/12.
//

enum MessageType {
    case Text
    case Audio
    case Vedio
    case Image
    case RichText
}

enum MessageCategoy {
    case Normal
    case Scheduled
}

enum MessageSentStatus {
    case Waiting
    case Sent
}

enum MessageEvent {
    case Login
    case Keep
    case Msg
    case Ack
    case Logout
}

struct IMessage {
    var groupId:String?
    var from:String
    var event: MessageEvent
    var type: MessageType
    var category: MessageCategoy
    var body: String
}
