//
//  ViewController.swift
//  PochisokuViewer
//
//  Created by 南　京兵 on 2018/02/16.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit
import WebKit
import Ji

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    // 新規記事取得時のインジケータに使用
    private let refreshControl = UIRefreshControl()
    
    // 関連記事のリスト
    var relatedArticleList: [ArticleEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 記事一覧を取得
        relatedArticleList = HTMLParseManager.relatedArticleEntityList({})
        
        // NavigationBarのタイトル設定
        self.navigationItem.title = "記事一覧"
        
        // TableViewDelegateの設定
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(HomeViewController.refresh(sender:)), for: .valueChanged)
        
        // TableViewにセルの登録
        tableView.register(UINib(nibName: ArticleTableViewCell.id, bundle: nil), forCellReuseIdentifier: ArticleTableViewCell.id)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    /// TableViewを上に引っ張りバウンスさせたときの処理
    ///
    /// - Parameter sender: UIControl
    @objc func refresh(sender: UIControl) {
        relatedArticleList = HTMLParseManager.relatedArticleEntityList({
            // フェッチが終わったらテーブルビューを更新
            tableView.reloadData()
            // インジケータ表示を終了
            refreshControl.endRefreshing()
        })
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return relatedArticleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.id, for: indexPath) as! ArticleTableViewCell
        // ページタイトルをセルにセット
        cell.title.text = relatedArticleList[indexPath.row].title
        // TODO: サムネイルをセット
        ImageFetcher.articleImage(cell: cell, url: relatedArticleList[indexPath.row].image)
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: relatedArticleList[indexPath.row].url)
        let request = URLRequest(url: url!)
        let webViewController = storyboard?.instantiateViewController(withIdentifier: WebViewController.id) as! WebViewController
        webViewController.request = request
        // 画面遷移してWebViewの表示
        self.navigationController?.pushViewController(webViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height) {
            // 皿読み処理
            relatedArticleList =  relatedArticleList + HTMLParseManager.addRelatedArticleEntityList()
            tableView.reloadData()
        }
    }
    
}
