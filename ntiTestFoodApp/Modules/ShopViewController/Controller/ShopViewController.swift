//
//  ViewController.swift
//  ntiFoodApp
//
//  Created by Илья Шахназаров on 05.07.2022.
//

import UIKit
import Kingfisher

class ShopViewController: UIViewController {
    private let logoView = LogoView()
    private let shopVcView = ShopVCView()
    
    private let categoryReuseIdentifier = "categoryCell"
    private let itemsReuseIdentifier = "itemCell"
    
    let categoryUrlString = "https://vkus-sovet.ru/api/getMenu.php"
    let itemUrlString = "https://vkus-sovet.ru/api/getSubMenu.php"
    
    var category: Category?
    var item: Item?
    
    override func loadView() {
        view = shopVcView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        setNavBar()
        setCollectionView()
        getCategories()
    }
    
//MARK: - VC Setup
    func setNavBar() {
        let backItem = UIBarButtonItem(image: UIImage(systemName: "phone"), style: .plain, target: self, action: nil)
        backItem.tintColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoView)
        navigationItem.rightBarButtonItem = backItem
    }
    
    func setCollectionView() {
        shopVcView.categoryCollectionView.dataSource = self
        shopVcView.categoryCollectionView.delegate = self
        shopVcView.categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: categoryReuseIdentifier)

        shopVcView.itemsCollectionView.dataSource = self
        shopVcView.itemsCollectionView.delegate = self
        shopVcView.itemsCollectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: itemsReuseIdentifier)
    }
    
//MARK: - API Setup
    func getCategories() {
        if let url = URL(string: categoryUrlString) {
            if let data = try? Data(contentsOf: url) {
                if let jsonCategories = try? JSONDecoder().decode(Category.self, from: data) {
                    category = jsonCategories
                }
            }
        }
    }
    
    func finishPost(message:String, data:Data?) -> Void {
        do {
            if let jsonData = data {
                let parsedData = try JSONDecoder().decode(Item.self, from: jsonData)
                item = parsedData
                DispatchQueue.main.async {
                    self.shopVcView.itemsCollectionView.reloadData()
                }
            }
        }
        catch {
            print("Parse Error: \(error)")
        }
    }
    
    @objc func addToCart(item: String) {
        let ac = UIAlertController(title: "Товар \(item) был добавлен в корзину", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "ОК", style: .default))
        
        present(ac, animated: true)
    }
}
//MARK: - UICollectionViewDataSource
extension ShopViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let categories = category else { return 0 }
        
        if collectionView == shopVcView.categoryCollectionView {
            return categories.menuList.count
        } else {
            guard let items = item else { return 0 }
            return items.menuList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == shopVcView.categoryCollectionView {
            guard let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryReuseIdentifier, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
            guard let specCategory = category?.menuList[indexPath.item] else { return UICollectionViewCell() }
            
            categoryCell.categoryNameLabel.text = specCategory.name
            categoryCell.categoryImageView.kf.setImage(with: URL(string: "https://vkus-sovet.ru\(specCategory.image)"))
            categoryCell.quantityLabel.text = "\(specCategory.subMenuCount.convertToItems())"
            
            return categoryCell
        } else {
            guard let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: itemsReuseIdentifier, for: indexPath) as? ItemCollectionViewCell else { return UICollectionViewCell() }
            guard let specItem = item?.menuList[indexPath.item] else { return UICollectionViewCell() }
            
            itemCell.itemNameLabel.text = specItem.name
            itemCell.itemContentsLabel.text = specItem.content
            itemCell.priceItemLabel.text = "\(specItem.price.dropLast(3)) ₽"
            itemCell.weightItemLabel.text = "/ \(specItem.weight ?? "TBD")"
            
            if specItem.spicy == "Y" {
                itemCell.spicyItemLabel.text = "S"
            } else {
                itemCell.spicyItemLabel.text = ""
            }
            
            itemCell.itemImageView.kf.setImage(with: URL(string: "https://vkus-sovet.ru\(specItem.image)"))
            
            itemCell.cellDelegate = self
            
            return itemCell
        }
    }
    
}

//MARK: - UICollectionViewDelegate
extension ShopViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == shopVcView.categoryCollectionView {
            guard let specCategory = category?.menuList[indexPath.item] else { return }
            
            shopVcView.categoryNameLabel.text = specCategory.name
            ApiService.callPost(url: URL(string: itemUrlString)!, params: ["menuID" : specCategory.menuID], finish: finishPost)
            shopVcView.itemsCollectionView.reloadData()
        }
    }
}

extension ShopViewController: CellDelegate {
    func wasTapped(text: String) {
        let ac = UIAlertController(title: "Товар \(text) был добавлен в корзину", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "ОК", style: .default))
        present(ac, animated: true)
    }
}


//MARK: - UICollectionViewDelegateFlowLayout
extension ShopViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var w: CGFloat
        var h: CGFloat
        
        if collectionView == shopVcView.categoryCollectionView {
            w = collectionView.bounds.width / 3.0 - 12
            h = collectionView.bounds.height - 5

            return CGSize(width: w, height: h)
        } else {
            w = collectionView.bounds.width / 2.55 + 10
            h = collectionView.bounds.height / 1.9 + 10
            
            return CGSize(width: w, height: h)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == shopVcView.categoryCollectionView {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 20, left: 20, bottom: 30, right: 20)
        }
    }
}
