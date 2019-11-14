//
//  DiscountCheck.swift
//  ShoppingTask
//
//  Created by Michael Laubscher on 30/10/2019.
//  Copyright © 2019 University of Chester. All rights reserved.
//

import Foundation


class DiscountLogic : MultiBuyOffer {
    
func applies(to purchases: [Product]) -> Bool {

var count = 0
var evenDiscount = [Product]()

for item in productIds{
evenDiscount = purchases.compactMap{$0}.filter{ $0.id == item }
    count = count + evenDiscount.count
}
  if count != 0 && count >= 2{
          return true
  }
}
