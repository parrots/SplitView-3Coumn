//
//  ActivitySplitViewController.swift
//  SplitTester
//
//  Created by Curtis Herbert on 4/29/19.
//  Copyright © 2019 Curtis Herbert. All rights reserved.
//

import Foundation
import UIKit

final class ActivityDetailsSplitViewController: UISplitViewController {
    
    var summaryViewController: SummaryViewController? {
        let navController = self.viewControllers.first as? UINavigationController
        return navController?.viewControllers.first as? SummaryViewController
    }
    
    var runsAndLiftsViewController: RunsAndLiftsViewController? {
        let navController = self.viewControllers[self.viewControllers.count - 1] as? UINavigationController
        return navController?.viewControllers.first as? RunsAndLiftsViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredDisplayMode = .allVisible
        definesPresentationContext = true
        presentsWithGesture = false
        self.calculateSplitPosition()
        self.runsAndLiftsViewController?.delegate = self
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.calculateSplitPosition()
    }
    
    private func calculateSplitPosition() {
        guard let runsAndLiftsViewController = self.runsAndLiftsViewController else { return }
        if runsAndLiftsViewController.isExpanded {
            maximumPrimaryColumnWidth = 0
            return
        }
        
        //landscape and portrait have different default primary column widths. Unfortunately, setting something like UISplitViewController.automaticDimension + 30 doesn't work here.
        maximumPrimaryColumnWidth = UIDevice.current.orientation.isLandscape ? 410 : 360
        preferredPrimaryColumnWidthFraction = 0.5
    }
}

extension ActivityDetailsSplitViewController: RunsAndLiftsViewControllerDelegate {
    
    func toggleSplit(expanded: Bool, on runsAndLiftsViewController: RunsAndLiftsViewController) {
        var columnWidth: CGFloat
        if expanded {
            columnWidth = UIDevice.current.orientation.isLandscape ? 410 : 360
        } else {
            columnWidth = 0
        }
        
        let animator = UIViewPropertyAnimator(duration: 0.35, dampingRatio: 0.7) {[weak self] in
            self?.maximumPrimaryColumnWidth = columnWidth
        }
        animator.startAnimation()
    }
    
}
