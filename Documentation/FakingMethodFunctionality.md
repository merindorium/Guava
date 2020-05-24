# Faking method functionality

`Fake` is helpful if you want to have a control and inject some logic to test double. With `Fake` you are able to receive all incoming arguments and cast them to expected types.

> ⚠️ Warning: Use `[Argument]` method `as` with caution. It casts type strictly and will raise a fatal failure if types are not matching.

As an example we could fake a Movie DB that stores movies rating.

```swift
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
```

Let's create a `MovieDBClient` test double that will fake real DB with in-memory dictionary.

```swift
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
```

Let's take a brief look at `setUpAsInMemoryKeyValueDB`. In this method we use `fake` feature to rewrite logic of `get` and `set` methods with defined closures. 

As you can see this closures have `args` as an input argument. This is an array of `Argument` entites that stores values passed to this methods. By default `Argument` stores its value as `Any` and that's why we need to cast it to expected type before working with it. 

`Array<Argument>` has `as` method that will help you with this task. This method use strict casting and it will lead to test failure if we will try to cast an argument to wrong type.

As the result we could test that our `MovieManager` uses `MovieDBClient` correctly.

```swift
final class MovieManagerTests: XCTestCase {

    func testMoviesFetchedSuccessfully() {
        let movies = [
            (name: "Blockbuster", rating: 8),
            (name: "Blockbuster 2", rating: 6)
        ]

        // Arrange SUT and its dependencies
        let dbClientTestDouble = MovieDBClientTestDouble()
        let movieManager = MovieManager(dbClient: dbClientTestDouble)

        // Setting up test double as a `Fake` DB
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
}
```