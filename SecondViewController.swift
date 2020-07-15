//
//  ViewController.swift
//  FIGHT!
//
//  Created by   Vlad on 04.05.2020.
//  Copyright © 2020   Vlad. All rights reserved.
//

import UIKit
import AVFoundation



class SecondViewController: UIViewController,UIViewControllerTransitioningDelegate, UITableViewDelegate, UITableViewDataSource {

    
    var player = AVAudioPlayer()
    
    let transition = CircularTransition()
    
    let picker = UIDatePicker()
    
    let userDefaults = UserDefaults.standard
    
    let userCalendar = Calendar.current

    
    var myTableView = UITableView()
    
    let indentifire = "MyCell"
    
    var object = ["cell"]
    
    let changeButton  = UIButton()
    
    let lableDate = UILabel()
    
    let fightLabel = UILabel()
    
    private  var alertView: AlertView!
   
    let fightDate = Date()


    
    @IBOutlet weak var showAlert: UIButton!
    
 
//    MARK: VisualEffect
    var visualEffecyView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTable()
        createShimmer()
        createPlayer()
        setupVisualEffecyView()
        createChangeButton()
        createLableDate()
        createFightLabel()
       
        
    }
       
        func createTable() {
            
            self.myTableView = UITableView(frame: view.bounds, style: .plain)
            myTableView.register(UITableViewCell.self, forCellReuseIdentifier: indentifire)
            self.myTableView.delegate = self
            self.myTableView.dataSource = self
            myTableView.backgroundColor = .clear
            myTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(myTableView)
        }
        

//        shimmer
    
    func createShimmer() {
        showAlert.setTitle("MORE", for: .normal)
        showAlert.titleLabel?.font = UIFont(name: "a_BosaNova", size: 22)
        showAlert.setTitleColor(.white, for: .normal)
        showAlert.setTitleColor(.black, for: .highlighted)
//        showAlert.backgroundColor = UIColor(white: 1, alpha: 0.5)
        showAlert.frame = CGRect(x: 50, y: 750, width: 300, height: 50)
        showAlert.layer.cornerRadius = 20
        showAlert.layer.borderWidth = 2
        showAlert.layer.borderColor = UIColor.white.cgColor
        
        showAlert.setBackgroundImage(UIImage(named: "white"), for: .highlighted)
            
              
               showAlert.setBackgroundImage(UIImage(named: "fon"), for: .normal)
               
            
           
               changeButton.layer.masksToBounds = true
               
              
        
       

        //        gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.frame = showAlert.frame
        gradientLayer.frame.origin = .zero
        let angle =  135 * CGFloat.pi / 180
        gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)


        showAlert.layer.addSublayer(gradientLayer)
        showAlert.layer.masksToBounds = true



//                animation

        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue = -CGFloat(400)
        animation.toValue = CGFloat(400)
        animation.repeatCount = Float.infinity
        animation.duration = 1
        gradientLayer.add(animation, forKey: "Doesn't metter")


      view.bringSubviewToFront(showAlert)

    
    }
            
        
        
        
