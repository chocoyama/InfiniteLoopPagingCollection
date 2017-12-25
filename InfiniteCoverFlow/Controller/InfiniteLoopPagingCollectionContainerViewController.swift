//
//  InfiniteLoopPagingCollectionContainerViewController.swift
//  InfiniteCoverFlow
//
//  Created by 横山 拓也 on 2016/08/14.
//  Copyright © 2016年 jp.co.chocoyama. All rights reserved.
//

import UIKit

class InfiniteLoopPagingCollectionContainerViewController: UIViewController {

    private var contentsVC: InfiniteLoopPagingCollectionViewController?
    private var menuVC: InfiniteLoopPagingCollectionMenuViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? InfiniteLoopPagingCollectionViewController {
            contentsVC = vc
            vc.scrollSynchronizeDelegate = self
        } else if let vc = segue.destination as? InfiniteLoopPagingCollectionMenuViewController {
            menuVC = vc
            vc.scrollSynchronizeDelegate = self
        }
    }
    
    enum State {
        case normal
        case synchronizing
    }
    private var state: State = .normal

}

extension InfiniteLoopPagingCollectionContainerViewController: ScrollSynchronizeDelegate {
    // TODO: 初期表示に呼ばれてしまってずれる。お互いを呼び合って無限ループに陥る
    func noticeScrollViewDidScroll(from: UIViewController, dx: CGFloat) {
        if let vc = from as? InfiniteLoopPagingCollectionViewController, state == .normal {
            let currentOffset = menuVC?.collectionView.contentOffset ?? CGPoint.zero
            let destinationDx = dx * ((menuVC?.cellSize.width ?? 0.0) / vc.cellSize.width)
            let nextOffset = CGPoint(x: currentOffset.x + destinationDx, y: currentOffset.y)
            menuVC?.collectionView.setContentOffset(nextOffset, animated: false)
        }
    }
    
    func noticeScrollViewDidScrollEnd(from: UIViewController) {
        if let contentsVC = from as? InfiniteLoopPagingCollectionViewController, let menuVC = menuVC {
            let center = contentsVC.view.convert(contentsVC.view.center, to: contentsVC.collectionView)
            let rawIndexPath = contentsVC.collectionView.indexPathForItem(at: center) ?? IndexPath(item: 0, section: 0)
            menuVC.collectionView.scrollToItem(at: rawIndexPath, at: .centeredHorizontally, animated: true)
        }
        state = .normal
    }
    
    func didTappedCell(vc: UIViewController, indexPath: IndexPath) {
        state = .synchronizing
        contentsVC?.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        menuVC?.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
