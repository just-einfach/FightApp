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

                circle.frame = CGRect(origin: .zero, size: stratingSize)
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                circle.backgroundColor = circleColor

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


            
            
func frameForCircle (withViewCenter viewCenter: CGPoint, size viewSize: CGSize, startPoint: CGPoint) -> CGRect {
    let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
    let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)

    let offestVector = sqrt(xLength * xLength + yLength * yLength) * 2
    let size = CGSize(width: offestVector, height: offestVector)
    return CGRect(origin: CGPoint.zero, size: size)
}



}


