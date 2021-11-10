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
        webView.navigationDelegate = self
        return webView
    }()

    lazy var loadingView: UIView = {
        let view = UIView()
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .subviewBackground
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        view.backgroundColor = .background
        return view
    }()

    lazy var tryToReloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(" Try to reload ", for: .normal)
        button.setTitleColor(.text, for: .normal)
        button.backgroundColor = .subviewBackground
        button.layer.cornerRadius = 16
        button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
        button.addTarget(self, action: #selector(loadPage), for: .touchUpInside)
        return button
    }()

    lazy var failedToLoadLabel: UILabel = {
        let label = UILabel()
        label.text = "Failed to load"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var failedView: UIView = {
        let view = UIView()
        view.addSubview(tryToReloadButton)
        view.addSubview(failedToLoadLabel)
        NSLayoutConstraint.activate([
            failedToLoadLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            failedToLoadLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            tryToReloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tryToReloadButton.topAnchor.constraint(equalTo: failedToLoadLabel.bottomAnchor,
                                                   constant: 16),
            tryToReloadButton.heightAnchor.constraint(equalToConstant: 55),
        ])
        view.backgroundColor = .background
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPage()
    }

    @objc
    func loadPage() {
        view = loadingView
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension ArticleWebViewVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        view = webView
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        view = failedView
    }
}
