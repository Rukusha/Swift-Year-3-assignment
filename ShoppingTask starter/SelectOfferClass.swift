//
//  SelectOfferClass.swift
//  ShoppingTask
//
//  Created by Michael Laubscher on 06/12/2019.
//  Copyright © 2019 University of Chester. All rights reserved.
//

///Buy one item from each category and pay just £10
class SelectOfferClass : SelectionOffer {
    var productIdGroups: Set<Set<Int>>
    
    var maxPrice: Int

    var name: String
    
    
    init(){
        
        let sideIds : Set<Int> = [1011,1012] //garlic bread, mushrooms
        let mainIds : Set<Int> = [305,306] //pork chops, chicken drumsticks
        let dessertIds : Set<Int> = [1001,1002,1003] //choc puding, tiramisu, profiteroles
        let wineIds : Set<Int> = [901,902] //sauv blanc, cabernet sauvignon

        
        productIdGroups = [sideIds,mainIds,dessertIds,wineIds]
        maxPrice = 1200
        
        name = "Dine in for 2 for £10"
    }
}
