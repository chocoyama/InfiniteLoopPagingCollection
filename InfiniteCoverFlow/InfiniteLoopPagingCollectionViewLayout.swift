//
//  InfiniteLoopPagingCollectionViewLayout.swift
//  InfiniteCoverFlow
//
//  Created by 横山 拓也 on 2016/08/09.
//  Copyright © 2016年 jp.co.chocoyama. All rights reserved.
//

import UIKit

class InfiniteLoopPagingCollectionViewLayout: UICollectionViewFlowLayout {
    
    private(set) lazy var cellSize: CGSize = {
        let collectionViewFrameSize = self.collectionView?.frame.size ?? CGSize.zero
        let width = collectionViewFrameSize.width * (4 / 5)
        let height = collectionViewFrameSize.height * (9.5 / 10)
        return CGSize(width: width, height: height)
    }()
    
    override func prepareLayout() {
        scrollDirection = .Horizontal
        itemSize = cellSize
        collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let collectionViewBounds = collectionView?.bounds ?? CGRect.zero
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionViewBounds.size.width, height: collectionViewBounds.size.height)
        let attributes = layoutAttributesForElementsInRect(targetRect)
        
        var offsetAdjustment = CGFloat.max
        let horizontalOffset = proposedContentOffset.x + ((UIScreen.mainScreen().bounds.width - cellSize.width) / 2)
        
        attributes?.forEach{
            let itemOffset = $0.frame.origin.x
            if abs(itemOffset - horizontalOffset) < abs(offsetAdjustment) {
                offsetAdjustment = itemOffset - horizontalOffset
            }
        }
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
    
    func adjustXPosition() {
        if let collectionView = self.collectionView {
            let centeringX = (collectionView.frame.width / 2) - (cellSize.width / 2)
            let offset = CGPoint(x: -centeringX, y: 0)
            collectionView.setContentOffset(offset, animated: false)
        }
    }
}
