//
//  NullGridCollectionViewCell.swift
//  Podcast
//
//  Created by Natasha Armbrust on 11/2/17.
//  Copyright © 2017 Cornell App Development. All rights reserved.
//

import SnapKit
import UIKit

class NullGridCollectionViewCell: UICollectionViewCell {
    
    var plusImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGrey
        plusImageView = UIImageView(image: #imageLiteral(resourceName: "failure_icon"))
        addSubview(plusImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
