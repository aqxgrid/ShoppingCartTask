//
//  CartCollectionCell.swift
//  NiceOneTask
//
//  Created by Abdul Qadar on 02/01/2024.
//

import UIKit

@objc protocol CartCollectionCellDelegate: AnyObject {

    func didDeleteItem(tag: Int)
    func didAddItem()
    func didRemoveItem() // Added these protocol for any further operations.
}

class CartCollectionCell: UICollectionViewCell {

    @IBOutlet weak var cartProductImage: UIImageView!
    @IBOutlet weak var cartProductName: UILabel!
    @IBOutlet weak var cartProductDescription: UILabel!
    @IBOutlet weak var cartProductSet: UILabel!
    @IBOutlet weak var cartProductPrice: UILabel!
    @IBOutlet weak var cartProductDiscountedPrice: UILabel!
    @IBOutlet weak var itemCountValue: UILabel!
    @IBOutlet weak var deletButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!

    weak var delegate: CartCollectionCellDelegate?

    var count = 0 {
        didSet {
            itemCountValue.text = "\(count)"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        count = 0
        // Initialization code
    }

    // MARK: Custom function
    func configureCellWithData(item: CartProduct) {
        /// For image fetching we can use multiple approaches like SDWebImage, KingFisher or may be a custom wrapper to handle downloading and local caching.
        //        cartProductImage.image = UIImage()
        cartProductName.text = item.name.orDash
        cartProductDescription.text = item.manufacturer_name.orDash
        cartProductSet.text = item.name.orDash
        cartProductPrice.text = item.price_formatted.orDash
        cartProductDiscountedPrice.text = item.total_formatted.orDash
    }

    //MARK: - IBActions
    @IBAction func didTapDeleteButton(_ sender: UIButton) {
        self.delegate?.didDeleteItem(tag: sender.tag)
    }

    @IBAction func didTapPlusIcon(_ sender: Any) {
        count += 1
//        self.delegate?.didAddItem()
    }

    @IBAction func didTapMinusIcon(_ sender: Any) {
        if count > 0 {
            count -= 1
        }
//        self.delegate?.didRemoveItem()
    }
}
