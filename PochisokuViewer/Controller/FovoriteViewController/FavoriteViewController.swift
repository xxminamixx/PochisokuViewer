//
//  FavoriteViewController.swift
//  PochisokuViewer
//
//  Created by 南　京兵 on 2018/03/22.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // お気に入り情報を保持
        ArticleManager.favoriteList = RealmStoreManager.filterEntityList(type: ArticleEntity.self, property: "isFavorite", filter: true)
        
        // tableViewのデリゲート設定
        tableView.delegate = self
        tableView.dataSource = self
        
        // TableViewにセルの登録
        tableView.register(UINib(nibName: ArticleTableViewCell.id, bundle: nil), forCellReuseIdentifier: ArticleTableViewCell.id)
        tableView.register(UINib(nibName: NoDataTableViewCell.id, bundle: nil), forCellReuseIdentifier: NoDataTableViewCell.id)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    // 表示するせるの個数を返す
    private func numberOfRowsInSection() -> Int {
        if (ArticleManager.favoriteList?.isEmpty)! {
            return 1
        } else {
            return ArticleManager.favoriteList!.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (ArticleManager.favoriteList?.isEmpty)! {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoDataTableViewCell.id, for: indexPath) as! NoDataTableViewCell
            cell.label?.text = "記事の取得に失敗しました。"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.id, for: indexPath) as! ArticleTableViewCell
            // ページタイトルをセルにセット
            cell.title.text = ArticleManager.favoriteList![indexPath.row].title
            // TODO: サムネイルをセット
            ImageFetcher.articleImage(cell: cell, url: ArticleManager.favoriteList![indexPath.row].image)
            
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

