//
//  PUBGViewController.swift
//  PochisokuViewer
//
//  Created by 南　京兵 on 2018/03/22.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class PUBGViewController: HomeViewController {
    
    static let id = "PUBGViewController"
    var indicatorInfo: IndicatorInfo = "PUBG"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension PUBGViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return indicatorInfo
    }
}
