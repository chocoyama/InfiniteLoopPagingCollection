//
//  InfiniteLoopPagingCollectionViewController.swift
//  InfiniteCoverFlow
//
//  Created by 横山 拓也 on 2016/08/09.
//  Copyright © 2016年 jp.co.chocoyama. All rights reserved.
//

import UIKit

class InfiniteLoopPagingCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    private var layout: InfiniteLoopPagingCollectionViewLayout? {
        return collectionView.collectionViewLayout as? InfiniteLoopPagingCollectionViewLayout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout?.adjustXPosition()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("InfiniteLoopPagingCollectionViewCell", forIndexPath: indexPath) as! InfiniteLoopPagingCollectionViewCell
        cell.label.text = "\(indexPath.item + 1)"
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
}
