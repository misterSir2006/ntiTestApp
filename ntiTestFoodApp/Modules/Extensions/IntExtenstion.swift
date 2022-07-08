//
//  Numbers.swift
//  ntiFoodApp
//
//  Created by Илья Шахназаров on 07.07.2022.
//

import UIKit

extension Int {
    func convertToItems() -> String {
        
        let curr = self % 100
        
        if curr >= 5 && curr <= 20 {
            return self.description + " товаров"
        }
        
        let doubleCurr = curr % 10
        
        if doubleCurr == 1 {
            return self.description + " товар"
        } else if doubleCurr <= 4 {
            return self.description + " товара"
        }
        
        return self.description + " товаров"
    }
}
