
//  shimmer.swift
//  FIGHT!
//
//  Created by   Vlad on 05.05.2020.
//  Copyright © 2020   Vlad. All rights reserved.
//

 import UIKit

class FirstViewController: UIViewController {
    
    
    var myImageView = UIImageView()
    var myProgressView = UIProgressView()
    var myButton = UIButton()
    var myTimer = Timer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
          createImage()
        createShimmer()
      
        
        
        let nextVC = UIStoryboard(name: "Main", bundle: .main).instantiateInitialViewController()!
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.createProgress(self.myProgressView)
            self.createTimer()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.createLabel()
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
        
    }
        
        func createImage() {
            let conorImage = UIImage(named: "conor")
            myImageView = UIImageView(frame: self.view.bounds)
            myImageView.contentMode = .bottomRight
            myImageView.image = conorImage
            view.addSubview(myImageView)
            
            
            
        }
        
        
        
    
    func createShimmer() {
        
        // затемнение прогресса
        let darkTextlabel = UILabel()
        darkTextlabel.text = "FIGHT"
        darkTextlabel.textColor = UIColor(white: 1, alpha: 0.2)
        darkTextlabel.font = UIFont(name: "a_BosaNova", size: 80)
        
        
        darkTextlabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 400)
        darkTextlabel.textAlignment = .center
        view.addSubview(darkTextlabel)
        
    
        let shinyTextlabel = UILabel()
        shinyTextlabel.text = "FIGHT"
        shinyTextlabel.textColor = .white
        shinyTextlabel.font = UIFont(name: "a_BosaNova", size: 80)
        shinyTextlabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 400)
        shinyTextlabel.textAlignment = .center
        
        view.addSubview(shinyTextlabel)
    
        
        //        gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.frame = shinyTextlabel.frame

        let angle = 45 * CGFloat.pi / 180
        gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)

        shinyTextlabel.layer.mask = gradientLayer

        //        animation

        let animation = CABasicAnimation(keyPath: "transform.translation.x")

        animation.fromValue = -view.frame.width
        animation.toValue = view.frame.width
        animation.repeatCount = Float.infinity
        animation.duration = 2

        gradientLayer.add(animation, forKey: "Doesn't metter")


    
    
    }
    
    
    
    //  MARK: - Timer
    private func createTimer() {
        myTimer = Timer.scheduledTimer(timeInterval: 0.5,
                                       target: self,
                                       selector: #selector(updateProgressView),
                                       userInfo: nil,
                                       repeats: true)
    }
    
    
    @objc func updateProgressView () {
        if myProgressView.progress != 1.0 {
            myProgressView.progress += 0.2 / 1.0
        }else if myProgressView.progress == 1.0 {
            UIView.animate(withDuration: 0.1, animations: {
                self.myButton.alpha = 1
                self.myButton.setTitle("Go!", for:.application)
                self.myTimer.invalidate()
                
            })
            
        }
        
        
    }
    
    
    //    MARK: - UI
    private func createProgress(_ progressView: UIProgressView) {
        progressView.progressViewStyle = .bar
        progressView.frame = CGRect(x: view.center.x - 95, y: view.center.y - 200, width: 200, height: 50)
        progressView.setProgress(0.0, animated: false)
        progressView.tintColor = .white
        progressView.trackTintColor = .gray
        view.addSubview(progressView)
        
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    
    func createLabel() {
        
        let label = UILabel()
        label.text = "!"
        label.textColor = .red
        label.font = UIFont(name: "a_BosaNova", size: 80)
        label.frame = CGRect(x: 105, y: 0, width: view.frame.width, height: 400)
        label.textAlignment = .center
        view.addSubview(label)
        
    }
    
    
}


