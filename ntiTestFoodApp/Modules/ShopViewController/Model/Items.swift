//
//  Items.swift
//  ntiFoodApp
//
//  Created by Илья Шахназаров on 06.07.2022.
//

import UIKit

struct ItemList: Codable {
    var id: String
    var image: String
    var name: String
    var content: String
    var price: String
    var weight: String?
    var spicy: String?
}

struct Item: Codable {
    var status: Bool
    var menuList: [ItemList]
}
