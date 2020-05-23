//
//  FavoritesViewController.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-02.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private let tableView = UITableView()
    private var favorites: [Follower] = []
//    private var dataSource: UITableViewDiffableDataSource<Section, Follower>!
    
    private enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        createTableView()
//        createDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    private func getFavorites() {
        PersistenceManager.retrieveFavorites() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let favorites):
                    if favorites.isEmpty {
                        DispatchQueue.main.async(execute: {
                            self.showEmptyStateView(title: "No Favorites yet ☹️", in: self.view)
                        })
                    }
                    self.favorites = favorites
                    DispatchQueue.main.async {
//                        self.updateTableView(for: favorites)
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Something bad happened", message: error.message, buttonTitle: "Ok")
            }
        }
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func createTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 70
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteUserTableViewCell.self, forCellReuseIdentifier: String(describing: FavoriteUserTableViewCell.self))
    }
    
//    private func createDataSource() {
//        dataSource = UITableViewDiffableDataSource<Section, Follower>(tableView: tableView) { (tableView, indexPath, favorite) -> UITableViewCell? in
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FavoriteUserTableViewCell.self), for: indexPath) as? FavoriteUserTableViewCell
//            cell?.set(user: favorite)
//            return cell
//        }
//    }
//
//    private func updateTableView(for favorites: [Follower]) {
//        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
//        snapshot.appendSections([.main])
//        snapshot.appendItems(favorites)
//        dataSource.apply(snapshot, animatingDifferences: true)
//    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let favoriteVC = FollowersViewController()
        favoriteVC.username = favorite.login
        favoriteVC.title = favorite.login
        self.navigationController?.pushViewController(favoriteVC, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FavoriteUserTableViewCell.self), for: indexPath) as! FavoriteUserTableViewCell
        let favorite = favorites[indexPath.row]
        cell.set(user: favorite)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favorite = favorites[indexPath.row]
        self.favorites.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        PersistenceManager.updateStorage(with: favorite, action: .remove, completion: { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.presentGFAlertOnMainThread(title: "Something bad happened", message: error.message, buttonTitle: "Ok")
            }
        })
    }
    
        
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, view, handler) in
//            let favorite = self.favorites[indexPath.row]
//
//            PersistenceManager.updateStorage(with: favorite, action: .remove, completion: { [weak self] error in
//                guard let self = self else { return }
//
//                if let error = error {
//                    self.presentGFAlertOnMainThread(title: "Something bad happened", message: error.message, buttonTitle: "Ok")
//                } else {
//                    self.favorites.remove(at: indexPath.row)
//                    self.updateTableView(for: self.favorites)
//                }
//            })
//            handler(true)
//        }
//        deleteAction.backgroundColor = .systemRed
//        deleteAction.image = UIImage(systemName: "trash")
//
//        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
//        configuration.performsFirstActionWithFullSwipe = true
//        return configuration
//    }

}
