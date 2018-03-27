//
//  HistoryPageViewController.swift
//  PochisokuViewer
//
//  Created by 南　京兵 on 2018/03/23.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class HistoryPageViewController: TwitterPagerTabStripViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 履歴情報の読み込み
        ArticleManager.HistoryArticleList = RealmStoreManager.filterEntityList(type: ArticleEntity.self, property: "isFavorite", filter: false)
        
        settings.style.dotColor = UIColor(white: 1, alpha: 0.4)
        settings.style.selectedDotColor = UIColor.white
        settings.style.portraitTitleFont = UIFont.systemFont(ofSize: 18)
        settings.style.landscapeTitleFont = UIFont.systemFont(ofSize: 15)
        settings.style.titleColor = UIColor.white
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        // ページビューで表示するViewControllerを生成
        let pubg = self.storyboard?.instantiateViewController(withIdentifier: PUGBHistoryViewController.id) as! PUGBHistoryViewController
        let fortnite = self.storyboard?.instantiateViewController(withIdentifier: FortniteHistoryViewController.id) as! FortniteHistoryViewController
        
        return [pubg, fortnite]
    }

}
