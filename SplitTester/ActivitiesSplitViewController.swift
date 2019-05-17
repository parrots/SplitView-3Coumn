//
//  ActivitiesSplitViewController.swift
//  SplitTester
//
//  Created by Curtis Herbert on 4/29/19.
//  Copyright © 2019 Curtis Herbert. All rights reserved.
//

import Foundation
import UIKit

final class ActivitiesSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    private var splitVC: ActivityDetailsSplitViewController?
    private var summaryVC: SummaryViewController?
    
    private var activityListVC: ActivityListViewController? {
        let navController = self.viewControllers.first as? UINavigationController
        return navController?.viewControllers.first as? ActivityListViewController
    }
    
    private var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        self.splitVC = mainStoryboard.instantiateViewController(withIdentifier: "ActivityDetailsSplitVC") as? ActivityDetailsSplitViewController
        self.summaryVC = mainStoryboard.instantiateViewController(withIdentifier: "SummaryViewController") as? SummaryViewController
        self.activityListVC?.delegate = self
        delegate = self
        preferredDisplayMode = .primaryOverlay
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return !(secondaryViewController is UISplitViewController)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.selectedIndex != 0 {
            let navController = self.viewControllers.first as? UINavigationController
            navController?.popToRootViewController(animated: false)
            self.setDetailView(with: IndexPath(row: self.selectedIndex, section: 0))
        } else if self.displayMode == .primaryHidden {
            if let action = self.displayModeButtonItem.action {
                let target = self.displayModeButtonItem.target
                UIApplication.shared.sendAction(action, to: target, from: nil, for: nil)
            }
        }
    }
    
    private func setDetailView(with index: IndexPath) {
        
        guard let runsAndLiftsVC = self.splitVC?.runsAndLiftsViewController, let summaryVC = self.summaryVC, let splitSummaryVC = self.splitVC?.summaryViewController, let splitVC = self.splitVC else { return }
        
        let action = self.displayModeButtonItem.action
        let target = self.displayModeButtonItem.target
        
        let backButton = UIBarButtonItem(image: UIImage(named: "splitViewIcon"), style: .plain, target: target, action: action)
        
        
        
        (splitVC.viewControllers.first! as! UINavigationController).viewControllers.first!.navigationItem.leftBarButtonItem = backButton
        
        self.selectedIndex = index.row
        
        //Configuring the child view controllers based on what gets tapped on the activity view. This allows us to set these views up on changes to traitCollection as well as when a timeline activity is tapped.
        let activityNumber = index.row + 1
        summaryVC.selectedIndex = activityNumber
        runsAndLiftsVC.selectedIndex = activityNumber
        splitSummaryVC.selectedIndex = activityNumber
        
        if runsAndLiftsVC.isExpanded {
            runsAndLiftsVC.toggleExpandedView(self)
        }
        
        if traitCollection.userInterfaceIdiom == .pad && traitCollection.horizontalSizeClass != .compact {
            // this 0 millisecond delay prevents an unwanted UIKit animation
            let deadlineTime = DispatchTime.now() + .milliseconds(000)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) { [weak self] in
                self?.showSummaryMap(with: splitVC)
            }   
        } else {
            self.showDetailViewController(summaryVC, sender: nil)
        }
    }
    
    private func showSummaryMap(with splitView: ActivityDetailsSplitViewController) {
        self.showDetailViewController(splitView, sender: nil)
    }
    
}

extension ActivitiesSplitViewController: ActivityListViewControllerDelegate {
    
    func didSelect(activity: IndexPath, on activityListViewController: ActivityListViewController) {
        self.setDetailView(with: activity)
    }
    
}
