//
//  NotesListVC.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import UIKit

protocol INotesListVC: UIViewController {
    func shouldReloadItems()
    func shouldShowError(text: String)
}

final class NotesListVC: UIViewController, INotesListVC {
    private let interactor: INotesListInteractor
    private let router: INotesListRouter

    lazy var collectionViewListConfiguration: UICollectionLayoutListConfiguration = {
        var listConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfig.trailingSwipeActionsConfigurationProvider = { [weak self] indexPath in
            guard let self = self else { return nil }
            let actionHandler: UIContextualAction.Handler = { action, view, completion in
                guard let cell = self.collectionView.cellForItem(at: indexPath) as? NoteCell else {
                    return
                }
                self.interactor.deleteNote(id: cell.id)
            }
            let action = UIContextualAction(style: .normal, title: "Delete", handler: actionHandler)
            action.image = UIImage(systemName: "trash")
            action.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            return UISwipeActionsConfiguration(actions: [action])
        }
        listConfig.separatorConfiguration.color = .white
        return listConfig
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout.list(using: collectionViewListConfiguration)
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = view.backgroundColor
        collectionView.alwaysBounceVertical = true
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(NoteCell.self, forCellWithReuseIdentifier: "\(NoteCell.self)")
        return collectionView
    }()

    lazy var addButton: UIBarButtonItem = {
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"),
                                        style: .done,
                                        target: self,
                                        action: #selector(didTapAddButton))
        addButton.tintColor = #colorLiteral(red: 0.7025571465, green: 0.5774805546, blue: 0.5798863173, alpha: 1)
        return addButton
    }()

    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ops, I can't find any notes"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()

    init(interactor: INotesListInteractor, router: INotesListRouter) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.load()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = interactor.parentNoteTitle ?? "All notes"
        navigationItem.rightBarButtonItem = addButton
        setup()
    }

    func setup() {
        view.addSubview(collectionView)
        view.addSubview(emptyLabel)
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    @objc
    func didTapAddButton() {
        router.shouldShowDetailScreen(worker: interactor.coreDataWorker,
                                      observer: self,
                                      parentNote: interactor.parentNote)
    }

    func shouldReloadItems() {
        collectionView.reloadData()
    }

    func shouldShowError(text: String) {
        router.showError(text: text)
    }
}


extension NotesListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        emptyLabel.isHidden = interactor.notesCount != 0
        return interactor.notesCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(NoteCell.self)", for: indexPath) as? NoteCell,
              let note = interactor.getNote(at: indexPath.row) else {
                  return UICollectionViewCell()
              }
        cell.setup(with: note)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NoteCell else {
            return nil
        }
        let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in

            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), identifier: nil, discoverabilityTitle: nil,attributes: .destructive, state: .off) { [weak self] _ in
                self?.interactor.deleteNote(id: cell.id)
            }

            return UIMenu(title: "Options", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [delete])

        }
        return context
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NoteCell,
              let note = interactor.getNote(with: cell.id) else { return }
        router.openNoteListScreen(worker: interactor.coreDataWorker, parentNote: note)

    }
}

extension NotesListVC: ICreateNoteViewObserver {
    func didAddItem() {
        interactor.load()
    }
}
