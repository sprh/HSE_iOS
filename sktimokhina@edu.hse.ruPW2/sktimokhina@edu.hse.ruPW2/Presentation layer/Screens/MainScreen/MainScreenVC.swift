//
//  MainScreenVC.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 17.09.2021.
//

import UIKit
import AVKit

protocol IMainScreenVC: UIViewController {
    var interactor: IMainScreenInteractor! { set get }

    func shouldShowSettings(userDefaults: IUserDefautsManager)
}

final class MainScreenVC: UIViewController {
    var interactor: IMainScreenInteractor!
    private var router: IMainScreenRouter
    
    init(router: IMainScreenRouter) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9764078259, blue: 0.8245866895, alpha: 1)
        setupNavigationController()
    }

    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Main"
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .plain, target: self, action: #selector(didTapSettingsButton))
        navigationItem.rightBarButtonItem = settingsButton
    }

    @objc func didTapSettingsButton() {
        interactor.didTapSettingsButton()
    }
}

extension MainScreenVC: IMainScreenVC {
    func shouldShowSettings(userDefaults: IUserDefautsManager) {
        router.showSettingsScreen(userDefaults: userDefaults)
    }
}
