//
//  HeaderView.swift
//  NiceOneTask
//
//  Created by Abdul Qadar on 02/01/2024.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var lblTitle: UILabel!

    static var nibName : String {
        get { return "SectionHeaderView"}
    }

    static var reuseIdentifier: String {
        get { return "SectionHeaderView"}
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
