
import Foundation
import Fluent
import FluentPostgresDriver
import Vapor
import PostgresKit

final class User: Model, Content {

    
    
    // Name of the table or collection.
    static let schema = "users"


    @ID(key: .id)
    var id: UUID?

    @Field(key: "email")
    var email: String
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "password")
    var password: String
    
    @Field(key: "points")
    var points: Int
    
    @Field(key: "isLoggedIn")
    var isLoggedIn: Bool

    // Creates a new, empty Galaxy.
    init() { }

    // Creates a new Galaxy with all properties set.
    init(id: UUID? = nil, email: String, password: String, name : String, points: Int, isLoggedIn: Bool) {
        self.id = id
        self.email = email
        self.password = password
        self.name = name
        self.points = points
        self.isLoggedIn = isLoggedIn
        
    }
}

struct CreateUser: Migration {
    // Prepares the database for storing Galaxy models.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users")
            .id()
            .field("email", .string)
            .field("password", .string)
            .field("name", .string)
            .field("points", .int)
            .field("isLoggedIn", .bool)
            .create()
    }

    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users").delete()
    }
}
