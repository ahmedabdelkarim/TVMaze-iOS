//
//  MoviesTests.swift
//  TVMazeTests
//
//  Created by Ahmed Abdelkarim on 26/12/2021.
//

import XCTest
@testable import TVMaze

class MoviesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMoviesAssignCorrectly() throws {
        let mockMovieRepository = MockMovieRepository(numberOfMovies: 3)
        let vm = MoviesViewModel(movieRepository: mockMovieRepository)
        
        vm.getMovies(for: "dummy", success: { movies in
            XCTAssertNotNil(vm.movies)
            XCTAssertEqual(vm.movies.count, mockMovieRepository.numberOfMovies)
        }, failure: { error in
            XCTFail("Expected to succeed, but got error: \(String(describing: error))")
        })
    }
    
    //other test cases..
    
}

private class MockMovieRepository: MovieRepositoryProtocol {
    // testing properties
    var numberOfMovies = 3
    
    // testing init
    convenience init(numberOfMovies: Int) {
        self.init(onlineService: nil, offlineStore: nil)
        
        self.numberOfMovies = numberOfMovies
    }
    
    required init(onlineService: MovieOnlineServiceProtocol?, offlineStore: MovieOfflineStoreProtocol?) {
        // do nothing
    }
    
    func getMovies(for searchText: String, success: @escaping ([Movie]) -> Void, failure: @escaping (Error?) -> Void) {
        // return dummy list
        var movies = [Movie]()
        
        for i in 1...numberOfMovies {
            movies.append(Movie(id: i, name: "Movie \(i)", url: "", summary: "Movie \(i) summary...", runtime: nil, premiered: nil, averageRating: nil, mediumImage: nil, originalImage: nil))
        }
        
        success(movies)
    }
}
