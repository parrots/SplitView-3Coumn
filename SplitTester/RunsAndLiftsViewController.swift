//
//  RunMapViewController.swift
//  SplitTester
//
//  Created by Curtis Herbert on 4/29/19.
//  Copyright © 2019 Curtis Herbert. All rights reserved.
//

import UIKit

protocol RunsAndLiftsViewControllerDelegate: class {
    func toggleSplit(expanded: Bool, on runsAndLiftsViewController: RunsAndLiftsViewController)
}

final class RunsAndLiftsViewController: UIViewController {
    
    @IBOutlet private weak var expandToggle: UIButton?
    @IBOutlet private weak var mapTitle: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapTitle?.text = "Map VC \(selectedIndex)"
    }
    
    var isExpanded: Bool = false {
        didSet {
            let expandLabelText = self.isExpanded ? "Show Summary" : "Expand"
            self.expandToggle?.setTitle(expandLabelText, for: .normal)
        }
    }
    
    weak var delegate: RunsAndLiftsViewControllerDelegate?
    
    var selectedIndex: Int = 0 {
        didSet {
            self.mapTitle?.text = "Map VC \(selectedIndex)"
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        configureExpandToggle()
    }
    
    private func configureExpandToggle() {
        expandToggle?.isHidden = UIApplication.shared.delegate?.window??.rootViewController?.traitCollection.horizontalSizeClass == .compact
    }
    
    @IBAction func toggleExpandedView(_ sender: Any) {
        self.delegate?.toggleSplit(expanded: self.isExpanded, on: self)
        self.isExpanded.toggle()
    }
    
}

