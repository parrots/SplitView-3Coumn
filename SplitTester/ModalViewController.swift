//
//  ModalViewController.swift
//  SplitTester
//
//  Created by Joe on 5/13/19.
//  Copyright © 2019 Curtis Herbert. All rights reserved.
//

import UIKit

final class ModalViewController: UIViewController {

    @IBAction func closeModal(_ sender: Any) {
        //I don't love the idea of the modal dismissing itself here. But if you rotate/switch between split and non-split views, your presenting view controller may no longer be present when you dismiss.
        self.dismiss(animated: true, completion: nil)
    }

}
