//
//  VC4.swift
//  DesignAlert
//
//  Created by   Vlad on 14.05.2020.
//  Copyright © 2020   Vlad. All rights reserved.
//

import UIKit
class vc4: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    let userDefaults = UserDefaults.standard
    
    let imageView = UIImageView()
    var conorImage = UIImage(named: "244")
    
    
      
      var myTableView = UITableView()
    let index = "My cell"
      
    lazy var competitionservice = CompetitionService {  [weak self] (result) in

        switch result {
        case let .success(competition):
        self?.events = competition.map({ (competition) -> Model in

            return Model(isFavourite: self!.isCompetitionFavorite(key: competition.id!), fight: competition)
        })

        DispatchQueue.main.async {
            self?.myTableView.reloadData()
        }

        case let .failure(error): print (error)
        }
    }
    

    
    var events: [Model] = []
    
    
    
    func isCompetitionFavorite (key: String) -> Bool {

        if let objc = userDefaults.object(forKey: "object") as? Data {
            
            let competitions = try? JSONDecoder() .decode([Competition].self, from: objc)

            return competitions?.contains(Competition(id: key, name: nil, parent_Id: nil)) ?? false
        }
        return false
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
       competitionservice.requestCompetition()
        
        
        
        
        view.backgroundColor = UIColor.red

        

      createTable()
       
}
    func createTable() {
        
        self.myTableView = UITableView(frame: view.bounds, style: .plain)
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: index)
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        myTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(myTableView)

        
    }
//MARK: - UITableViewDataSource
  
        
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: index, for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        
        let number = events[indexPath.row]
        cell.textLabel?.text = number.fight.name
       
        
        cell.imageView?.image = conorImage
       

        return cell
     }
    
//    MARK:- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
  
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        
        let favourite = favouriteAction(at: indexPath)
        

        return UISwipeActionsConfiguration(actions: [favourite])
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            events.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
       
        
    
    
    
        }
    
    
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = events.remove(at: sourceIndexPath.row)
        
        events.insert(movedEmoji, at: destinationIndexPath.row)
        
        tableView.reloadData()
    }
    
   
          
 
    
    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        
        var object = events[indexPath.row]
        

        
        
               
        
        let action = UIContextualAction(style: .normal, title: "") { (action, view, completion) in
           
            
            object.isFavourite = !object.isFavourite
            
           
 
         
        
            
            if let obj = self.userDefaults.object(forKey: "object") as? Data {
                
                var competitions = try? JSONDecoder() .decode([Competition].self, from: obj)
                
              
                if !object.isFavourite, let index = competitions!.firstIndex(of: object.fight) {
                    competitions?.remove(at: index)
                    
                }else{
                    competitions!.append(object.fight)
                }
//            if obj[object.fight.id!] = object.isFavourite
                
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(competitions) {
                    
                    self.userDefaults.set(encoded, forKey: "object")
                
                    
                    
                }
            }else{
               let encoder = JSONEncoder()
                if let encoded = try? encoder.encode([object.fight]) {
                                  
                self.userDefaults.set(encoded, forKey: "object")
            }
            }
            self.userDefaults.synchronize()
            
            
            self.events[indexPath.row] = object
            completion(true)

        }
           
        
         action.backgroundColor = object.isFavourite ? .systemPurple : .systemGray
            action.image = UIImage(systemName: "heart")
            
         
            
            return action
            
            
            
            
            
            
            
        }
    }

