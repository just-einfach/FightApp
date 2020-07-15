//
//  Reitings.swift
//  DesignAlert
//
//  Created by   Vlad on 17.05.2020.
//  Copyright © 2020   Vlad. All rights reserved.
//

import UIKit
import  WebKit

class Reitings: UIViewController, WKUIDelegate {
    


    var webView: WKWebView!
           
           override func loadView() {
            
            let webConfig = WKWebViewConfiguration()
            
            webView = WKWebView(frame: .zero, configuration: webConfig)
            webView.uiDelegate = self
            view = webView
    }
    
   override func viewDidLoad() {
       super.viewDidLoad()

         let myURL = URL(string: "https://ru.ufc.com/rankings")!
       
           let request = URLRequest(url: myURL)
    webView.load(request)

                view.backgroundColor = UIColor.black

                


    }
        

}
