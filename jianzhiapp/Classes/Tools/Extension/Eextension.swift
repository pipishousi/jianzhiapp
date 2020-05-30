//
//  Eextension.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/5/30.
//  Copyright © 2020 殷义军. All rights reserved.
//
import UIKit
extension CALayer {

    var borderColorWithUIColor : UIColor {

        set {

            self.borderColor = newValue.cgColor

        }

        get {

            return self.borderColorWithUIColor
        }
    }

}
