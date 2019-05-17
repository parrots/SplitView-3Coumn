//
//  ViewController.swift
//  SplitTester
//
//  Created by Curtis Herbert on 4/29/19.
//  Copyright © 2019 Curtis Herbert. All rights reserved.
//

import UIKit

final class SummaryViewController: UIViewController {

    @IBOutlet private weak var showButton: UIButton?
    @IBOutlet private weak var summaryTitle: UILabel?
    
    var selectedIndex: Int = 0 {
        didSet {
            self.summaryTitle?.text = "Summary VC \(selectedIndex)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.summaryTitle?.text = "Summary VC \(selectedIndex)"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Runs" {
            let runsAndLiftsVC = segue.destination as? RunsAndLiftsViewController
            runsAndLiftsVC?.selectedIndex = self.selectedIndex
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        configureShowRunsButton()
    }
    
    private func configureShowRunsButton() {
        showButton?.isHidden = UIApplication.shared.delegate?.window??.rootViewController?.traitCollection.horizontalSizeClass == .regular
    }

}
