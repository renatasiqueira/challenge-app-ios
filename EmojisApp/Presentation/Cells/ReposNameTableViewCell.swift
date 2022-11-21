import Foundation
import UIKit

class ReposNameTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.textLabel?.numberOfLines = 0

        self.textLabel?.lineBreakMode = .byWordWrapping

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpCells(textField: String) {
        let splittedString = textField.split(separator: "/")

        self.textLabel?.text = String(splittedString[splittedString.count-1])
        self.backgroundColor = .clear

    }
}
