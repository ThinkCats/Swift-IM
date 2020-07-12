import Vapor
import Fluent
import FluentPostgresDriver

var logger = Logger(label: "swift.im.logger")

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    //PostgreSql
    try app.databases.use(.postgres(url: "postgresql://test:123456@localhost:5432/swift_im"), as: .psql)

    // register routes
    try routes(app)
}
