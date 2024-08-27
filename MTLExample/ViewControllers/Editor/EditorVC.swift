//
//  EditorVC.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

class EditorVC: UIViewController {
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var imageView:  UIImageView!
    
    @IBOutlet weak var filterRangesView:      FilterRangesView!
    @IBOutlet weak var filtersSelectionsView: FiltersSelectionsView!
 
    fileprivate var selected: String = .empty {
        didSet { }
    }
    
    fileprivate var edited: UIImage? {
        imageView.metal.filters?.filtered
    }
    
    fileprivate var source: UIImage? {
        imageView.metal.filters?.source
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.observe()
    }
    
    fileprivate func setup() {
        imageView.image = UIImage(named: selected)
        
        changeState(for: true, and: false, with: nil)
        filtersSelectionsView.setup(imageView.metal.filters)
    }
    
    fileprivate func observe() {
        filterRangesView.observe
            .save { [weak self] in self?.changeState(for: true, and: false, with: nil) }
    
        filterRangesView.observe
            .close { [weak self] in self?.changeState(for: true, and: false, with: nil) }
        
        filtersSelectionsView.observe
            .didSelect { [weak self] f in self?.changeState(for: false, and: true, with: f) }
    }
    
    fileprivate func changeState(for ranges: Bool, and selections: Bool, with filter: Filter?) {
        filterRangesView.set(selected: filter)
        
        bottomView.isHidden            = !ranges
        filterRangesView.isHidden      = ranges
        filtersSelectionsView.isHidden = selections
    }
    
    @IBAction func backTouch(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextTouch(_ sender: UIButton) {
        EditedVC.show(over: navigationController, with: edited, and: source)
    }
}

extension EditorVC {
    internal static func show(over nav: UINavigationController?, forSelected name: String) {
        let storyboard = UIStoryboard(name: "Editor", bundle: nil)
        let navigation = storyboard.instantiateInitialViewController() as! UINavigationController
        let controller = navigation.viewControllers.first as! EditorVC
        
        controller.selected = name
        nav?.pushViewController(controller, animated: true)
    }
}

