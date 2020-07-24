//
//  File.swift
//
//
//  Created by wanglei on 2020/7/12.
//

enum MessageType:String,Codable {
    case Text
    case Audio
    case Vedio
    case Image
    case RichText
}

enum MessageCategoy:String,Codable {
    case Normal
    case Scheduled
}

enum MessageSentStatus:String,Codable {
    case Waiting
    case Sent
}

enum MessageEvent:String,Codable {
    case Login
    case Keep
    case Msg
    case Ack
    case Logout
}

struct IMessage: Codable {
    var from:String
    var event: MessageEvent
    var type: MessageType
    var category: MessageCategoy
    var body: String
}

struct ChatBody {
    var groupId:String
    var ext:String
}

