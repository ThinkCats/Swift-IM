import Vapor

func routes(_ app: Application) throws {
    // test
    testRoute(app: app)
    // route group
    try app.register(collection: GroupController())
    // route ws
    routeWs(app: app)
    
}

func testRoute(app:Application){
    app.get { _ in
        "It works!"
    }

    app.get("hello") { _ -> String in
        "Hello, world!"
    }
}
