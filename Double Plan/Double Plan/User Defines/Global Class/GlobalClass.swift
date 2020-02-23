//
//  GlobalClass.swift
//  Double Plan
//
//  Created by Prince Sojitra on 23/02/20.
//  Copyright © 2020 Prince Sojitra. All rights reserved.
//

import UIKit

//MARK: - ImageView
class ImgView :  UIImageView {
    @IBInspectable var cornerRadius: CGFloat = 0.0
    @IBInspectable var borderColor: UIColor = UIColor.clear
    @IBInspectable var borderWidth : CGFloat = 0.0
    
    override func awakeFromNib() {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth;
        self.clipsToBounds = true
    }
    
    
}
//MARK: - UIButton
class BtnActiton :  UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0.0
    @IBInspectable var borderColor: UIColor = UIColor.clear
     @IBInspectable var borderWidth : CGFloat = 0.0
    
    override func awakeFromNib() {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth;
        self.clipsToBounds = true
    }
}
