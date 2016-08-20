//
//  ScrollSynchronizeDelegate.swift
//  InfiniteCoverFlow
//
//  Created by 横山 拓也 on 2016/08/14.
//  Copyright © 2016年 jp.co.chocoyama. All rights reserved.
//

import UIKit

protocol ScrollSynchronizeDelegate: class {
    func noticeScrollViewDidScroll(from: UIViewController, dx: CGFloat)
    func noticeScrollViewDidScrollEnd(from: UIViewController)
    func didTappedCell(vc: UIViewController, indexPath: NSIndexPath)
}