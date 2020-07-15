//
//  p4p.swift
//  DesignAlert
//
//  Created by   Vlad on 17.05.2020.
//  Copyright © 2020   Vlad. All rights reserved.
//

import UIKit

class Favorites: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let userDefaults = UserDefaults.standard
               
    var myTableView = UITableView()
    let index = "My cell"
               
    var events: [Competition] = []
    
    
    let imageView = UIImageView()
    var conorImage = UIImage(named: "244")
  

   

    override func viewWillAppear(_ animated: Bool) {
    
        super.viewWillAppear(true)
    
       

        
              createTable()
        
                
       myTableView.reloadData()
            
        
        
        
            if let save = self.userDefaults.object(forKey: "object") as? Data  {
                  let decoder = JSONDecoder()

        if let load = try? decoder.decode([Competition].self, from: save) {
                    

            self.events = load
            
                
                }
            }
                     
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
                   let number = events[indexPath.row]
                    cell.textLabel?.text = number.name
                cell.imageView?.image = conorImage
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.lineBreakMode = .byWordWrapping
                                return cell
                
               
             }
            
        //    MARK:- UITableViewDelegate
            
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 100
            
    }
    
    
}

        

    
      
    
      








