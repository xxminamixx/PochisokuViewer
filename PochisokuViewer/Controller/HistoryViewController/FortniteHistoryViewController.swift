//
//  FortniteHistoryViewController.swift
//  PochisokuViewer
//
//  Created by 南　京兵 on 2018/03/23.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class FortniteHistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    static let id = "FortniteHistoryViewController"
    
    var indicatorInfo: IndicatorInfo = "Fortnite"

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

extension FortniteHistoryViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return indicatorInfo
    }
}

extension FortniteHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 表示するせるの個数を返す
    private func numberOfRowsInSection() -> Int {
        
        guard ArticleManager.historyListCount(gameTitle: .fortnite) > 0 else {
            // アンラップできなかったら表示データなしとする
            return 1
        }
        
        return ArticleManager.historyListCount(gameTitle: .fortnite)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard ArticleManager.historyListCount(gameTitle: .fortnite) > 0 else {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoDataTableViewCell.id, for: indexPath) as! NoDataTableViewCell
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.id, for: indexPath) as! ArticleTableViewCell
        
        // TODO: 強制アンラップ直したい
        
        // 選択したEtityを取得
        let selectedEntity = ArticleManager.historyList(gameTitle: .fortnite)![indexPath.row]
        // ページタイトルをセルにセット
        cell.title.text = selectedEntity.title
        // サムネイルを設定
        ImageFetcher.articleImage(cell: cell, url: selectedEntity.image)
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 永続化されている閲覧記事がなかったら早期return
        guard let history = ArticleManager.historyList(gameTitle: .fortnite) else {
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
