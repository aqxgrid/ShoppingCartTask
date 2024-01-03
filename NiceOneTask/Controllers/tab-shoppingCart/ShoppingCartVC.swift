//
//  ShoppingCartVC.swift
//  NiceOneTask
//
//  Created by Abdul Qadar on 12/30/23.
//

import UIKit

class ShoppingCartVC: UIViewController {

    @IBOutlet weak var itemCollectionView: UICollectionView!
    @IBOutlet weak var label_totalResult: UILabel!
    let viewModel = ShoppingCartVM()
    let flowLayout = UICollectionViewFlowLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCustomProperties()
    }

    // MARK: - private methods
    func setupCustomProperties() {
        // viewModel.delegate = self
        itemCollectionView.registerCell(class: HeaderCollectionCell.self)
        itemCollectionView.registerCell(class: CartCollectionCell.self)
        itemCollectionView.register(UINib(nibName: SectionHeaderView.nibName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        productCollectionLayout()
    }

    //MARK:  Custom layout setup for collectionView

    func productCollectionLayout() {
        // Set the item size for each cell.
        flowLayout.itemSize = calculateCellSize()
        // Set the scroll direction to vertical.
        flowLayout.scrollDirection = .vertical
        // Set the collection view's layout to the flow layout.
        itemCollectionView.collectionViewLayout = flowLayout
        itemCollectionView.reloadData()
    }

    func calculateCellSize() -> CGSize {
        // Set the spacing between cells and sections.
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        // Calculate the cell width based on the number of items per row.
        let numberOfItemsPerRow: CGFloat = 3
        let totalSpacing = (numberOfItemsPerRow - 1) * flowLayout.minimumInteritemSpacing
        let cellWidth = (itemCollectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        // Calculate the cell height (assuming all cells have the same height for simplicity).
        let cellHeight: CGFloat = 175.0 // Set your desired cell height here
        return CGSize(width: cellWidth, height: cellHeight)
    }

    // MARK: IBActions
    @IBAction func didTapShareButton(_ sender: UIButton) {
        /// Any further action can be added here for Share button functionality
    }

    @IBAction func didTapCheckOutButton(_ sender: UIButton) {
        /// Any further action can be added here for CheckOut button functionality
    }
}

//MARK: CollectionView delegate
extension ShoppingCartVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0, 1:
            return CGSize(width: UIScreen.main.bounds.size.width, height: 145.0)
        default:
            return calculateCellSize()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return viewModel.cartResponse?.data?.cart?.products?.count ?? 0
        default:
            return viewModel.cartResponse?.data?.recommended_products?.products?.count ?? 0
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch indexPath.section {
        case 0:
            guard let headerCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCollectionCell", for: indexPath) as? HeaderCollectionCell else {
                fatalError("Unable to deque reusable cell with identifier \(CartCollectionCell.self)") }
            return headerCollectionCell
        case 1:
            guard let cartCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartCollectionCell", for: indexPath) as? CartCollectionCell else {
                fatalError("Unable to deque reusable cell with identifier \(CartCollectionCell.self)") }
            // Configure cart cell
            if let cart = viewModel.cartResponse?.data?.cart?.products?[indexPath.row] {
                cartCollectionCell.configureCellWithData(item: cart)
            }
            cartCollectionCell.delegate = self
            return cartCollectionCell
        default:
            guard let productCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionCell", for: indexPath) as? ProductCollectionCell else {
                fatalError("Unable to deque reusable cell with identifier \(ProductCollectionCell.self)") }
            // Configure product cell
            if let recommendedProducts = viewModel.cartResponse?.data?.recommended_products?.products?[indexPath.row] {
                productCollectionCell.recommendProductName.text = recommendedProducts.name
                productCollectionCell.recommendProductPrice.text = recommendedProducts.price_formated
            }
            return productCollectionCell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeaderView", for: indexPath) as! SectionHeaderView
            sectionHeaderView.lblTitle.text = "Products you may like"
            return sectionHeaderView

        default:
            fatalError("Unexpected element kind")
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 2 {
            return CGSize(width: collectionView.bounds.width, height: 50)
        }
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}

extension ShoppingCartVC: ShoppingCartVMDelegate {
    /// This viewModelDelegate will be using for any communication of viewController with viewModel of Shopping cart flow.
}

extension ShoppingCartVC: CartCollectionCellDelegate {

    func didDeleteItem(tag: Int) {
        // Remove the that specific index item from the cartList in viewModel
        // ANd than specifically reload that section : The section value can be get from indexPath.section.
        /*
        viewModel.cartResponse?.data?.cart?.products?.remove(at: tag)
         ...
        */
    }

    func didAddItem() {
        // We can perform any further action or handling
    }

    func didRemoveItem() {
        // We can perform any further action or handling
    }
}
