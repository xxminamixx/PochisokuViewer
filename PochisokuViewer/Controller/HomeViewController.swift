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
import NVActivityIndicatorView
import PopupDialog

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    // 新規記事取得時のインジケータに使用
    private let refreshControl = UIRefreshControl()
    
    // 関連記事のリスト
    var relatedArticleList: [ArticleEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 記事一覧を取得
        relatedArticleList = HTMLParseManager.relatedArticleEntityList({ result in
            
            if result {
                
            } else {
                // インジケータ表示を終了
                self.refreshControl.endRefreshing()
                
                let popup = PopupDialog(title: ConstText.loadFailedTitle, message: ConstText.loadFailedMessage)
                
                let cancelButton = CancelButton(title: ConstText.close) {
                    // ダイアログを閉じるだけなので特に処理なし
                }
                
                popup.addButtons([cancelButton])
                self.present(popup, animated: true, completion: nil)
            }
            
        })
        
        // NavigationBarのタイトル設定
        self.navigationItem.title = ConstText.homeTitle
        
        // TableViewDelegateの設定
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(HomeViewController.refresh(sender:)), for: .valueChanged)
        
        // TableViewにセルの登録
        tableView.register(UINib(nibName: ArticleTableViewCell.id, bundle: nil), forCellReuseIdentifier: ArticleTableViewCell.id)
       tableView.register(UINib(nibName: NoDataTableViewCell.id, bundle: nil), forCellReuseIdentifier: NoDataTableViewCell.id)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // TableViewの選択状態を解除
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    /// TableViewを上に引っ張りバウンスさせたときの処理
    ///
    /// - Parameter sender: UIControl
    @objc func refresh(sender: UIControl) {
        relatedArticleList = HTMLParseManager.relatedArticleEntityList({ result in
            
            if result {
                // フェッチが終わったらテーブルビューを更新
                self.tableView.reloadData()
                // インジケータ表示を終了
                self.refreshControl.endRefreshing()
            } else {
                // インジケータ表示を終了
                self.refreshControl.endRefreshing()
                
                let popup = PopupDialog(title: ConstText.loadFailedTitle, message: ConstText.loadFailedMessage)
                
                let cancelButton = CancelButton(title: ConstText.close) {
                    // ダイアログを閉じるだけなので特に処理なし
                }
                
                popup.addButtons([cancelButton])
                self.present(popup, animated: true, completion: nil)
            }
           
        })
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 表示するせるの個数を返す
    private func numberOfRowsInSection() -> Int {
        if relatedArticleList.isEmpty {
            // 表示するデータがないことを表すせる表示するため1を返却
            return 1
        } else {
            return relatedArticleList.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if relatedArticleList.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoDataTableViewCell.id, for: indexPath) as! NoDataTableViewCell
            cell.label?.text = "記事の取得に失敗しました。"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.id, for: indexPath) as! ArticleTableViewCell
            // ページタイトルをセルにセット
            cell.title.text = relatedArticleList[indexPath.row].title
            // TODO: サムネイルをセット
            ImageFetcher.articleImage(cell: cell, url: relatedArticleList[indexPath.row].image)
            
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEntity = relatedArticleList[indexPath.row]
        let url = URL(string: selectedEntity.url)
        let request = URLRequest(url: url!)
        let webViewController = storyboard?.instantiateViewController(withIdentifier: WebViewController.id) as! WebViewController
        webViewController.request = request
        // 画面遷移してWebViewの表示
        self.navigationController?.pushViewController(webViewController, animated: true)
        
        // 選択した日付で上書き
        RealmStoreManager.save {
            selectedEntity.date = Date()
        }
        
        // 閲覧した記事を永続化
        RealmStoreManager.addEntity(object: selectedEntity.self)
        
        // 閲覧した記事が50件以上ある場合最古のデータを削除
        if RealmStoreManager.countEntity(type: ArticleEntity.self) > 5 {
            let deleteObject = RealmStoreManager.entityList(type: ArticleEntity.self).sorted(byKeyPath: "date", ascending: false).last
            RealmStoreManager.delete(object: deleteObject!)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height) {
            // 皿読み処理
            relatedArticleList =  relatedArticleList + HTMLParseManager.addRelatedArticleEntityList({ result in
                // TODO: 皿読み処理後にやりたいこと
            })
            tableView.reloadData()
        }
    }
    
}
