//
//  cell.swift
//  BahamaAirLoginScreen
//
//  Created by ine on 08/06/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import Foundation
import UIKit

let WigglingCollectionViewStartedMovingNotification = "WigglingCollectionView.StartedMoving"
let WigglingCollectionViewFinishedMovingNotification = "WigglingCollectionView.FinishedMoving"

class WigglingCollectionView: UICollectionView {
    
    var isWiggling: Bool { return _isWiggling }
    
    private var _isWiggling = false
    
    func beginInteractiveMovementForItem(indexPath: NSIndexPath) -> Bool {
        startWiggle()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WigglingCollectionViewStartedMovingNotification), object: self)
        return super.beginInteractiveMovementForItem(at: indexPath as IndexPath)
    }
    
    override func endInteractiveMovement() {
        super.endInteractiveMovement()
        stopWiggle()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WigglingCollectionViewFinishedMovingNotification), object: self)
    }
    
    // Wiggle code below from https://github.com/LiorNn/DragDropCollectionView
    
    private func startWiggle() {
        for cell in self.visibleCells {
            addWiggleAnimationToCell(cell: cell as UICollectionViewCell)
        }
        _isWiggling = true
    }
    
    private func stopWiggle() {
        for cell in self.visibleCells {
            cell.layer.removeAllAnimations()
        }
        _isWiggling = false
    }
    
    private func addWiggleAnimationToCell(cell: UICollectionViewCell) {
        CATransaction.begin()
        CATransaction.setDisableActions(false)
        cell.layer.add(rotationAnimation(), forKey: "rotation")
        cell.layer.add(bounceAnimation(), forKey: "bounce")
        CATransaction.commit()
    }
    
    private func rotationAnimation() -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        let angle = CGFloat(0.04)
        let duration = TimeInterval(0.1)
        let variance = Double(0.025)
        animation.values = [angle, -angle]
        animation.autoreverses = true
        animation.duration = self.randomizeInterval(interval: duration, withVariance: variance)
        animation.repeatCount = Float.infinity
        return animation
    }
    
    private func bounceAnimation() -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        let bounce = CGFloat(3.0)
        let duration = TimeInterval(0.12)
        let variance = Double(0.025)
        animation.values = [bounce, -bounce]
        animation.autoreverses = true
        animation.duration = self.randomizeInterval(interval: duration, withVariance: variance)
        animation.repeatCount = Float.infinity
        return animation
    }
    
    private func randomizeInterval(interval: TimeInterval, withVariance variance:Double) -> TimeInterval {
        let random = (Double(arc4random_uniform(1000)) - 500.0) / 500.0
        return interval + variance * random;
    }
    
}
