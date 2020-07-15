//
//  CircleTransitionAnimator.swift
//  DesignAlert
//
//  Created by   Vlad on 05.05.2020.
//  Copyright © 2020   Vlad. All rights reserved.
//

import UIKit

class CircularTransition: NSObject {

  
 var circle = UIView()
    var stratingSize = CGSize.zero
    var startingPoint = CGPoint.zero {
        didSet {
            circle.center = startingPoint
    }

}
    var circleColor = UIColor.white
    var duration = 1.0

    enum CircularTransitionMode: Int {
        case present, dismiss, pop
    }
    var transitionMode: CircularTransitionMode = .present
}


extension CircularTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                circle = UIView()
//                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                circle.frame = CGRect(origin: .zero, size: stratingSize)
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                circle.backgroundColor = circleColor
//                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(circle)

                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)

                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform(scaleX: 1160.0 / self.stratingSize.width, y: 1160.0 / self.stratingSize.width)
                    presentedView.transform = CGAffineTransform.identity
                    presentedView.alpha = 1
                    presentedView.center = viewCenter
                }, completion: { (success: Bool) in
                    transitionContext.completeTransition(success)

                })

            }
        
        }else{
   
    
            let transitionModeKey = (transitionMode == .pop) ?UITransitionContextViewKey.to : UITransitionContextViewKey.from

            if let returningView = transitionContext.view(forKey: transitionModeKey) {
                let viewCenter = returningView.center
                let ViewSize = returningView.frame.size

                circle.frame = frameForCircle(withViewCenter: viewCenter, size: ViewSize, startPoint: startingPoint)
//                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                UIView.animate(withDuration: duration, animations:  {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.transform = CGAffineTransform.init(scaleX: 0.001, y: 0.001)
                    returningView.center = self.startingPoint
                    returningView.alpha = 0
                    if self.transitionMode == .pop {
                        containerView.insertSubview(returningView, belowSubview: returningView)
                        containerView.insertSubview(self.circle, belowSubview: returningView)
                    }
                }, completion: { (success:Bool) in
                    returningView.center = viewCenter
                    returningView.removeFromSuperview()
                    self.circle.removeFromSuperview()
                    transitionContext.completeTransition(success)

           })
        }
            }
        }
//    }
    
    
//    }
//    let presentationStartButton: UIButton
//    init(presentationStartButton: UIButton) {
//        self.presentationStartButton = presentationStartButton
//
//    }
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let containerView = transitionContext.containerView
//   guard let presentedViewController = transitionContext.viewController(forKey: .to),
//        let presentedView = transitionContext.view(forKey: .to) else {
//            transitionContext.completeTransition(false)
//            return
//        }
//        let finalFrame = transitionContext.finalFrame(for: presentedViewController)
//
//        let startButtinFrame = presentationStartButton.convert(presentationStartButton.bounds, to: containerView)
//
//        let startButtonCenter = CGPoint(x: startButtinFrame.midX, y: startButtinFrame.midY)
//
//     let circleView = createCircleView(for: presentedView)
//
//
//        containerView.addSubview(circleView)
//        containerView.addSubview(presentedView)
//        presentedView.center = startButtonCenter
//        presentedView.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
//
//       circleView.center = presentedView.center
//        circleView.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
//
//        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
//            presentedView.transform = CGAffineTransform(scaleX: 1, y: 1)
//            presentedView.frame = finalFrame
//
//          circleView.transform = CGAffineTransform(scaleX: 1, y: 1)
//            circleView.center = presentedView.center
//        }) { (finished) in
//            transitionContext.completeTransition(finished)
//
//        }
//    }
//
//
//    func createCircleView (for view: UIView) -> UIView {
//        let d = sqrt(view.bounds.height * view.bounds.width + view.bounds.height * view.bounds.height)
//        let circleView = UIView(frame: CGRect(x: 0, y: 0, width: d, height: d))
//        circleView.layer.cornerRadius = d/2
//        circleView.layer.masksToBounds = true
//
////        circleView.backgroundColor = view.backgroundColor
//        return circleView
//    }
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return 0.5
//    }
            
            
func frameForCircle (withViewCenter viewCenter: CGPoint, size viewSize: CGSize, startPoint: CGPoint) -> CGRect {
    let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
    let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)

    let offestVector = sqrt(xLength * xLength + yLength * yLength) * 2
    let size = CGSize(width: offestVector, height: offestVector)
    return CGRect(origin: CGPoint.zero, size: size)
}



}

