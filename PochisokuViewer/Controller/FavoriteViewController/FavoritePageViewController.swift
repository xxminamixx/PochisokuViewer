//
//  FavoritePageViewController.swift
//  PochisokuViewer
//
//  Created by 南　京兵 on 2018/03/27.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class FavoritePageViewController: TwitterPagerTabStripViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // お気に入り情報を保持
        ArticleManager.favoriteList = RealmStoreManager.filterEntityList(type: ArticleEntity.self, property: "isFavorite", filter: true)
        
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
        let pubg = self.storyboard?.instantiateViewController(withIdentifier: PUBGFavoriteViewController.id) as! PUBGFavoriteViewController
        let fortnite = self.storyboard?.instantiateViewController(withIdentifier: FortniteFavoriteViewController.id) as! FortniteFavoriteViewController
        
        return [pubg, fortnite]
    }
}
