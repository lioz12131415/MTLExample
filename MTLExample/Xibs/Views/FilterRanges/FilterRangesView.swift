//
//  FilterRangesView.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

class FilterRangesView: UIXibView {
    
    @IBOutlet weak var tableView:        UITableView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    fileprivate var selected:   Filter?  = nil
    fileprivate var observer:   Observer = Observer()
    fileprivate var properties: [MTLProperty] { selected?.properties ?? [] }
    
    internal var observe: FilterRangesObserve {
        return observer
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.register(nibName: "FilterRangeCell")
        tableView.delegate   = self
        tableView.dataSource = self
    }
    
    internal func set(selected filter: Filter?) {
        self.selected = filter
        self.selected?.save()
        self.tableView.reloadData()
        self.heightConstraint.constant = CGFloat(properties.count*60)+60
    }

    @IBAction func saveTouch(_ sender: UIButton) {
        observer.save()
    }
    
    @IBAction func closeTouch(_ sender: UIButton) {
        selected?.unsave()
        observer.close()
    }
}

extension FilterRangesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterRangeCell", for: indexPath) as! FilterRangeCell
        
        cell.property = properties[indexPath.row]
        return cell
    }
}

