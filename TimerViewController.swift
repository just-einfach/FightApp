//
//  vc3.swift
//  DesignAlert
//
//  Created by   Vlad on 05.05.2020.
//  Copyright © 2020   Vlad. All rights reserved.
//

import UIKit
class TimerViewController: UIViewController {
    
    var buttonVC3 = UIButton()
    var buttonVC4 = UIButton()
    
    
    var timerLabelSeconds = UILabel()
    var underLabelSeconds = UILabel()
    
    
    var timerLabelMinutes = UILabel()
    var underLabelMinutes = UILabel()
    
    
    var timerLabelHour = UILabel()
    var underLabelHour = UILabel()
    
    
    var timerLabelDay = UILabel()
    var underLabelDay = UILabel()
    
    
    var labelForPointC = UILabel()
    var labelForPointR = UILabel()
    var labelForPointL = UILabel()
    
    
    let formatter = DateFormatter()
    let userCalendar = Calendar.current
    var dateComponent = DateComponents()
    
    
    var shapeLayerS = CAShapeLayer()
    var shapeLayerM = CAShapeLayer()
    var shapeLayerH = CAShapeLayer()
    var shapeLayerD = CAShapeLayer()
    
    var  pulsatingLayer: CAShapeLayer!
    
    
    var timerForSecond: Timer?
    var timerForMinutes: Timer?
    var timerForHour: Timer?
    var timerForDay: Timer?
    
    
    let fightDate1: Date
    
    
    
    
    lazy var lastDifferentTime: DateComponents = {
        let startTime = Date()
        return userCalendar.dateComponents([ .day, .hour, .minute, .second], from: startTime, to: fightDate1)
        
        
    }()
    
    
    
    let didmissClosure: () -> Void
    
    
    
