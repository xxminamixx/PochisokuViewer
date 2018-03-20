//
//  FortniteViewController.swift
//  PochisokuViewer
//
//  Created by 南　京兵 on 2018/03/20.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class FortniteViewController: UIViewController {
    
    static let id = "FortniteViewController"
    var indicator: IndicatorInfo = "Fortnite"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension FortniteViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return indicator
    }
}
