//
//  File.swift
//
//
//  Created by wanglei on 2020/7/12.
//
import Vapor
import Fluent

public func dispatchMsg(req: Request, msg: String) throws {
    guard let jsonStr = msg.data(using: String.Encoding.utf8) else {
        throw BizError.SlackOfParams
    }
    let message = try JSONDecoder().decode(IMessage.self, from: jsonStr)
    let msgEvent: MessageEvent = message.event
    switch msgEvent {
        case .Login:
            handleLogin(req: req, msg: message)
        default:
            throw BizError.UnknownMsgEvent
    }
}

func handleLogin(req: Request, msg: IMessage) {
    // check unsend msg
    let unsentMsg = MessageStatus.query(on: req.db)
        .filter(\.$groupId == UUID.init()).all()
}
