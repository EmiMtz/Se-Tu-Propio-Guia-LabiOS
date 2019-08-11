//
//  Place.swift
//  Sé tu propio guía
//
//  Created by Tania Rossainz on 8/9/19.
//  Copyright © 2019 Emiliano Martínez. All rights reserved.
//

import Foundation

class Place {
    var name: String
    var type: String
    var location: String
    var image: String
    var phone: String
    var description: String
    var realidad: String
    var isVisited: Bool
    
    init(name: String, type: String, location: String, image: String, phone: String, description: String, realidad: String, isVisited: Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.phone = phone
        self.description = description
        self.realidad = realidad
        self.isVisited = isVisited
    }
    
    convenience init() {
        self.init(name: "", type: "", location: "", image: "", phone: "", description: "", realidad: "", isVisited: false)
    }
}

