//
//  ViewController.swift
//  InfiniteCoverFlow
//
//  Created by 横山 拓也 on 2016/08/09.
//  Copyright © 2016年 jp.co.chocoyama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTappedButton(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "InfiniteLoopPagingCollection", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("InfiniteLoopPagingCollectionContainerViewController")
        presentViewController(vc, animated: true, completion: nil)
    }

}

