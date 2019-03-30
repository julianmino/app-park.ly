//
//  ShadowImage.swift
//  Park.ly
//
//  Created by Julian Mino on 3/30/19.
//  Copyright © 2019 Julian Mino. All rights reserved.
//

import UIKit

class ShadowImage: UIImageView {

    override func awakeFromNib() {
        self.layer.shadowRadius = 20
        self.layer.shadowOpacity = 0.2
        self.layer.shadowColor = UIColor.black.cgColor
    }

}
