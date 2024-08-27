//
//  SelectionCell.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit

class SelectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
        
    internal var selectionName: String = .empty {
        didSet { setInfo() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.animations.press
            .set(scale: 0.90)
            .set(duration: 0.30)
            .set(pressDuration: 0.01)
            .attach()
        
        self.contentView.animations.pressOverlay
            .set(duration: 0.30)
            .set(pressDuration: 0.01)
            .set(backgroundColor: UIColor.black.withAlphaComponent(0.3).cgColor)
            .attach()
        
    }
    
    @objc fileprivate func tapped(sender: UITapGestureRecognizer) {
        print(sender.state.rawValue)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    fileprivate func setInfo() {
        imageView.image = UIImage(named: selectionName)
    }
}
