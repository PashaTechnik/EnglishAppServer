import Fluent
import FluentPostgresDriver
import Vapor
import PostgresKit

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database"
    ), as: .psql)
    

    app.migrations.add(CreateTodo())
    app.migrations.add(CreateGalaxy())
    app.migrations.add(CreateUser())
    app.databases.use(.postgres(hostname: "localhost", username: "admin", password: "1234", database: "swift"), as: .psql)
    // register routes
    try routes(app)
    
    
}
