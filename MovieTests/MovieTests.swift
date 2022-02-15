//
//  MovieTests.swift
//  MovieTests
//
//  Created by Bruno Gomez on 2/14/22.
//

import XCTest
@testable import Movie
class MovieTests: XCTestCase {
    
    var vm : ViewModel?
    var nm : NetworkModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vm = ViewModel()
        nm = NetworkModel.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        vm = nil
        nm = nil
    }
    
    func testGetMovieCount() {
        let result = vm?.getMovieCount()
        XCTAssertEqual(result, 0)
    }
    
    func testGetMovieDisplay() {
        let result = vm?.getMovieDisplay(0)
        XCTAssertEqual(result, nil)
    }
    
    func testGoThroughTranscodings() {
        let result = vm?.goThroughTranscodings([])
        XCTAssertEqual(result, nil)
    }
    
    func testAssignMovies() {
        vm?.assignMovies([Movie()])
        let result = vm?.getMovieCount()
        XCTAssertEqual(result, 1)
    }
    
    func testGetMovieTranscodingDisplay() {
        let transcoding = Transcodings()
        let result = vm?.getMovieTranscodingDisplay(transcoding)
        XCTAssertEqual(result, nil)
        let transcoding2 = Transcodings(id: "1", size: 2, title: "title", height: 300, width: 400, state: "completed")
        let str = vm?.getMovieTranscodingDisplay(transcoding2)
        let compare = "ID: 1\nSize: 2\nHeight: 300\nWidth: 400\nState: completed\nTitle: title"
        XCTAssertEqual(str,compare)
    }
    
    func testGetMovie() {
        let movie = vm?.getMovie(0)
        XCTAssertNil(movie, "test returned nil successfully")

    }
    
}
