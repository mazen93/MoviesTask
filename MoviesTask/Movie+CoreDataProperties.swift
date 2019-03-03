//
//  Movie+CoreDataProperties.swift
//  MoviesTask
//
//  Created by mac on 3/2/19.
//  Copyright © 2019 mac. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var date: String?
    @NSManaged public var overview: String?
    @NSManaged public var photo: NSData?
    @NSManaged public var title: String?

}
