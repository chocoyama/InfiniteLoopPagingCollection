//
//  InfiniteLoopPagingCollectionContainerViewController.swift
//  InfiniteCoverFlow
//
//  Created by 横山 拓也 on 2016/08/14.
//  Copyright © 2016年 jp.co.chocoyama. All rights reserved.
//

import UIKit

class InfiniteLoopPagingCollectionContainerViewController: UIViewController, ScrollSynchronizeDelegate {

    private var contentsVC: InfiniteLoopPagingCollectionViewController?
    private var menuVC: InfiniteLoopPagingCollectionMenuViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? InfiniteLoopPagingCollectionViewController {
            contentsVC = vc
            vc.scrollSynchronizeDelegate = self
        } else if let vc = segue.destinationViewController as? InfiniteLoopPagingCollectionMenuViewController {
            menuVC = vc
            vc.scrollSynchronizeDelegate = self
        }
        "InfiniteLoopPagingCollectionViewControllerSegue"
        "InfiniteLoopPagingCollectionMenuViewControllerSegue"
    }
    
    enum State {
        case normal
        case synchronizing
    }
    private var state: State = .normal

    // TODO: 初期表示に呼ばれてしまってずれる。お互いを呼び合って無限ループに陥る
    func noticeScrollViewDidScroll(from: UIViewController, dx: CGFloat) {
        if let vc = from as? InfiniteLoopPagingCollectionViewController where state == .normal {
            let currentOffset = menuVC?.collectionView.contentOffset ?? CGPoint.zero
            let destinationDx = dx * ((menuVC?.cellSize.width ?? 0.0) / vc.cellSize.width)
            let nextOffset = CGPoint(x: currentOffset.x + destinationDx, y: currentOffset.y)
            menuVC?.collectionView.setContentOffset(nextOffset, animated: false)
        }
    }
    
    func noticeScrollViewDidScrollEnd(from: UIViewController) {
        if let contentsVC = from as? InfiniteLoopPagingCollectionViewController, let menuVC = menuVC {
            let center = contentsVC.view.convertPoint(contentsVC.view.center, toView: contentsVC.collectionView)
            let rawIndexPath = contentsVC.collectionView.indexPathForItemAtPoint(center) ?? NSIndexPath(forItem: 0, inSection: 0)
            menuVC.collectionView.scrollToItemAtIndexPath(rawIndexPath, atScrollPosition: .CenteredHorizontally, animated: true)
        }
        state = .normal
    }
    
    func didTappedCell(vc: UIViewController, indexPath: NSIndexPath) {
        state = .synchronizing
        contentsVC?.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
        menuVC?.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
    }

}
