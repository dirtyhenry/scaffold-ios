//
//  MyView.swift
//  scaffold
//
//  Created by Mickaël Floc'hlay on 03/01/2020.
//  Copyright © 2020 mickf.net. All rights reserved.
//

import UIKit

class MyView: UIView {
    override func updateConstraints() {
        debugPrint("MyView updateConstraints \(self.frame)")
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        debugPrint("MyView layoutSubviews \(self.frame)")
        super.layoutSubviews()
    }
}
