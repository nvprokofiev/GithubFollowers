//
//  UIHelper.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-05.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import UIKit

struct UIHelper {
    
    static func createCustomFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let absoluteWidth = view.bounds.width
        let padding: CGFloat = 12
        let spacing: CGFloat = 10
        let availableWidth = absoluteWidth - (padding * 2) - (spacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
    }
    
    static func createCompositionalLayout(in view: UIView) -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6)
        
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(160))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: [layoutItem])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
