//
//  FilterRangeCell.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

class FilterRangeCell: UITableViewCell {
    
    @IBOutlet weak var selectionNameLabel:   UILabel!
    @IBOutlet weak var selectionRangeSlider: UISlider!
    
    internal var property: MTLProperty? {
        didSet { setInfo() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    fileprivate func setInfo() {
        selectionNameLabel.text    = property?.meta.name
        selectionRangeSlider.value = property?.value ?? .zero
    }
    
    @IBAction func rangeChange(_ sender: UISlider) {
        property?.set(sender.value)
    }
}