//player
            func createPlayer() {
        
        do {
            if let audio = Bundle.main.path(forResource: "theme", ofType: "mp3") {
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audio))
            }
        } catch  {
            print ("error")
        }
        self.player.play()
        
            }

        

    
        
    func createChangeButton() {
        self.changeButton.setTitle("change date", for: .normal)
        self.changeButton.frame = CGRect(x: 120, y: 300, width: 150, height: 50)
//        changeButton.backgroundColor = UIColor(white: 1, alpha: 0.5)
        changeButton.setBackgroundImage(UIImage(named: "fon"), for: .normal)
        changeButton.setBackgroundImage(UIImage(named: "white"), for: .highlighted)
        changeButton.titleLabel?.font = UIFont(name: "a_BosaNova", size: 20)
        changeButton.setTitleColor(.white, for: .normal)
        changeButton.setTitleColor(.black, for: .highlighted)
        changeButton.layer.cornerRadius = 20
        changeButton.layer.masksToBounds = true
        
        changeButton.layer.borderWidth = 2
        changeButton.layer.borderColor = UIColor.white.cgColor
        
        view.addSubview(changeButton)
        
        changeButton.addTarget(self, action: #selector(deleteDate), for: .touchUpInside)
        
        picker.date = Date()
        
        
        picker.frame = CGRect(x: 50, y: 50, width: 320, height: 216)
        picker.setValue(UIColor.white, forKey: "textColor")
        
        
        
            
        picker.datePickerMode = .dateAndTime
        
        self.view.addSubview(picker)
        
        picker.addTarget(self, action: #selector(pickerData), for: .valueChanged)
        
        
        if let pick = userDefaults.object(forKey: "picker") as? Date {
            
            lableDate.text = DateFormatter.localizedString(from: pick, dateStyle: .medium, timeStyle: .medium)
            
            fightLabel.alpha = 1
            picker.alpha = 0
            
            
            
        }else{
            
            changeButton.alpha = 0
            lableDate.alpha = 0
            fightLabel.alpha = 0
            
            
        }
    }
        
    func createLableDate() {
        self.lableDate.frame = CGRect(x: 0, y: 180, width: 420, height: 100)
        self.lableDate.backgroundColor = UIColor(white: 1, alpha: 0.8)
        self.lableDate.textAlignment = .center
        self.lableDate.font = UIFont(name: "a_BosaNova", size: 34)
        self.lableDate.textColor = .tungsten
        self.lableDate.shadowOffset = CGSize(width: 1, height: 1)
        self.lableDate.shadowColor = .tungsten
        view.addSubview(lableDate)
        
    }
         
        func createFightLabel() {
        self.fightLabel.frame = CGRect(x: 0, y: 140, width: 420, height: 40)
        self.fightLabel.backgroundColor = .black
        self.fightLabel.text = "NEXT EVENT:"
        self.fightLabel.textColor = .white
        self.fightLabel.textAlignment = .center
        self.fightLabel.font = UIFont(name: "a_BosaNova", size: 30)
        view.addSubview(fightLabel)
        }
        
        

    
    @objc func deleteDate() {
        userDefaults.removeObject(forKey: "picker")
        changeButton.alpha = 0
        lableDate.alpha = 0
        picker.alpha = 1
        fightLabel.alpha = 0
    }
    @objc func pickerData(paramTarget:UIDatePicker) {
        if paramTarget.isEqual(self.picker) {
            userDefaults.setValue(picker.date, forKey: "picker")
            self.lableDate.text = DateFormatter.localizedString(from: picker.date, dateStyle: .medium, timeStyle: .medium)
            
            print("Date save")
        }
        
        
      
        
    }
   
    
    func setupVisualEffecyView() {
        
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        visualEffecyView = view
        self.view.addSubview(visualEffecyView)
        
        
        
        self.visualEffecyView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.visualEffecyView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.visualEffecyView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.visualEffecyView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.visualEffecyView.alpha = 0
    }
    
    func setAlert() {
        
        alertView = AlertView.loadFromNib()
        setupVisualEffecyView()
        view.addSubview(alertView)
        alertView.center = view.center
        
        alertView.set(title: "Уже скоро! 🔥", body: "Не пропусти главное событие года в мире смешанных единоборств!", buttons: "ОК")
        alertView.titleLabel.font = UIFont(name: "a_BosaNova", size: 25)
        //        alertView.titleLabel.textColor = UIColor.white
        alertView.bodyLabel.font = UIFont(name: "a_BosaNova", size: 20)
        //        alertView.bodyLabel.textColor = UIColor.white
        alertView.button.setTitleColor(UIColor.white, for: .normal)
        alertView.button.titleLabel?.font = UIFont(name: "a_BosaNova", size: 25)
        alertView.button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
    }
    func animatedIn() {
        alertView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        alertView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffecyView.alpha = 1
            self.alertView.alpha = 1
            self.alertView.transform = CGAffineTransform.identity
        }
        
        
    }
    
    
    
    @objc func buttonPress() {
        
        guard  let datePick = userDefaults.object(forKey: "picker") as? Date else {return}
        
        scheduleNotification(datePick) {(success) in
            if success {
                print ("Done")
                
            }else{
                print ("failed")
            }
        }
        
        //        let alertController = UIAlertController(title: "Jr", message: "ffdf", preferredStyle: .alert)
        //
        //       let tableVC = UITableViewController(style: .plain)
        
        let newVC = TimerViewController(fightDate: datePick, didmissClosure: {[weak self] in
            UIView.animate(withDuration: 1, animations: {
                self?.alertView.alpha = 0
                self?.visualEffecyView.alpha = 0
            }) { (_) in
                 self?.alertView.removeFromSuperview()
                           self?.visualEffecyView.removeFromSuperview()
            }
           
        
            
            
        })
        
        
        //      navigationController?.pushViewController(newVC, animated: true)
        //
        //        let viewController = UIViewController()
        newVC.transitioningDelegate = self
        present(newVC, animated: true, completion: nil)
        
        changeButton.alpha = 1
        lableDate.alpha = 1
        picker.alpha = 0
        fightLabel.alpha = 1
        
        
        
    }
    
    
    
    
    @IBAction func showAlert(_ sender: Any) {
        
        
        setAlert()
        animatedIn()
        
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        
        transition.startingPoint = presenting.view.convert(alertView.button.center, from: alertView)
        transition.stratingSize = alertView.button.frame.size
        
        transition.circleColor = .black
        return transition
        
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = self.view.convert(alertView.button.center, from: alertView)
        transition.stratingSize = alertView.button.frame.size
        
        
        return transition
    }
    
    
//    MARK: Notification
    
    func scheduleNotification(_ fightDay: Date, completion: (Bool) -> ()){
        
        removeNotification(withIndentifiers: ["indetifier"])
        
        
        let content = UNMutableNotificationContent()
        content.title = "Кард начался!"
        content.body = "НЕ ПРОПУСТИ!"
        content.sound = UNNotificationSound.default
        
        
        
        let components = userCalendar.dateComponents([ .day, .hour, .minute, .second], from: fightDay)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: "indetifier", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
    }
    
    func   removeNotification(withIndentifiers indetifier: [String]) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: indetifier)
    }
    deinit {
        removeNotification(withIndentifiers: ["indetifier"])
        
        
        
    }
    
//     tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: indentifire, for: indexPath)
        cell.textLabel?.text = "-->"
        cell.textLabel?.textColor = .red
        cell.backgroundColor = .black
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let mute = playPause(at: indexPath)
        return UISwipeActionsConfiguration(actions: [mute])
    }
    func playPause(at indexPath: IndexPath) -> UIContextualAction {
        

        let action = UIContextualAction(style: .normal, title: "mute") { (action, view,complition) in
            if self.player.isPlaying == true {
                self.player.pause()
            }else{
                
                self.player.play()
                complition(true)
            }
        }
        
        action.backgroundColor = .black
        action.image = UIImage(named: "mute")
        return action
    }
}





