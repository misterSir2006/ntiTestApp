//
//  ItemCollectionViewCell.swift
//  ntiFoodApp
//
//  Created by Илья Шахназаров on 06.07.2022.
//

import UIKit
import SnapKit

protocol CellDelegate: AnyObject {
    func wasTapped(text: String)
}

class ItemCollectionViewCell: UICollectionViewCell {
    
    weak var cellDelegate: CellDelegate?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        fill()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Properties
    let itemNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    let itemContentsLabel: UILabel = {
        let label = UILabel()
        label.text = "Contents"
        label.font = UIFont.systemFont(ofSize: 8)
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
//        label.sizeToFit()
        
        return label
    }()
    
    let addToCartButton: UIButton = {
        let button = UIButton()
        button.setTitle("В корзину", for: .normal)
        button.setTitleColor(UIColor(white: 1, alpha: 1), for: .normal)
        button.backgroundColor = UIColor(red: 80/256, green: 99/256, blue: 250/256, alpha: 1)
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        return imageView
    }()
    
    let priceItemLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .right
        
        return label
    }()
    
    let weightItemLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .lightGray
        label.textAlignment = .left
        
        return label
    }()
    
    let spicyItemLabel: UILabel = {
        let label = UILabel()
        label.text = "S"
        label.textColor = .red
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    @objc func tap() {
        cellDelegate?.wasTapped(text: itemNameLabel.text ?? "")
    }
    
    //MARK: - Fill
    private func fill() {
        backgroundColor = .black
        layer.cornerRadius = 8
        
        addToCartButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
        
        addSubview(itemNameLabel)
        itemNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.left.right.equalToSuperview().inset(2)
            make.height.equalTo(36)
        }
        
        addSubview(itemContentsLabel)
        itemContentsLabel.snp.makeConstraints { make in
            make.top.equalTo(itemNameLabel.snp.bottom).offset(-8)
            make.left.right.equalToSuperview().inset(5)
            make.height.equalTo(60)
        }
        
        addSubview(itemImageView)
        itemImageView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.45)
        }
        
        addSubview(priceItemLabel)
        priceItemLabel.snp.makeConstraints { make in
            make.bottom.equalTo(itemImageView.snp.top).offset(-2)
            make.right.equalTo(snp.centerX).offset(-2)
        }
        
        addSubview(weightItemLabel)
        weightItemLabel.snp.makeConstraints { make in
            make.bottom.equalTo(priceItemLabel.snp.bottom).offset(-2)
            make.left.equalTo(snp.centerX).offset(2)
        }
        
        addSubview(spicyItemLabel)
        spicyItemLabel.snp.makeConstraints { make in
            make.bottom.equalTo(itemImageView.snp.top).offset(-4)
            make.right.equalToSuperview().offset(-4)
        }
        
        addSubview(addToCartButton)
        addToCartButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(40)
            make.centerY.equalTo(snp.bottom)
        }
    }
}
