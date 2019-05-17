//
//  ActivityListViewController.swift
//  SplitTester
//
//  Created by Curtis Herbert on 4/29/19.
//  Copyright © 2019 Curtis Herbert. All rights reserved.
//

import UIKit

protocol ActivityListViewControllerDelegate: class {
    // just passing a simple index here as an example of data passing. You'll have to send whatever it is you need to configure the summary and deatail controllers.
    func didSelect(activity: IndexPath, on activityListViewController: ActivityListViewController)
}

final class ActivityListViewController: UITableViewController {
    
    weak var delegate: ActivityListViewControllerDelegate?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.traitCollection.horizontalSizeClass == .compact {
            guard let index = tableView.indexPathForSelectedRow else { return }
            tableView.deselectRow(at: index, animated: true)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = "Activity \(indexPath.row + 1)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let barButtonItem = self.splitViewController?.displayModeButtonItem, let action = barButtonItem.action, let target = barButtonItem.target {
            UIApplication.shared.sendAction(action, to: target, from: nil, for: nil)
        }
        self.delegate?.didSelect(activity: indexPath, on: self)
    }
    
}
