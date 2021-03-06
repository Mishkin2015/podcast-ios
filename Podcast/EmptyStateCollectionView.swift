//
//  EmptyStateCollectionView.swift
//  Podcast
//
//  Created by Natasha Armbrust on 10/28/17.
//  Copyright © 2017 Cornell App Development. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol EmptyStateCollectionViewDelegate: class {
    func emptyStateViewDidPressActionItem()
}

class EmptyStateCollectionView: UICollectionView, EmptyStateViewDelegate  {

    var type: EmptyStateType
    var emptyStateView: EmptyStateView!
    var loadingAnimation: NVActivityIndicatorView!
    weak var emptyStateCollectionViewDelegate: EmptyStateCollectionViewDelegate?
    
    init(frame: CGRect, type: EmptyStateType, collectionViewLayout: UICollectionViewLayout) {
        self.type = type
        super.init(frame: frame, collectionViewLayout: collectionViewLayout)
        emptyStateView = EmptyStateView(type: type)
        emptyStateView.mainView.isHidden = true 
        emptyStateView.delegate = self
        backgroundView = emptyStateView
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        
        loadingAnimation = createLoadingAnimationView()
        backgroundView!.addSubview(loadingAnimation)
        loadingAnimation.center = backgroundView!.center
        startLoadingAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard !loadingAnimation.isAnimating else { return }
        // make sure there is no data in tableView before displaying background
        for s in 0..<numberOfSections {
            if numberOfItems(inSection: s) > 0 {
                (backgroundView as! EmptyStateView).mainView.isHidden = true
                return
            }
        }
        (backgroundView as! EmptyStateView).mainView.isHidden = false
    }
    
    func stopLoadingAnimation() {
        loadingAnimation.stopAnimating()
        emptyStateView.mainView.isHidden = false
    }
    
    func startLoadingAnimation() {
        (backgroundView as! EmptyStateView).mainView.isHidden = true
        loadingAnimation.startAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didPressActionItemButton() {
        emptyStateCollectionViewDelegate?.emptyStateViewDidPressActionItem()
    }
    
    //this is a function extension because NVActivityIndicatorView is a final class so it cannot be subclassed
    func createLoadingAnimationView() -> NVActivityIndicatorView {
        let width: CGFloat = 30
        let height: CGFloat = 30
        let color: UIColor = .sea
        let type: NVActivityIndicatorType = .ballTrianglePath
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        return NVActivityIndicatorView(frame: frame, type: type, color: color, padding: 0)
    }
}
