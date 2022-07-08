//
//  CategoryCollectionViewCell.swift
//  ntiFoodApp
//
//  Created by Илья Шахназаров on 06.07.2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ?
                UIColor(red: 80/256, green: 99/256, blue: 250/256, alpha: 1)
                : UIColor(red: 68/255, green: 69/255, blue: 70/255, alpha: 1)
        }
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        fill()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Properties
    var categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .yellow
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return imageView
    }()
    
    var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.boldSystemFont(ofSize: 14.5)
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    var quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "N quantity"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.textAlignment = .center
        
        return label
    }()
    
    //MARK: - Fill
    private func fill() {
        backgroundColor = UIColor(red: 68/255, green: 69/255, blue: 70/255, alpha: 1)
        layer.cornerRadius = 8
        
        addSubview(categoryImageView)
        categoryImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        addSubview(categoryNameLabel)
        categoryNameLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryImageView.snp.bottom)
            make.left.right.equalToSuperview().inset(4)
            make.height.equalTo(40)
        }
        
        addSubview(quantityLabel)
        quantityLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.left.right.equalToSuperview().inset(8)
        }
    }
}
