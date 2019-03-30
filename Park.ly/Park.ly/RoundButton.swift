//
//  RoundButton.swift
//  Park.ly
//
//  Created by Julian Mino on 3/30/19.
//  Copyright © 2019 Julian Mino. All rights reserved.
//

import UIKit

class RoundButton: UIButton {

    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.shadowRadius = 20
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor.black.cgColor
    }
}
