//
//  FollowersViewController.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-03.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import UIKit

class FollowersViewController: UIViewController {
    
    private enum Section {
        case main
    }

    var username: String!
    private var page = 1
    private var hasMoreFollowers = true

    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    private var followers: [Follower] = []
    private var filteredFollowers: [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        configureCollectionView()
        createSearchController()
        createDataSource()
        getFollowers(username: username, page: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func getFollowers(username: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(username: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                
                if self.followers.count == 0 {
                    DispatchQueue.main.async {
                        self.showEmptyStateView(title: "This user doesn't have any followers ☹️", in: self.view)
                    }
                    return
                }
                
                self.updateDataSource(on: self.followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Invalid Request", message: error.message, buttonTitle: "Ok")
            }
        }
    }
    
    private func setupViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFollowersButtonTapped))
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createCompositionalLayout(in: view))
        view.addSubview(collectionView)
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: String(describing: FollowerCell.self))
        collectionView.delegate = self
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FollowerCell.self), for: indexPath) as? FollowerCell
            cell?.set(follower: follower)
            return cell
        })
    }
    
    private func updateDataSource(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func createSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    private func presentUserInfoViewController(for login: String) {
        let vc = UserInfoViewController(username: login)
        vc.delegate = self
        let navigationController = UINavigationController(rootViewController: vc)
        present(navigationController, animated: true)
    }
    
    @objc private func addFollowersButtonTapped() {
        self.showLoadingView()
        NetworkManager.shared.getUser(username: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
                case .success(let user):
                    let follower = Follower(login: user.login, avatarUrl: user.avatarUrl)
                    PersistenceManager.updateStorage(with: follower, action: .add) { error in
                        
                        if let error = error {
                            self.presentGFAlertOnMainThread(title: "Something went bad", message: error.message, buttonTitle: "Ok")
                        } else {
                            self.presentGFAlertOnMainThread(title: "Saved", message: "The user nas been successfully saved", buttonTitle: "Ok")
                        }
                    }
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Something went bad", message: error.message, buttonTitle: "Ok")
            }
        }
    }
    
}

extension FollowersViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == followers.count - 1 {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let searchText = navigationItem.searchController?.searchBar.text, !searchText.isEmpty {
            let follower =  filteredFollowers[indexPath.item]
            presentUserInfoViewController(for: follower.login)
        } else {
            let follower =  followers[indexPath.item]
            presentUserInfoViewController(for: follower.login)
        }
    }
    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//        let scrollViewHeight = scrollView.frame.height
//
//        if offsetY > contentHeight - scrollViewHeight {
//            guard hasMoreFollowers else { return }
//            page += 1
//            getFollowers(username: username, page: page)
//        }
//    }
}

extension FollowersViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchtext = searchController.searchBar.text, !searchtext.isEmpty else {
            updateDataSource(on: followers)
            return
        }
        filteredFollowers = followers.filter { $0.login.lowercased().contains(searchtext.lowercased()) }
        updateDataSource(on: filteredFollowers)
    }
}

extension FollowersViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateDataSource(on: followers)
    }
}

extension FollowersViewController: UserInfoViewControllerDelegate {
    
    func didRequestFollowers(for username: String) {
        self.title = username
        self.username = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)
    }
}
