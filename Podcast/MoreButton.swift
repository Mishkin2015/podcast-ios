//
//  MoreButton.swift
//  Podcast
//
//  Created by Mark Bryan on 4/27/17.
//  Copyright © 2017 Cornell App Development. All rights reserved.
//

import UIKit

class MoreButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(#imageLiteral(resourceName: "more_icon"), for: .normal)
        contentMode = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
