import Guava
import XCTest

protocol MovieDBClient {

    func get(key: String) -> Int?
    func set(key: String, value: Int)
}

final class MovieManager {

    private let movieDBClient: MovieDBClient

    init(dbClient: MovieDBClient) {
        movieDBClient = dbClient
    }

    func addMovie(name: String, rating: Int) {
        movieDBClient.set(key: name, value: rating)
    }

    func getMovieRating(byName name: String) -> Int? {
        return movieDBClient.get(key: name)
    }
}

final class MovieDBClientTestDouble: MovieDBClient {

    let getMethod = TestDoubleFactory<Int?>()
    let setMethod = TestDoubleFactory<Void>()

    private var inMemoryDB = [String: Int]()

    func get(key: String) -> Int? {
        return getMethod.invoke(arguments: [key])
    }

    func set(key: String, value: Int) {
        setMethod.invoke(arguments: [key, value])
    }

    func setUpAsInMemoryKeyValueDB() {
        getMethod.fake { args in
            let name = args.as(String.self)

            return self.inMemoryDB[name]
        }

        setMethod.fake { args in
            let (name, rating) = args.as(String.self, Int.self)

            self.inMemoryDB[name] = rating
        }
    }
}

final class MovieManagerTests: XCTestCase {

    func testMoviesFetchedSuccessfully() {
        let movies = [
            (name: "Blockbuster", rating: 8),
            (name: "Blockbuster 2", rating: 6)
        ]

        // Arrange SUT and its dependencies
        let dbClientTestDouble = MovieDBClientTestDouble()
        let movieManager = MovieManager(dbClient: dbClientTestDouble)

        // Setting up test double as a fake DB
        dbClientTestDouble.setUpAsInMemoryKeyValueDB()

        // Act
        movies.forEach { movie in
            movieManager.addMovie(name: movie.name, rating: movie.rating)
        }

        let fetchedRatings = movies.map { movieManager.getMovieRating(byName: $0.name) }
        let expectedRating = movies.map { $0.rating }

        // Assert
        XCTAssertEqual(fetchedRatings, expectedRating)
    }

    static var allTests = [
        ("testMoviesFetchedSuccessfully", testMoviesFetchedSuccessfully)
    ]
}
