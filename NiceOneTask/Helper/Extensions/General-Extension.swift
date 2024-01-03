//
//  ShoppingCartViewModel.swift
//  NiceOneTask
//
//  Created by Abdul Qadar on 12/30/23.
//

/// NOTE: Just keeping all type of extension in one file because of the task limit
import Foundation
import UIKit

extension UITableView {

    func registerCell<T: UITableViewCell>(class: T.Type) {
        self.register(UINib(nibName: T.className(), bundle: nil),
                           forCellReuseIdentifier: T.className())
    }

    func registerHeaderFooter<T: UITableViewHeaderFooterView>(class: T.Type) {
        let headerNib = UINib(nibName: T.className(), bundle: Bundle.main)
        self.register(headerNib, forHeaderFooterViewReuseIdentifier: T.className())
    }

    /*
    func dequeReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to deque reusable cell with identifier "+T.reuseIdentifier)
        }
        return cell
    }
*/

    func dequeReusableHeaderFooter<T: UITableViewHeaderFooterView>() -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Unable to deque reusable headerFooter with identifier  "+T.reuseIdentifier)
        }
        return headerFooterView
    }

    func cellForRow<T: UITableViewCell>(atRow row: Int, inSection section: Int = 0) -> T? {
        return cellForRow(at: IndexPath(row: row, section: section)) as? T
    }

    func numberOfSections(sections: Int?, noDataTitle: String?) -> Int {
        return numberOfRows(rows: sections, noDataTitle: noDataTitle)
    }

    func numberOfRows(rows: Int?, noDataTitle: String?) -> Int {
        if let rows = rows, rows > 0 {
            self.backgroundView = nil
            return rows
        }
        self.addBackgroundView(title: noDataTitle.orEmpty)
        return 0
    }

    func addBackgroundView(title: String) {
        if let noDataView = TableViewNoDataIndicator.instanceFromNib() {
            noDataView.title = title
            self.backgroundView = noDataView
        }
    }
}

extension UICollectionView {

    func registerCell<T: UICollectionViewCell>(class: T.Type) {
        self.register(UINib(nibName: T.className(), bundle: nil), forCellWithReuseIdentifier: T.className())
    }
}

extension NSObject {
    static func className() -> String {
        return String(describing: self)
    }
}

protocol ReusableView {
    static var reuseIdentifier: String {get}
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView: ReusableView {
}

extension Optional where Wrapped == String {

    var orEmpty: String {
        return self ?? ""
    }

    var notEmpty: Bool {
        return !isEmpty
    }

    var isEmpty: Bool {
        return self.orEmpty.byRemovingWhiteSpaces().isEmpty
    }

    var orDash: String {
        return (self != nil && self.notEmpty) ? self.orEmpty : "-"
    }

    var orZero: String {
        return self ?? "0"
    }

    var orNotApplicable: String {
        return (self != nil && self.notEmpty) ? self.orEmpty : "N/A"
    }

    func doubleValue() -> Double {
        // remove comma "," from value if any
        let newStr = self?.replacingOccurrences(of: ",", with: "")
        return (newStr as NSString?)?.doubleValue ?? 0
    }
}

extension Optional where Wrapped == Double {
    var orZero: Double {
        return self ?? 0
    }
}

extension Optional where Wrapped == Int {

    var orZero: Int {
        return self ?? 0
    }
}

extension Optional where Wrapped == Bool {

    var orFalse: Bool {
        return self ?? false
    }

    var orTrue: Bool {
        return self ?? true
    }
}

extension Optional where Wrapped == Date {

    var orCurrent: Date {
        return self ?? Date()
    }
}

extension Optional where Wrapped: Collection {
    // returns an empty Array if given collection is nil
    var orEmptyArray: [Wrapped.Element] {
        return self as? [Wrapped.Element] ?? []
    }
}

extension String {

    var localized: String {
        return self.localize()
    }

    var notEmpty: Bool {
        return !self.isEmpty
    }

    func localize(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }

    func floatValue() -> Float {
        return Float(self.replacingOccurrences(of: ",", with: ""))!
    }

    func intValue() -> Int {
        return Int(self) ?? 0
    }

    func doubleValue() -> Double {
        if let value = (self as NSString?)?.doubleValue {
            return value
        }
        return 0.0
    }

    func asData() -> Data {
        return String(self).data(using: .utf8) ?? Data()
    }

    func caseInsensitiveEqual(to other: String) -> Bool {
        return self.localizedCaseInsensitiveCompare(other) == .orderedSame
    }

    func byReplacingDoubleQuotes() -> String {
        // replacing latin char of double quotes with standard double quotes using escape sequence
        return self.replacingOccurrences(of: "”", with: "\"")
    }

    /// A function that removes leading and trailing white space characters from the string
    /// - Returns: Updated string without white space characters
    func byRemovingWhiteSpaces() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func containsValue(_ value: String) -> Bool {
        return self.localizedCaseInsensitiveContains(value)
    }

    func removeSpecialCharacters() -> String {
        let allowedCharacters = CharacterSet.alphanumerics.union(CharacterSet.whitespaces)
        return self.components(separatedBy: allowedCharacters.inverted).joined()
    }
}

extension UIView {

    @IBInspectable var viewBorderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable var viewBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var ViewCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
}
