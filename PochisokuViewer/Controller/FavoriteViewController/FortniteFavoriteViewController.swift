//
//  FortniteFavoriteViewController.swift
//  PochisokuViewer
//
//  Created by 南　京兵 on 2018/03/27.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class FortniteFavoriteViewController: UIViewController {
    
    static let id  = "FortniteFavoriteViewController"
    
    var indicatorInfo: IndicatorInfo = "Fortnite"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // TableViewにセルの登録
        tableView.register(UINib(nibName: ArticleTableViewCell.id, bundle: nil), forCellReuseIdentifier: ArticleTableViewCell.id)
        tableView.register(UINib(nibName: NoDataTableViewCell.id, bundle: nil), forCellReuseIdentifier: NoDataTableViewCell.id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension FortniteFavoriteViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return indicatorInfo
    }
}

extension FortniteFavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    // 表示するせるの個数を返す
    private func numberOfRowsInSection() -> Int {
        
        guard ArticleManager.foavoriteListCount(gameTitle: .fortnite) > 0  else {
            return 1
        }
        
        return ArticleManager.foavoriteListCount(gameTitle: .fortnite)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard ArticleManager.foavoriteListCount(gameTitle: .fortnite) > 0  else {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoDataTableViewCell.id, for: indexPath) as! NoDataTableViewCell
            cell.label?.text = "記事の取得に失敗しました。"
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.id, for: indexPath) as! ArticleTableViewCell
        // ページタイトルをセルにセット
        // TODO: 強制アンラップ直したい
        cell.title.text = ArticleManager.favoriteList(gameTitle: .fortnite)![indexPath.row].title
        // TODO: サムネイルをセット
        ImageFetcher.articleImage(cell: cell, url: ArticleManager.favoriteList![indexPath.row].image)
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

//extension FortniteViewController: IndicatorInfoProvider {
//    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
//        return indicatorInfo
//    }
//}

