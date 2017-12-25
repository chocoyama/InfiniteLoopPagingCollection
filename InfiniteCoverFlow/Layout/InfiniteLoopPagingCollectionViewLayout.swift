//
//  InfiniteLoopPagingCollectionViewLayout.swift
//  InfiniteCoverFlow
//
//  Created by 横山 拓也 on 2016/08/09.
//  Copyright © 2016年 jp.co.chocoyama. All rights reserved.
//

import UIKit

class InfiniteLoopPagingCollectionViewLayout: UICollectionViewFlowLayout {
    
    private var cellSize = CGSize.zero
    
    override func prepare() {
        scrollDirection = .horizontal
        itemSize = cellSize
        collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let collectionViewBounds = collectionView?.bounds ?? CGRect.zero
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionViewBounds.size.width, height: collectionViewBounds.size.height)
        let attributes = layoutAttributesForElements(in: targetRect)
        
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalOffset = proposedContentOffset.x + ((UIScreen.main.bounds.width - cellSize.width) / 2)
        
        attributes?.forEach{
            let itemOffset = $0.frame.origin.x
            if abs(itemOffset - horizontalOffset) < abs(offsetAdjustment) {
                offsetAdjustment = itemOffset - horizontalOffset
            }
        }
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
    
    func adjust(with factor: Int, cellSize: CGSize) {
        if let collectionView = self.collectionView as? InfiniteLoopPagingCollectionView {
            collectionView.factor = factor
            let centeringX = (collectionView.frame.width / 2) - (cellSize.width / 2)
            let offset = CGPoint(x: -centeringX, y: 0)
            collectionView.setContentOffset(offset, animated: false)
            
            self.cellSize = cellSize
        }
    }
}
