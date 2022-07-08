//
//  LogoView.swift
//  ntiFoodApp
//
//  Created by Илья Шахназаров on 05.07.2022.
//

import UIKit
import SnapKit

class LogoView: UIView {
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        fill()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fill()
    }
        
    // MARK: - Properties
    let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "VS"
        label.textColor = .white
        label.backgroundColor = .red
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 15
        label.font = UIFont(name: "RoundedMplus1c-Black", size: 18)

        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "VKUSSOVET"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "RoundedMplus1c-Black", size: 22)
        label.backgroundColor = .clear
        
        return label
    }()
    
    // MARK: - Fill
    private func fill() {
        addSubview(logoLabel)
        logoLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(16)
            make.height.equalTo(30)
            make.width.equalTo(logoLabel.snp.height)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(logoLabel.snp.bottom)
            make.left.equalTo(logoLabel.snp.right).offset(8)
        }
    }
}
