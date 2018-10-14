//
//  InfiniteLoopPagingCollectionView.swift
//  InfiniteCoverFlow
//
//  Created by Takuya Yokoyama on 2016/08/10.
//  Copyright © 2016年 jp.co.chocoyama. All rights reserved.
//

import UIKit

class InfiniteLoopPagingCollectionView: UICollectionView {

    var factor = 0
    private var needsScrollToCenter = true
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    } 
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutRecenter()
        
        guard contentSize.width > 0.0 && needsScrollToCenter else { return }
        
        var i: Int = 0
        var x: CGFloat = 0.0
        
        while i <= 0 {
            let indexPath = IndexPath(item: i, section: 0)
            guard let attribute = collectionViewLayout.layoutAttributesForItem(at: indexPath) else { break }
            var minimumInterItemSpacing: CGFloat = 0.0
            if let delegateFlowLayout = delegate as? UICollectionViewDelegateFlowLayout {
                minimumInterItemSpacing = delegateFlowLayout.collectionView?(self, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: 0) ?? 0.0
            } else if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
                minimumInterItemSpacing = flowLayout.minimumInteritemSpacing
            }
            x += attribute.bounds.width - (minimumInterItemSpacing * 2)
            i += 1
        }
        let point = CGPoint(x: contentOffset.x - x, y: 0)
        setContentOffset(point, animated: false)
        needsScrollToCenter = false
    }
    
    private func layoutRecenter() {
        let currentOffset = contentOffset
        let contentWidth = contentSize.width
        let centerOffsetX = contentWidth / 2.0
        
        let distanceFromCenterX = abs(currentOffset.x - centerOffsetX) // 絶対値
        
        let allCellWidth = CGFloat(contentWidth / CGFloat(factor))
        
        if distanceFromCenterX > allCellWidth {
            let a = Float(currentOffset.x - centerOffsetX)
            let b = Float(allCellWidth)
            let offset = CGFloat(fmodf(a, b))
            contentOffset = CGPoint(x: centerOffsetX + offset, y: currentOffset.y)
        }
    }
    
}
