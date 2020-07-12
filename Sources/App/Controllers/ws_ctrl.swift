//
//  File.swift
//
//
//  Created by wanglei on 2020/7/12.
//
import Vapor

var wsLocalConnCache = [String: WebSocket]()

public func routeWs(app: Application) {
    app.webSocket("echo", onUpgrade: handleWs)
}

func handleWs(req: Request, ws: WebSocket) {
    logger.info("Connect Echo:\(ws), Ws Size:\(MemoryLayout.size(ofValue: ws)),Request Header:\(req.headers) ")

    guard let loginUid = req.headers.first(name: "userId") else {
        ws.send("Not Login")
               return
    }
  
    // Send Greeting
    ws.send("Welcome!")
    // Local Cache Connection
    cacheWs(uid: loginUid, ws: ws)
    
    // Message
    ws.onText { _, string in
        logger.info("Cache Ws:\(wsLocalConnCache)")
        logger.info("--- Reply:\(string)")
        
        // Group Reply
        for (_,tmpWs) in wsLocalConnCache {
            tmpWs.send("GROUP REPLY:\(string)")
        }
    
        // Single Reply
        // ws.send("Reply:\(string)")
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

func cacheWs(uid:String,ws:WebSocket) {
    let hasCached = wsLocalConnCache.contains { (cachedUid:String, cachedWs: WebSocket) in
        uid == cachedUid
    }
    if !hasCached {
        wsLocalConnCache.updateValue(ws, forKey: uid)
    } else {
        logger.info("Cached This Ws Already,Skip")
    }
}

func removeCacheWs(uid:String) {
    wsLocalConnCache.forEach({ key,value in
        if key == uid {
            wsLocalConnCache.removeValue(forKey: uid)
        }
    })
}
