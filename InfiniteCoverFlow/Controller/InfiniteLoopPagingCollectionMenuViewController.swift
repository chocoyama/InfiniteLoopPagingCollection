//
//  InfiniteLoopPagingCollectionMenuViewController.swift
//  InfiniteCoverFlow
//
//  Created by 横山 拓也 on 2016/08/14.
//  Copyright © 2016年 jp.co.chocoyama. All rights reserved.
//

import UIKit

class InfiniteLoopPagingCollectionMenuViewController: UIViewController {
    
    // MARK:- ScrollSynchronizable
    weak var scrollSynchronizeDelegate: ScrollSynchronizeDelegate?
    @IBOutlet weak var collectionView: InfiniteLoopPagingCollectionView!
    private(set) lazy var cellSize: CGSize = {
        let collectionViewFrameSize = self.collectionView?.frame.size ?? CGSize.zero
        return CGSize(
            width: collectionViewFrameSize.width * (1 / 5),
            height: collectionViewFrameSize.height * (9.5 / 10)
        )
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "InfiniteLoopPagingCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "InfiniteLoopPagingCollectionViewCell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        adjustLayout()
    }
    
}

extension InfiniteLoopPagingCollectionMenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfiniteLoopPagingCollectionViewCell", for: indexPath) as! InfiniteLoopPagingCollectionViewCell
        cell.label.text = "\(indexPath.item % itemCount)"
        return cell
    }
}

extension InfiniteLoopPagingCollectionMenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAt(indexPath)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollSynchronizeDelegate?.noticeScrollViewDidScrollEnd(from: self)
    }
}

extension InfiniteLoopPagingCollectionMenuViewController: ScrollSynchronizable {
    var factor: Int { return 5 }
    var itemCount: Int { return 10 }
}
