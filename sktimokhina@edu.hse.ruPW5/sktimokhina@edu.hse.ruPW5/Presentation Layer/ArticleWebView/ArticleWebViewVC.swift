//
//  ArticleWebViewVC.swift
//  sktimokhina@edu.hse.ruPW5
//
//  Created by Софья Тимохина on 10.11.2021.
//

import UIKit
import WebKit

class ArticleWebViewVC: UIViewController, WKUIDelegate {
    private let url: URL

    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = webView
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
