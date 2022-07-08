//
//  Categories.swift
//  ntiFoodApp
//
//  Created by Илья Шахназаров on 06.07.2022.
//

import UIKit

struct MenuList: Codable {
    var menuID: String
    var image: String
    var name: String
    var subMenuCount: Int
}

struct Category: Codable {
    var status: Bool
    var menuList: [MenuList]
}

