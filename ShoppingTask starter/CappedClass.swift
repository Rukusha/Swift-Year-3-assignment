//
//  CappedClass.swift
//  ShoppingTask
//
//  Created by Michael Laubscher on 06/12/2019.
//  Copyright © 2019 University of Chester. All rights reserved.
//

class CappedClass : CappedOffer {

    var name: String
    var productIds : Set<Int>
    var maxPrice: Int
    var productQuantity : Int
    var count: Int
    var price: Int
    
    init(){
        name = "Three meats for £15"
        productIds = [301,302,303,304,305,306]
        maxPrice = 1500
        productQuantity = 5
        count = 0
        price = 0
    }
}
