//
//  MainDashboardVC.swift
//  NiceOneTask
//
//  Created by Abdul Qadar on 12/29/23.
//

import UIKit

class MainDashboardVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 3  /// By Default shoppingCart tab will be open
        self.addLineSeparator()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    // MARK: Custom Method

    /// This function will add a separation layer between TabBar and Upper content.
    func addLineSeparator() {
        let lineSeparator = CALayer()
        lineSeparator.frame = CGRect(x: 0, y: 0, width: self.tabBar.frame.width, height: 0.5)
        lineSeparator.backgroundColor = UIColor.opaqueSeparator.cgColor
        self.tabBar.layer.addSublayer(lineSeparator)
    }
}
