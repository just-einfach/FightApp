//
//  UserDefaults.swift
//  DesignAlert
//
//  Created by   Vlad on 24.05.2020.
//  Copyright © 2020   Vlad. All rights reserved.
//

import Foundation


class UserSettings {
    
    static var isFavorite: Bool {
        
        get {
            return UserDefaults.standard.bool(forKey: "favorite")
            
        }set{
            
            let defaults = UserDefaults.standard
            
                
                print("save")
                
                defaults.set(newValue, forKey: "favorite")
                
            }
        }
    }

