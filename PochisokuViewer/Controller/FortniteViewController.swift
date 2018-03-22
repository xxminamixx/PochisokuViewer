//
//  FortniteViewController.swift
//  PochisokuViewer
//
//  Created by 南　京兵 on 2018/03/20.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit
import PopupDialog
import XLPagerTabStrip

// TODO: 履歴がごちゃませになるので対応したい
class FortniteViewController: HomeViewController {
    
    static let id = "FortniteViewController"
    
    var indicatorInfo: IndicatorInfo = "Fortnite"
    
    // 新規記事取得時のインジケータに使用
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorInfo = "Fortnite"
        
        // 記事一覧を取得
        relatedArticleList = HTMLParseManager.fortniteEntity({ result in

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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension FortniteViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return indicatorInfo
    }
}

