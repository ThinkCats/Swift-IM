//
//  File.swift
//
//
//  Created by wanglei on 2020/7/12.
//
import Vapor

var wsConnCache = [WebSocket]()

public func routeWs(app: Application) {
    app.webSocket("echo", onUpgrade: handleWs)
}

func handleWs(req: Request, ws: WebSocket) {
    logger.info("Connect Echo:\(ws), Ws Size:\(MemoryLayout.size(ofValue: ws)) ")
    
    let hasCached = wsConnCache.contains { (cachedWs: WebSocket) in
        cachedWs === ws
    }
    if !hasCached {
        wsConnCache.append(ws)
    } else {
        logger.info("Cached This Ws Already,Skip")
    }
    
    ws.send("Connect to WS :\(ws)")
    
    // Ping
    ws.onPing { _ in
        logger.info("Ping")
    }
    
    // Pong
    ws.onPong { _ in
        logger.info("Pong")
    }
    
    // Message
    ws.onText { _, string in
        logger.info("Cache Ws:\(wsConnCache)")
        logger.info("--- Reply:\(string)")
        
        // Group Reply
        for wss in wsConnCache {
            wss.send("GROUP REPLY:\(string)")
        }
        
        // Single Reply
        // ws.send("Reply:\(string)")
    }
    
    // Close
    ws.onClose.whenComplete { _ in
        logger.info("Close Ws, Remove From Cache")
        for (index, value) in wsConnCache.enumerated() {
            if value === ws {
                wsConnCache.remove(at: index)
            }
        }
    }
}
