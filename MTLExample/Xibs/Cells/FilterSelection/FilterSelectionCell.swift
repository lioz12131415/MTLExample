//
//  FilterSelectionCell.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

class FilterSelectionCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel:     UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    internal var filter: Filter = .empty {
        didSet { setInfo() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /* */
    }
    
    fileprivate func setInfo() {
        nameLabel.text      = filter.name
        iconImageView.image = UIImage(named: filter.icon)
    }
}
