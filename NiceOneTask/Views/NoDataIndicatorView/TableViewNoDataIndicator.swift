//
//  SceneDelegate.swift
//  NiceOneTask
//
//  Created by Abdul Qadar on 12/30/23.
//

import UIKit

class TableViewNoDataIndicator: UIView {

    @IBOutlet weak var messageLabel: UILabel!

    var title: String? {
        didSet {
            messageLabel.text = title
        }
    }

    class func instanceFromNib() -> TableViewNoDataIndicator? {
        return UINib(nibName: String(describing: TableViewNoDataIndicator.self),
                     bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? TableViewNoDataIndicator
    }
}
