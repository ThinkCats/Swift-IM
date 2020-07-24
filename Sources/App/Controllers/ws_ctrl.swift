//
//  File.swift
//
//
//  Created by wanglei on 2020/7/12.
//
import Vapor

public func routeWs(app: Application) {
    app.webSocket("echo", onUpgrade: handleWs)
}

func handleWs(req: Request, ws: WebSocket) {
    logger.info("Connect Echo:\(ws), Ws Size:\(MemoryLayout.size(ofValue: ws)),Request Header:\(req.headers) ")
    
    guard let loginUid = req.headers.first(name: "Sec-WebSocket-Protocol") else {
        logger.info("Not Login")
        ws.send("Not Login")
        return
    }
    
    logger.info("Auth Ok:\(loginUid)")
    
    // Send Greeting
    ws.send("Welcome!")
    // Local Cache Connection
    cacheWs(uid: loginUid, ws: ws)
    
    // Message
    ws.onText { _, content in
        logger.info("Cache Ws:\(wsLocalConnCache)")
        
        // Group Reply
        for (_, tmpWs) in wsLocalConnCache {
            tmpWs.send("GROUP REPLY:\(content)")
        }
        
        // Single Reply
        // ws.send("Reply:\(string)")
        do {
            try dispatchMsg(req: req, msg: content)
        } catch {
            logger.error("Find Error:")
        }
    }
    
    // Ping
    ws.onPing { _ in
        logger.info("Ping")
    }
    
    // Pong
    ws.onPong { _ in
        logger.info("Pong")
    }
    
    // Close
    ws.onClose.whenComplete { _ in
        logger.info("Close Ws, Remove From Cache")
        removeCacheWs(uid: loginUid)
    }
}
