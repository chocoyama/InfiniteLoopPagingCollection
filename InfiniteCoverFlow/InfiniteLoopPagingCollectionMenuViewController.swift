//
//  InfiniteLoopPagingCollectionMenuViewController.swift
//  InfiniteCoverFlow
//
//  Created by 横山 拓也 on 2016/08/14.
//  Copyright © 2016年 jp.co.chocoyama. All rights reserved.
//

import UIKit

class InfiniteLoopPagingCollectionMenuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    weak var scrollSynchronizeDelegate: ScrollSynchronizeDelegate?

    @IBOutlet weak var collectionView: InfiniteLoopPagingCollectionView!
    private let factor = 5
    private let itemCount = 10
    private let infiniteLoopPagingCollectionViewCellIdentifier = "InfiniteLoopPagingCollectionViewCell"
    
    private var layout: InfiniteLoopPagingCollectionViewLayout? {
        return collectionView.collectionViewLayout as? InfiniteLoopPagingCollectionViewLayout
    }
    
    private(set) lazy var cellSize: CGSize = {
        let collectionViewFrameSize = self.collectionView?.frame.size ?? CGSize.zero
        let width = collectionViewFrameSize.width * (1 / 5)
        let height = collectionViewFrameSize.height * (9.5 / 10)
        let size = CGSize(width: width, height: height)
        return size
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout?.adjust(with: factor, cellSize: cellSize)
    }

    private func registerCell() {
        let nib = UINib.init(nibName: infiniteLoopPagingCollectionViewCellIdentifier, bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: infiniteLoopPagingCollectionViewCellIdentifier)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount * factor
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(infiniteLoopPagingCollectionViewCellIdentifier, forIndexPath: indexPath) as! InfiniteLoopPagingCollectionViewCell
        cell.label.text = "\(indexPath.item % itemCount)"
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        scrollSynchronizeDelegate?.didTappedCell(self, indexPath: indexPath)
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        scrollSynchronizeDelegate?.noticeScrollViewDidScrollEnd(self)
    }
    
}
