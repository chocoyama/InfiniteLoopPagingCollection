//
//  ScrollSynchronizeDelegate.swift
//  InfiniteCoverFlow
//
//  Created by 横山 拓也 on 2016/08/14.
//  Copyright © 2016年 jp.co.chocoyama. All rights reserved.
//

import UIKit

@objc protocol ScrollSynchronizeDelegate: class {
    func noticeScrollViewDidScroll(from: UIViewController, dx: CGFloat)
    func noticeScrollViewDidScrollEnd(from: UIViewController)
    func didTappedCell(vc: UIViewController, indexPath: IndexPath)
}

protocol ScrollSynchronizable: class {
    var factor: Int { get }
    var itemCount: Int { get }
    var cellSize: CGSize { get }
    weak var scrollSynchronizeDelegate: ScrollSynchronizeDelegate? { get set }
    weak var collectionView: InfiniteLoopPagingCollectionView! { get set }
}

extension ScrollSynchronizable where Self: UIViewController, Self: UICollectionViewDataSource {
    var numberOfItemsInSection: Int {
        return itemCount * factor
    }
    
    var layout: InfiniteLoopPagingCollectionViewLayout? {
        return collectionView.collectionViewLayout as? InfiniteLoopPagingCollectionViewLayout
    }
    
    func didSelectItemAt(_ indexPath: IndexPath) {
        scrollSynchronizeDelegate?.didTappedCell(vc: self, indexPath: indexPath)
    }
    
    func adjustLayout() {
        layout?.adjust(with: factor, cellSize: cellSize)
    }
}
