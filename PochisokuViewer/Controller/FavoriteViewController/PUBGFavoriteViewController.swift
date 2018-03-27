//
//  FavoriteViewController.swift
//  PochisokuViewer
//
//  Created by 南　京兵 on 2018/03/22.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class PUBGFavoriteViewController: UIViewController {
    
    static let id  = "PUBGFavoriteViewController"
    
    var indicatorInfo: IndicatorInfo = "PUBG"
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableViewのデリゲート設定
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

extension PUBGFavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    // 表示するせるの個数を返す
    private func numberOfRowsInSection() -> Int {
        
        guard ArticleManager.foavoriteListCount(gameTitle: .pubg) > 0  else {
            return 1
        }
        
        return ArticleManager.foavoriteListCount(gameTitle: .pubg)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard ArticleManager.foavoriteListCount(gameTitle: .pubg) > 0  else {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoDataTableViewCell.id, for: indexPath) as! NoDataTableViewCell
            cell.label?.text = "記事の取得に失敗しました。"
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.id, for: indexPath) as! ArticleTableViewCell
        // ページタイトルをセルにセット
        // TODO: 強制アンラップ直したい
        cell.title.text = ArticleManager.favoriteList(gameTitle: .pubg)![indexPath.row].title
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

extension PUBGFavoriteViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return indicatorInfo
    }
}