    init(fightDate: Date, didmissClosure: @escaping () -> Void) {
        self.didmissClosure = didmissClosure
        self.fightDate1 = fightDate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func createLayers(strokeColor: UIColor, fillColor: UIColor, lineWidth: CGFloat, radius: CGFloat,
                              startAngle: CGFloat, endAngle: CGFloat) -> CAShapeLayer {
        
        let circularTrack = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let layer = CAShapeLayer()
        
        layer.path = circularTrack.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = lineWidth
        layer.lineCap = .round
        layer.fillColor = fillColor.cgColor
        layer.position = view.center
        return layer
        
    }
    
    private func createLabels(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, text: String, font: UIFont, textColor: UIColor, shadowColor: UIColor) -> UILabel {
        
        let label = UILabel()
        label.frame = CGRect(x: x, y: y, width: width, height: height)
        label.textAlignment = .center
        label.text = text
        label.backgroundColor = .backgroundColor
        label.font = font
        label.textColor = textColor
        label.shadowColor = shadowColor
        label.shadowOffset = CGSize(width: 1, height: 1)
        return label
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
       
        
        func addRotationAnimation() {
            let animation = CABasicAnimation(keyPath: "transform.rotation.z")
            animation.duration = 1
            animation.byValue = 2 * CGFloat.pi
            animation.repeatCount = .infinity
            shapeLayerS.add(animation, forKey: nil)
        }
 
     
        

        
//         MARK: createLayers

        pulsatingLayer = createLayers(strokeColor: .clear, fillColor: .pulsatingFillColor, lineWidth: 5, radius: 250, startAngle: 0, endAngle: 2 * CGFloat.pi)
        view.layer.addSublayer(pulsatingLayer)
        
        
        let circularTrackLayer = createLayers(strokeColor: .trackStrokeColor, fillColor: .backgroundColor, lineWidth: 20, radius: 250, startAngle: 0, endAngle: 2 * CGFloat.pi)
        view.layer.addSublayer(circularTrackLayer)
                


        //            create first circle
 
        shapeLayerS = createLayers(strokeColor: .trackStrokeColor, fillColor: .clear, lineWidth: 5, radius: 130, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi)
        view.layer.addSublayer(shapeLayerS)
        
                
                
        addRotationAnimation()

        
        
        shapeLayerM = createLayers(strokeColor: .trackStrokeColor, fillColor: .clear, lineWidth: 8, radius: 190, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi)
        shapeLayerM.strokeEnd = 0
        view.layer.addSublayer(shapeLayerM)
        
                
             
        shapeLayerH = createLayers(strokeColor: .trackStrokeColor, fillColor: .clear, lineWidth: 10, radius: 220, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi)
        shapeLayerH.strokeEnd = 0
        view.layer.addSublayer(shapeLayerH)
                
                
        
        shapeLayerD = createLayers(strokeColor: .outlineStrokeColor, fillColor: .clear, lineWidth: 20, radius: 250, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi)
        shapeLayerD.strokeEnd = 0
        view.layer.addSublayer(shapeLayerD)
                 
      
        
        animatePulsatingLayer()
        
             
            }
            
          
              
    func animatePulsatingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = 1.5
        animation.duration = 3
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        pulsatingLayer.add(animation, forKey: "pulsing")

                
     
//MARK: CreateLabel
            
            
        labelForPointC = createLabels(x: 0, y: 0, width: 10, height: 50, text: ":", font: .systemFont(ofSize: 45), textColor: .white, shadowColor: .black)
        labelForPointC.center = view.center
        self.view.addSubview(labelForPointC)

                
        
        labelForPointR = createLabels(x: self.view.center.x + 55, y: self.view.center.y - 25, width: 10, height: 50, text: ":", font: .systemFont(ofSize: 45), textColor: .white, shadowColor: .black)
        self.view.addSubview(labelForPointR)
        
        
            
        labelForPointL = createLabels(x: self.view.center.x - 59, y: self.view.center.y - 25, width: 10, height: 50, text: ":", font: .systemFont(ofSize: 45), textColor: .white,shadowColor: .black)
        self.view.addSubview(labelForPointL)
        

        
        timerLabelSeconds = createLabels(x: self.view.center.x + 65, y: self.view.center.y - 23, width: 52, height: 50, text: "", font: UIFont(name: "a_BosaNova", size: 40)!, textColor: .red, shadowColor: .white)
        self.view.addSubview(timerLabelSeconds)
            
            
        
        underLabelSeconds = createLabels(x: self.view.center.x  + 60, y: self.view.center.y  + 10, width: 60, height: 60, text: "Second", font: UIFont(name: "a_BosaNova", size: 15)!, textColor: .white, shadowColor: .red)
        underLabelSeconds.backgroundColor = .clear
        self.view.addSubview(underLabelSeconds)
                
            
                
        timerLabelMinutes = createLabels(x: self.view.center.x + 5, y: self.view.center.y - 23, width: 50, height: 50, text: "", font: UIFont(name: "a_BosaNova", size: 40)!, textColor: .white, shadowColor: .red)
        self.view.addSubview(timerLabelMinutes)
                
            
        
        underLabelMinutes = createLabels(x: self.view.center.x, y: self.view.center.y  + 10, width: 60, height: 60, text: "Minute", font: UIFont(name: "a_BosaNova", size: 15)!, textColor: .white, shadowColor: .red)
        underLabelMinutes.backgroundColor = .clear
        self.view.addSubview(underLabelMinutes)
        
        
                
        timerLabelHour = createLabels(x: self.view.center.x - 53, y: self.view.center.y - 23, width: 50, height: 50, text: "", font: UIFont(name: "a_BosaNova", size: 40)!, textColor: .white, shadowColor: .red)
        
        self.view.addSubview(timerLabelHour)
        
                
                
        underLabelHour = createLabels(x:  self.view.center.x - 50, y: self.view.center.y  + 10, width: 50, height: 60, text: "Hour", font: UIFont(name: "a_BosaNova", size: 15)!, textColor: .white, shadowColor: .red)
        underLabelHour.backgroundColor = .clear
        self.view.addSubview(underLabelHour)
                
                
                
        timerLabelDay = createLabels(x:  self.view.center.x - 108, y: self.view.center.y - 23, width: 50, height: 50, text: "", font: UIFont(name: "a_BosaNova", size: 40)!, textColor: .white, shadowColor: .red)
        self.view.addSubview(timerLabelDay)
        
            
        
        underLabelDay = createLabels(x: self.view.center.x - 105, y: self.view.center.y  + 10, width: 50, height: 60, text: "Day", font: UIFont(name: "a_BosaNova", size: 15)!, textColor: .white, shadowColor: .red)
        underLabelDay.backgroundColor = .clear
        self.view.addSubview(underLabelDay)
                  
                
                
             
//         MARK: work with date
                
              
                formatter.dateFormat = "MM/dd/yy hh:mm:ss a"
                
                timerForSecond = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(seconds), userInfo: nil, repeats: true)
                timerForMinutes = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(minutes), userInfo: nil, repeats: true)
                timerForHour = Timer.scheduledTimer(timeInterval: 3600, target: self, selector: #selector(hour), userInfo: nil, repeats: true)
                timerForDay = Timer.scheduledTimer(timeInterval: 86400, target: self, selector: #selector(day), userInfo: nil, repeats: true)
         

                seconds()
                minutes()
                hour()
                day()
                
            
            }


            
    @objc func seconds () {
        let startTime = Date()
        
        let differentTime = userCalendar.dateComponents([ .day, .hour, .minute, .second], from: startTime, to: fightDate1)
        timerLabelSeconds.text = "\(differentTime.second!)"
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = (CGFloat(60) - CGFloat(differentTime.second!)) / CGFloat(60)
        if differentTime.second == 59 {
            basicAnimation.fromValue = 0}
        
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.fillMode = .forwards
        
        if  differentTime.second == 0 {
            let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
            
            strokeStartAnimation.toValue = 1
            strokeStartAnimation.fromValue = 0
            strokeStartAnimation.duration = 1
            
            shapeLayerS.add(strokeStartAnimation, forKey: "strokeStart")
            
                    
                    
                    
        }
        basicAnimation.duration = 1
        shapeLayerS.add(basicAnimation, forKey: nil)
        
    }
    
    
    
    @objc func minutes() {
    
        let startTime = Date()
        let differentTime = userCalendar.dateComponents([ .day, .hour, .minute, .second], from: startTime, to: fightDate1)
        
        timerLabelMinutes.text = "\(differentTime.minute!)"
        let basicAnimation2 = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation2.toValue = (CGFloat(60) - CGFloat(differentTime.minute!)) / CGFloat(60)
        if differentTime.minute == 59 {
            basicAnimation2.fromValue = 0}
        
        basicAnimation2.isRemovedOnCompletion = false
        basicAnimation2.fillMode = .forwards
        
        if  differentTime.minute == 0 {
            let strokeStartAnimation2 = CABasicAnimation(keyPath: "strokeStart")
            
            strokeStartAnimation2.toValue = 1
            strokeStartAnimation2.fromValue = 0
            strokeStartAnimation2.duration = 1
            
            shapeLayerM.add(strokeStartAnimation2, forKey: "strokeStart")
            
            
            
            
        }
        basicAnimation2.duration = 1
        shapeLayerM.add(basicAnimation2, forKey: nil)
    }
    
    
    
    
    @objc func hour() {
        
        let startTime = Date()
        let differentTime = userCalendar.dateComponents([ .day, .hour, .minute, .second], from: startTime, to: fightDate1)
        
        timerLabelHour.text = "\(differentTime.hour!)"
        let basicAnimation3 = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation3.toValue = (CGFloat(60) - CGFloat(differentTime.hour!)) / CGFloat(60)
        if differentTime.hour == 59 {
            basicAnimation3.fromValue = 0}
        
        basicAnimation3.isRemovedOnCompletion = false
        basicAnimation3.fillMode = .forwards
        
        if  differentTime.hour == 0 {
            let strokeStartAnimation3 = CABasicAnimation(keyPath: "strokeStart")
            
            strokeStartAnimation3.toValue = 1
            strokeStartAnimation3.fromValue = 0
            strokeStartAnimation3.duration = 1
            
            shapeLayerH.add(strokeStartAnimation3, forKey: "strokeStart")
            
        }
        basicAnimation3.duration = 1
        shapeLayerH.add(basicAnimation3, forKey: nil)
    }
    
    
    
    
    @objc func day () {
        
        let startTime = Date()
        let differentTime = userCalendar.dateComponents([ .day, .hour, .minute, .second], from: startTime, to: fightDate1)
        
        timerLabelDay.text = "\(differentTime.day!)"
        let basicAnimation4 = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation4.toValue = (CGFloat(60) - CGFloat(differentTime.day!)) / CGFloat(60)
        if differentTime.day == 59 {
            basicAnimation4.fromValue = 0}
        
        basicAnimation4.isRemovedOnCompletion = false
        basicAnimation4.fillMode = .forwards
        
        if  differentTime.day == 0 {
            let strokeStartAnimation4 = CABasicAnimation(keyPath: "strokeStart")
            
            strokeStartAnimation4.toValue = 1
            strokeStartAnimation4.fromValue = 0
            strokeStartAnimation4.duration = 1
            
            shapeLayerD.add(strokeStartAnimation4, forKey: "strokeStart")
            
        }
        basicAnimation4.duration = 1
        shapeLayerD.add(basicAnimation4, forKey: nil)
        
        
    
        self.view.backgroundColor = UIColor.black
        
    
       
        
//        func createBtnVC4() {
//
//            self.buttonVC4 = UIButton(type: .system)
//            self.buttonVC4.setTitle("fighters", for: .normal)
//            buttonVC4.frame = CGRect(x: 50, y: 750, width: 300, height: 50)
//
//
//            buttonVC4.titleLabel?.font = UIFont(name: "a_BosaNova", size: 22)
//            buttonVC4.setTitleColor(.black, for: .normal)
//            buttonVC4.backgroundColor = UIColor(white: 1, alpha: 0.5)
//
//            buttonVC4.layer.cornerRadius = 20
//            //        showAlert.titleLabel?.font = .systemFont(ofSize: 20)
//            buttonVC4.layer.borderWidth = 2
//            buttonVC4.layer.borderColor = UIColor.white.cgColor
//            self.view.addSubview(buttonVC4)
//            self.buttonVC4.addTarget(self, action: #selector(goVC4), for: .touchUpInside)
//
//            let gradientLayer = CAGradientLayer()
//            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
//            gradientLayer.locations = [0, 0.5, 1]
//            gradientLayer.frame = buttonVC4.frame
//            gradientLayer.frame.origin = .zero
//            let angle =  135 * CGFloat.pi / 180
//            gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
//
//            //                 shinyTextlabel.layer.mask = gradientLayer
//            buttonVC4.layer.addSublayer(gradientLayer)
//            buttonVC4.layer.masksToBounds = true
//
//
//
//            //        animation
//
//            let animation = CABasicAnimation(keyPath: "transform.translation.x")
//
//            animation.fromValue = -CGFloat(400)
//            animation.toValue = CGFloat(400)
//            animation.repeatCount = Float.infinity
//            animation.duration = 1
//
//            gradientLayer.add(animation, forKey: "Doesn't metter")
//
//
//
//
//        }
        createBtnVC4()
        createBtnBack()
        
    }
    
    @objc func back () {
        dismiss(animated: true, completion:  didmissClosure)
        //    didmissClosure()
        
    }
    
    @objc func goVC4() {
        
      
        let tapBarContoller  = UITabBarController()
        tapBarContoller.tabBar.barTintColor = UIColor.black
        tapBarContoller.tabBar.tintColor = UIColor.yellow
        
        let govc5 = vc4()
        
        govc5.tabBarItem = UITabBarItem(title: "", image: UIImage.init(named: "спарринг"), tag: 0)
        
        let reit = Reitings()
        reit.tabBarItem = UITabBarItem(title: "", image: UIImage.init(named: "рейтинг"), tag: 1)
        
        let p4p = Favorites()
        p4p.tabBarItem = UITabBarItem(title: "", image: UIImage.init(named: "избранное"), tag: 2)
        
        tapBarContoller.viewControllers = [p4p, govc5, reit]
        
        
        
        present(tapBarContoller, animated: true, completion: nil)
        
     
    }
    func createBtnBack() {
               self.buttonVC3 = UIButton(type: .custom)
               self.buttonVC3.setTitle("BACK", for: .normal)
               self.buttonVC3.titleLabel?.font = UIFont(name: "a_BosaNova", size: 22)
               self.buttonVC3.setTitleColor(.white, for: .normal)
               self.buttonVC3.setTitleColor(.black, for: .highlighted)
//               self.buttonVC3.backgroundColor = UIColor(white: 1, alpha: 0.5)
               buttonVC3.frame = CGRect(x: 25, y: 30, width: 70, height: 50)
               self.buttonVC3.layer.cornerRadius = 15
               buttonVC3.setBackgroundImage(UIImage(named: "fon"), for: .normal)
               buttonVC3.setBackgroundImage(UIImage(named: "white"), for: .highlighted)
        
               buttonVC3.layer.masksToBounds = true
               
               
               buttonVC3.layer.borderWidth = 2
               buttonVC3.layer.borderColor = UIColor.white.cgColor
               self.view.addSubview(buttonVC3)
               self.buttonVC3.addTarget(self, action: #selector(back), for: .touchUpInside)
               
               
           }
    
    func createBtnVC4() {
              
              self.buttonVC4 = UIButton(type: .custom)
              self.buttonVC4.setTitle("fighters", for: .normal)
              buttonVC4.frame = CGRect(x: 50, y: 750, width: 300, height: 50)
              
              
              buttonVC4.setBackgroundImage(UIImage(named: "fon"), for: .normal)
              buttonVC4.setBackgroundImage(UIImage(named: "white"), for: .highlighted)
              buttonVC4.titleLabel?.font = UIFont(name: "a_BosaNova", size: 22)
              buttonVC4.setTitleColor(.white, for: .normal)
              buttonVC4.setTitleColor(.black, for: .highlighted)
              
              buttonVC4.layer.cornerRadius = 20
              buttonVC4.layer.borderWidth = 2
              buttonVC4.layer.borderColor = UIColor.white.cgColor
              self.view.addSubview(buttonVC4)
              self.buttonVC4.addTarget(self, action: #selector(goVC4), for: .touchUpInside)
             
              
              let gradientLayer = CAGradientLayer()
              gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
              gradientLayer.locations = [0, 0.5, 1]
              gradientLayer.frame = buttonVC4.frame
              gradientLayer.frame.origin = .zero
              let angle =  135 * CGFloat.pi / 180
              gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
              
            
              buttonVC4.layer.addSublayer(gradientLayer)
              buttonVC4.layer.masksToBounds = true
              
         
              
              //        animation
              
              let animation = CABasicAnimation(keyPath: "transform.translation.x")
              
              animation.fromValue = -CGFloat(400)
              animation.toValue = CGFloat(400)
              animation.repeatCount = Float.infinity
              animation.duration = 1
        
              gradientLayer.add(animation, forKey: "Doesn't metter")
    
}
}
