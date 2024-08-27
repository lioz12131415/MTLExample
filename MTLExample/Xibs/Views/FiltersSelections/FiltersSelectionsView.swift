//
//  FiltersSelectionsView.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

class FiltersSelectionsView: UIXibView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate lazy var values:  [Filter]  = []
    fileprivate lazy var observer: Observer = Observer()
    
    internal var observe: FiltersSelectionsObserve {
        return observer
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(nibName: "FilterSelectionCell")
        collectionView.delegate   = self
        collectionView.dataSource = self
    }
    
    internal func setup(_ filters: MTLFilters?) {
        values = [
            Filter("blur",         "blur_filter_icon",         filters?.blur),
            Filter("noir",         "noir_filter_icon",         filters?.noir),
            Filter("sharpen",      "sharpen_filter_icon",      filters?.sharpen),
            Filter("vignette",     "vignette_filter_icon",     filters?.vignette),
            Filter("brightness",   "brightness_filter_icon",   filters?.brightness),
            Filter("quantization", "quantization_filter_icon", filters?.quantization),
        ]
        collectionView.reloadData()
    }
}

extension FiltersSelectionsView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        observer.didSelect(values[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return values.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterSelectionCell", for: indexPath) as! FilterSelectionCell
        
        cell.filter = values[indexPath.row]
        return cell
    }
}
