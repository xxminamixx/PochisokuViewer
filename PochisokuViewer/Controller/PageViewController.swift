//
//  PageViewController.swift
//  PochisokuViewer
//
//  Created by 南　京兵 on 2018/03/20.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class PageViewController: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        //  ButtonBarPagerの各種設定
        self.settings.style.buttonBarBackgroundColor = UIColor.white
        self.settings.style.buttonBarItemBackgroundColor = ConstColor.iconPink
        self.settings.style.buttonBarItemTitleColor = UIColor.white
        self.settings.style.selectedBarHeight = 2
        self.settings.style.selectedBarBackgroundColor = UIColor.white
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        // ページビューで表示するViewControllerを生成
        let pubg = self.storyboard?.instantiateViewController(withIdentifier: HomeViewController.id) as! HomeViewController
        let fortnite = self.storyboard?.instantiateViewController(withIdentifier: FortniteViewController.id) as! FortniteViewController

        return [pubg, fortnite]
    }
}
