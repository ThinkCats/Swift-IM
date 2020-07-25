//
//  File.swift
//
//
//  Created by wanglei on 2020/7/12.
//
import Vapor

var wsLocalConnCache = [String: WebSocket]()

func cacheWs(uid: String, ws: WebSocket) {
    let hasCached = wsLocalConnCache.contains { (cachedUid: String, _: WebSocket) in
        uid == cachedUid
    }
    if !hasCached {
        wsLocalConnCache.updateValue(ws, forKey: uid)
    } else {
        logger.info("Cached This Ws Already,Skip")
    }
}

func removeCacheWs(uid: String) {
    wsLocalConnCache.forEach { key, _ in
        if key == uid {
            wsLocalConnCache.removeValue(forKey: uid)
        }
    }
}

func getWs(uid:String) throws -> WebSocket {
    guard let ws = wsLocalConnCache[uid] else {
        throw BizError.IllegalWsConnection
    }
    return ws
}
