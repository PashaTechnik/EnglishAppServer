import Fluent
import Vapor
import FluentPostgresDriver
import PostgresKit


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
    
    
    app.post("users", "update") { req  -> String in
        let userN = try req.content.decode(User.self)
        let db: SQLDatabase = req.db as! SQLDatabase
        
        //db.query("")
        db.update("users")
            .where("name", .equal, userN.name)
            .set("isLoggedIn", to: userN.isLoggedIn)
            .run()
        
        return "Good"
        }
            
    
    
    
    
    
    
    
    
//    app.put("users") { req -> EventLoopFuture<User> in
//
//
//        guard let id = req.parameters.get("id", as: UUID.self) else {
//            throw Abort(.badRequest)
//        }
//
//
//        let input = try req.content.decode(User.self)
//        return User.find(id, on: req.db)
//            .unwrap(or: Abort(.notFound))
//            .flatMap { user in
//                user.isLoggedIn = input.isLoggedIn
//                return user.save(on: req.db)
//                    .map { user }
//            }
//
//
//
////        let db: SQLDatabase = req.db as! SQLDatabase
////        return try db.update("user")
////            .where("name", .equal, "Jpuiter")
////            .set("name", to: "Jupiter")
////            .run().wait()
////
////        let user = try User.query(on: req.db).filter(\.$name == "name").update()
//        //user.update(on: )
////        user.query(on: req.db)
////            .set(\.$type, to: .dwarf)
////            .filter(\.$name == "Pluto")
////            .update()
//    }
    app.get("users") { req in
        
        User.query(on: req.db).all()
    }
    
    
    try app.register(collection: TodoController())

}
