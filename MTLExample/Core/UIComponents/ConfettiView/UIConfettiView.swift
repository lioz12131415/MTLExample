//
//  UIConfettiView.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

class UIConfettiView: UIView {
    
    fileprivate var startBlock:  () -> Void = { }
    fileprivate var finishBlock: () -> Void = { }
    
    @discardableResult func didStart(_ block: @escaping() -> Void) -> Self {
        self.startBlock = block
        return self
    }
    
    @discardableResult func didFinish(_ block: @escaping() -> Void) -> Self {
        self.finishBlock = block
        return self
    }
    
    internal func fire(count:  Int,
                       colors: [UIColor],
                       images: [UIImage] = shapes(), lifeTime: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) { [weak self] in
            guard let self else {
                return
            }
            let emitter_cells = emitter_cells(count, colors, images, lifeTime)
            let emitter_layer = emitter_layer(emitter_cells)
            layer.addSublayer(emitter_layer)
            
            emitter_layer.setValue([
                CAEmitterAttractor()
                    .radius(150)
                    .stiffness(10)
                    .falloff(-140)
                    .z_position(-30)
                    .position(x: bounds.midX, y: bounds.maxY + 20)
                    .create()
            ], forKey: "emitterBehaviors")
            
            emitter_layer.birthRate((d: 1, f: 1, t: 0))
            emitter_layer.dragAnimation((d: 0.35, f: 0, t: 2))
            emitter_layer.attractor((d: 2, kt: [0, 0.4], v: [80, 5]))
            
            DispatchQueue.main.async { [weak self] in
                self?.startBlock()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + lifeTime) { [weak self] in
                self?.finishBlock()
                emitter_layer.removeFromSuperlayer()
            }
        }
    }
    
    fileprivate func emitter_cells(_ count:    Int,
                                   _ colors:   [UIColor],
                                   _ images:   [UIImage],
                                   _ lifeTime: TimeInterval) -> [CAEmitterCell] {
        return (0..<count).map { _ in
            let cell  = CAEmitterCell()
            let speed = -1.0/Float(lifeTime+0.1)
            
            cell.spin          = 4.0
            cell.spinRange     = 8.0
            cell.beginTime     = 0.1
            cell.birthRate     = 1.0
            cell.lifetime      = Float(lifeTime)
            cell.yAcceleration = 150.0
            cell.alphaSpeed    = speed
            
            cell.name          = UUID().uuidString
            cell.color         = colors.randomElement()?.cgColor
            cell.contents      = images.randomElement()?.cgImage
            cell.velocityRange = CGFloat.random(in: 500...1000)
            cell.emissionRange = CGFloat(Double.pi)
            
            cell.setValue("plane",       forKey: "particleType")
            cell.setValue(Double.pi,     forKey: "orientationRange")
            cell.setValue(Double.pi / 2, forKey: "orientationLongitude")
            cell.setValue(Double.pi / 2, forKey: "orientationLatitude")
            return cell
        }
    }
    
    fileprivate static func shapes(_ shapes: [Shape] = [.circle, .rectangle]) -> [UIImage] {
        return shapes.map { shape in
            UIGraphicsBeginImageContext(shape.rect.size)
            let context = UIGraphicsGetCurrentContext()!
            context.setFillColor(UIColor.white.cgColor)

            switch shape {
                case .circle:    context.fillEllipse(in: shape.rect)
                case .rectangle: context.fill(shape.rect)
            }

            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image!
        }
    }
    
    fileprivate func emitter_layer(_ cells: [CAEmitterCell]) -> CAEmitterLayer {
        let emitter = CAEmitterLayer()
        emitter.frame           = bounds
        emitter.birthRate       = .zero
        emitter.emitterSize     = CGSize(width: 1, height: 1)
        emitter.emitterPosition = CGPoint(x: bounds.midX, y: bounds.maxY)
        emitter.emitterCells    = cells
        emitter.masksToBounds   = true
    
        emitter.beginTime = CACurrentMediaTime()
        return emitter
    }
}

extension UIConfettiView {
    enum Shape {
        case circle
        case rectangle

        var rect: CGRect {
            switch self {
                case .circle:    return .init(x: 0, y: 0, width: 10, height: 10)
                case .rectangle: return .init(x: 0, y: 0, width: 20, height: 13)
            }
        }
    }
}

