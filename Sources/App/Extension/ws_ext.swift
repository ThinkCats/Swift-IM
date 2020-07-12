////
////  File.swift
////  
////
////  Created by wanglei on 2020/7/12.
////
//import Vapor
//
//extension RoutesBuilder {
//    public func webSocket(
//        _ path: PathComponent...,
//        maxFrameSize: WebSocketMaxFrameSize = .`default`,
//        onUpgrade: @escaping (Request, WebSocket) -> ()
//    ) -> Route {
//        return self.on(.GET, path) { request -> Response in
//            var res = Response(status: .switchingProtocols)
////            let secWsProtocol: String? = request.headers.first(name: "Sec-WebSocket-Protocol")
////            if secWsProtocol != nil {
////                res.headers.add(name: "Sec-WebSocket-Protocol", value: secWsProtocol!)
////            }
////
//            res.upgrader = .webSocket(maxFrameSize: maxFrameSize, onUpgrade: { ws in
//                onUpgrade(request, ws)
//            })
//            return res
//        }
//    }
//}
