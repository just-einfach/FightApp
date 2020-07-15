//
//  Json.swift
//  FIGHT!
//
//  Created by   Vlad on 22.05.2020.
//  Copyright © 2020   Vlad. All rights reserved.
//

import  UIKit

class  Competition: Codable, Equatable {
    
    
    
    let id: String?
    let name: String?
    let parent_id: String?
    
    
    
    static func == (lhs: Competition, rhs: Competition) -> Bool {
        lhs.id == rhs.id
    }
    init(id: String?, name: String?, parent_Id: String?) {
        self.id = id
        self.name = name
        self.parent_id = parent_Id
    }
    
}

class CompetitionResponse: Decodable {
    
    let competitions: [Competition]?
}


class CompetitionService {
    
    let complition: (Result<[Competition], Error>) -> Void
    
    
    init(complition: @escaping (Result<[Competition], Error>) -> Void) {
        
        self.complition = complition
    }
    
    func requestCompetition() {
        
        let url = "http://api.sportradar.us/ufc/trial/v2/en/competitions.json?api_key=smxmcbm9rj3b235rnwqb9x9y"
        URLSession.shared.dataTask(with: URL(string: url)!) { [weak self](data, responce, error) in
            if let error = error {
                
                
                self?.complition(.failure(error))
                return
            }
            //          let string = String(data: data!, encoding: .utf8)
            
            
            if let data = data, let response = try? JSONDecoder().decode(CompetitionResponse.self, from: data) {
                
                self?.complition(.success(response.competitions ?? [])) 
                
            }
        }.resume()
    }
    
}


