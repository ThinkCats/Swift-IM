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
    let uid = UUID.init(uuidString: msg.from)
    logger.info("Check Login:\(uid)")
    // check unsend msg
    MessageStatus.query(on: req.db)
        .filter(\.$revUid == uid!).all { result in
            let data = try! result.get()
            logger.info("tttt:\(data)")
            let ws =  try! getWs(uid: "1")
            ws.send(data.groupId.uuidString)
    }
    
}
