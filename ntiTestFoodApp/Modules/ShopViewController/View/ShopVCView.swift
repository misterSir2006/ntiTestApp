//
//  VCView.swift
//  ntiFoodApp
//
//  Created by Илья Шахназаров on 06.07.2022.
//

import UIKit
import SnapKit

class ShopVCView: UIView {
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        fill()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fill()
    }
    
    //MARK: - Properties
    let categoryCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Выберите категорию"
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 36)
        
        return label
    }()
    
    let itemsCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 50
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    //MARK: - Fill
    private func fill() {
        backgroundColor = UIColor(red: 41/255, green: 41/255, blue: 41/255, alpha: 1)
        
        addSubview(categoryCollectionView)
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.lessThanOrEqualTo(150)
        }
        
        addSubview(categoryNameLabel)
        categoryNameLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview()
        }
        
        addSubview(itemsCollectionView)
        itemsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryNameLabel.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
