//
//  SelectionsVC.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

class SelectionsVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate lazy var selections: [String] = [
        "00", "01", "02", "03", "04",
        "05", "06", "07", "08", "09",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate   = self
        collectionView.dataSource = self
    }
}

extension SelectionsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        EditorVC.show(over: navigationController, forSelected: selections[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectionCell", for: indexPath) as! SelectionCell
        
        cell.selectionName = selections[indexPath.row]
        return cell
    }
}

extension SelectionsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout)
        
        let l   = flowLayout.sectionInset.left
        let r   = flowLayout.sectionInset.right
        let w   = collectionView.frame.width-(l+r)
        let mis = flowLayout.minimumInteritemSpacing
        
        return .init(width:  (w/2)-((1.0/2.0)*mis),
                     height: (w/2)-((1.0/2.0)*mis))
    }
}
