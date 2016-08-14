//
//  InfiniteLoopPagingCollectionViewController.swift
//  InfiniteCoverFlow
//
//  Created by 横山 拓也 on 2016/08/09.
//  Copyright © 2016年 jp.co.chocoyama. All rights reserved.
//

import UIKit

class InfiniteLoopPagingCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: InfiniteLoopPagingCollectionView!
    private let factor = 5
    private let itemCount = 5
    private let infiniteLoopPagingCollectionViewCellIdentifier = "InfiniteLoopPagingCollectionViewCell"
    
    private var layout: InfiniteLoopPagingCollectionViewLayout? {
        return collectionView.collectionViewLayout as? InfiniteLoopPagingCollectionViewLayout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout?.adjust(with: factor)
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
        
    }
}
