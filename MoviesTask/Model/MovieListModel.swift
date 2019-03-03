//
//  MovieListModel.swift
//  MoviesTask
//
//  Created by mac on 2/27/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
struct  MovieListModel :Decodable{
    let results:[results]?
    let page:Int?
    let total_pages:Int?
    let total_results:Int?
    
}
struct results :Decodable{
    let title:String?
    let release_date:String?
    let poster_path:String?
    let overview:String?
}
