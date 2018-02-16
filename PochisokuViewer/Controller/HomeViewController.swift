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
    
    // 関連記事のリスト
    var relatedArticleList: [ArticleEntity] {
        get {
            return HTMLParseManager.relatedArticleEntityList()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TableViewDelegateの設定
        tableView.delegate = self
        tableView.dataSource = self
        
        // TableViewにセルの登録
        tableView.register(UINib(nibName: ArticleTableViewCell.id, bundle: nil), forCellReuseIdentifier: ArticleTableViewCell.id)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

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
    
}
