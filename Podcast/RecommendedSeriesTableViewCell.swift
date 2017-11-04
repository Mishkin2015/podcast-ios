//
//  RecommendedSeriesTableViewCell.swift
//  Podcast
//
//  Created by Kevin Greer on 2/19/17.
//  Copyright © 2017 Cornell App Development. All rights reserved.
//

import UIKit

protocol RecommendedSeriesTableViewCellDataSource: class {
    func recommendedSeriesTableViewCell(cell: RecommendedSeriesTableViewCell, dataForItemAt indexPath: IndexPath) -> Series
    func numberOfRecommendedSeries(forRecommendedSeriesTableViewCell cell: RecommendedSeriesTableViewCell) -> Int
}

protocol RecommendedSeriesTableViewCellDelegate: class {
    func recommendedSeriesTableViewCell(cell: RecommendedSeriesTableViewCell, didSelectItemAt indexPath: IndexPath)
    func recommendedSeriesTableViewCell(didSelectNullStateAt indexPath: IndexPath)
}

class RecommendedSeriesTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    static var recommendedSeriesTableViewCellHeight: CGFloat = 165
    
    var showNullState: Bool = false
    var collectionView: UICollectionView!
    weak var dataSource: RecommendedSeriesTableViewCellDataSource?
    weak var delegate: RecommendedSeriesTableViewCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: RecommendedSeriesCollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        backgroundColor = .clear
        collectionView.register(SeriesGridCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.showsHorizontalScrollIndicator = false
        contentView.addSubview(collectionView)
    }
    
    // Reloads the cell's inner collection view
    func reloadCollectionViewData() {
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if showNullState { return 1 }
        return dataSource?.numberOfRecommendedSeries(forRecommendedSeriesTableViewCell: self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if showNullState { return NullGridCollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? SeriesGridCollectionViewCell else { return SeriesGridCollectionViewCell() }
        guard let series = dataSource?.recommendedSeriesTableViewCell(cell: self, dataForItemAt: indexPath) else { return SeriesGridCollectionViewCell() }
        cell.configureForSeries(series: series)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showNullState ? delegate?.recommendedSeriesTableViewCell(didSelectNullStateAt: indexPath) : delegate?.recommendedSeriesTableViewCell(cell: self, didSelectItemAt: indexPath)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
        collectionView.layoutSubviews()
        collectionView.setNeedsLayout()
    }
}
