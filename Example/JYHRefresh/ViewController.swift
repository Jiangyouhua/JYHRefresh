//
//  ViewController.swift
//  JYHRefresh
//
//  Created by 3424079 on 09/17/2021.
//  Copyright (c) 2021 3424079. All rights reserved.
//

import UIKit
import JYHRefresh

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let scrollView = UIScrollView(frame: view.frame)
        let y = 50
        for i in 1...10 {
            let label = UILabel()
            label.text = "Line \(i)"
            label.sizeToFit()
            scrollView.addSubview(label)
            label.center = CGPoint(x: scrollView.center.x, y: CGFloat(y * i))
        }
        scrollView.refreshControl = JYHRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        view.addSubview(scrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func refresh(_ sender: UIRefreshControl){
        sender.endRefreshing()
    }
}

