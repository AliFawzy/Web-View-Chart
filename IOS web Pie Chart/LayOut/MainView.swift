//
//  MainView.swift
//  E-Shops
//
//  Created by aly on 3/3/19.
//  Copyright © 2019 aly. All rights reserved.
//
import UIKit
@IBDesignable
class MainView: UIView{
    
  
  
    @IBInspectable var firstColor:UIColor=UIColor.clear{
        didSet{
            UpdateView()
        }
    }
    @IBInspectable var SecondColor:UIColor=UIColor.clear{
        didSet{
            UpdateView()
        }
    }
    override class var layerClass:AnyClass{
        get {
            return CAGradientLayer.self
        }
    }
    func UpdateView() {
        let Layer = self.layer as! CAGradientLayer
        Layer.colors = [firstColor.cgColor,SecondColor.cgColor]
    }
}

