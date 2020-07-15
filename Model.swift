//
//  Model.swift
//  DesignAlert
//
//  Created by   Vlad on 18.05.2020.
//  Copyright © 2020   Vlad. All rights reserved.
//

import Foundation

struct Model {
 
    
    
    
    var fight: Competition
   var isFavourite: Bool
   
    
    init (isFavourite: Bool, fight: Competition) {
        self.isFavourite = isFavourite
        self.fight = fight
       
    }
    

}
