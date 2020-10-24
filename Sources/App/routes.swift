import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }

    
    
    app.get("galaxies") { req in
        Galaxy.query(on: req.db).all()
    }
    
    app.post("galaxies") { req -> EventLoopFuture<Galaxy> in
        let galaxy = try req.content.decode(Galaxy.self)
        return galaxy.create(on: req.db)
            .map { galaxy }
    }
    
    app.post("users") { req -> EventLoopFuture<User> in
        let user = try req.content.decode(User.self)
        return user.create(on: req.db)
            .map { user }
    }
    
    app.get("users") { req in
        User.query(on: req.db).all()
    }
    
    
    try app.register(collection: TodoController())

}
