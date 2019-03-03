//
//  addMoviesTest.swift
//  MoviesTaskTests
//
//  Created by mac on 3/3/19.
//  Copyright © 2019 mac. All rights reserved.
//

import XCTest
import Foundation
@testable import MoviesTask
class addMoviesTest: XCTestCase {

    func testValidStrings()  {
        let string="ddd"
        
        let addM=AddMovieVC()
        
        
      XCTAssertTrue(addM.validCount(string: string))
    //  validCount(string: string)
    }
    func testInValidStrings()  {
        let string="dd"
        
        let addM=AddMovieVC()
        
        
        XCTAssertFalse(addM.validCount(string: string))
        //  validCount(string: string)
    }
    

    
}
