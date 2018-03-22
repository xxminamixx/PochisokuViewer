//
//  HistoryViewController.swift
//  PochisokuViewer
//
//  Created by kyohei.minami on 2018/02/21.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NavigationBarのタイトル設定
        self.navigationItem.title = ConstText.historyTitle
        
        // TableViewのデリゲート設定
        tableView.delegate = self
        tableView.dataSource = self
        
        // TableViewにセルの登録
        tableView.register(UINib(nibName: ArticleTableViewCell.id, bundle: nil), forCellReuseIdentifier: ArticleTableViewCell.id)
         tableView.register(UINib(nibName: NoDataTableViewCell.id, bundle: nil), forCellReuseIdentifier: NoDataTableViewCell.id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 表示するせるの個数を返す
    private func numberOfRowsInSection() -> Int {
        
        guard let entity = HistoryArticleManager.HistoryArticleList else {
            // アンラップできなかったら表示データなしとする   
            return 1
        }

        if entity.isEmpty {
            // 表示するデータがないことを表すせる表示するため1を返却
            return 1
        } else {
            // TODO: 今の所ごちゃまぜになる
            return HistoryArticleManager.HistoryArticleList!.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let _ = HistoryArticleManager.HistoryArticleList {
            let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.id, for: indexPath) as! ArticleTableViewCell
            
            // 選択したEtityを取得
            let selectedEntity = HistoryArticleManager.HistoryArticleList![indexPath.row]
            // ページタイトルをセルにセット
            cell.title.text = selectedEntity.title
            // サムネイルを設定
            ImageFetcher.articleImage(cell: cell, url: selectedEntity.image)
            
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoDataTableViewCell.id, for: indexPath) as! NoDataTableViewCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 永続化されている閲覧記事がなかったら早期return
        guard let history = HistoryArticleManager.HistoryArticleList else {
            return
        }
        
        let selectedEntity = history[indexPath.row]
        
        let url = URL(string: selectedEntity.url)
        let request = URLRequest(url: url!)
        let webViewController = storyboard?.instantiateViewController(withIdentifier: WebViewController.id) as! WebViewController
        webViewController.request = request
        // 画面遷移してWebViewの表示
        self.navigationController?.pushViewController(webViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
