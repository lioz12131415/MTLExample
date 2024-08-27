//
//  EditedVC.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit

class EditedVC: UIViewController {
    
    @IBOutlet weak var imageView:    UIImageView!
    @IBOutlet weak var confettiView: UIConfettiView!
    
    fileprivate var source: UIImage? = nil
    fileprivate var edited: UIImage? = nil
    
    fileprivate var current: UIImage? {
        return edited == nil ? source : edited
    }
    
    fileprivate var colors: [UIColor] = [
        .init(hex: "E62046"), .init(hex: "6C3AE0"),
        .init(hex: "19B7DE"), .init(hex: "D1DFE6"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    fileprivate func setup() {
        imageView.image = current
        confettiView.fire(count: 1000, colors: source?.colors() ?? colors, lifeTime: 3.0)
    }
    
    @objc
    fileprivate func finishSaving(_ image: UIImage, error: Error?, context: UnsafeRawPointer) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backTouch(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveTouch(_ sender: UIButton) {
        current?.writeToSavedPhotosAlbum(self, selector: #selector(finishSaving(_:error:context:)))
    }
}

extension EditedVC {
    internal static func show(over nav: UINavigationController?, with edited: UIImage?, and source: UIImage?) {
        let storyboard = UIStoryboard(name: "Edited", bundle: nil)
        let navigation = storyboard.instantiateInitialViewController() as! UINavigationController
        let controller = navigation.viewControllers.first as! EditedVC
        
        controller.source = source
        controller.edited = edited
        nav?.pushViewController(controller, animated: true)
    }
}
