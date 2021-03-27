//
//  File.swift
//  AppStore
//
//  Created by Ahmad Khalil on 7/27/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String , font : UIFont ,numberOfLines : Int = 1 ,fontcolor : UIColor? = nil ){
        self.init(frame:.zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
        if let fontColor = fontcolor {
            self.textColor = fontColor
        }
    }
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat = 0  , image : UIImage? = nil) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFit
        if let image = image {
            self.image = image
        }
    }
}

extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
    
    func creatShadow(){
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = .init(width: 0, height: 10)
        layer.shadowRadius = 5
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
extension UITabBarItem {
    convenience init(selectedimage : UIImage , image : UIImage , tag : Int){
        self.init(title: nil , image : image , tag: tag)
        self.selectedImage = selectedimage
    }
}

extension UIStackView {
    convenience init(verticalStackedViews : [UIView] , spacing : CGFloat? = nil , distrubtion : UIStackView.Distribution = .fill ){
        self.init(arrangedSubviews: verticalStackedViews)
        if let spacing = spacing {
            self.spacing = spacing
        }
        self.alignment = .leading
        self.axis = .vertical
        self.distribution = distrubtion
        
    }
    convenience init(horizontalStackedViews : [UIView] , spacing : CGFloat? = nil , distrubtion : UIStackView.Distribution = .fill ){
        self.init(arrangedSubviews: horizontalStackedViews)
        if let spacing = spacing {
            self.spacing = spacing
        }
        self.alignment = .center
        self.axis = .horizontal
        self.distribution = distrubtion
        
    }
}
