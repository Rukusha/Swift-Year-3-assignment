//
//  DiscountLogic.swift
//  ShoppingTask
//
//  Created by Michael Laubscher on 30/10/2019.
//  Copyright © 2019 University of Chester. All rights reserved.
//

import Foundation

//class DiscountLogic {
//    var Discount = BuyOneGetOneFreeOffer()
//
//    var productIds : Set<Int>
//    var count: Int
//
//
//    init(){
//        productIds = Discount.productIds
//        count = 0
//    }
//
//func applies(to purchases: [Product]) -> Bool {
//    count = 0
//    var evenDiscount = [Product]()
//        //  loops through the product ids and compares them to the valid ids that are acceptable creating an array of accepted products
//        for item in productIds{
//            evenDiscount = purchases.compactMap{$0}.filter{ $0.id == item }
//            count = count + evenDiscount.count
//        }
//        //    makes sure their are enough products
//        if count != 0 && count >= 2{
//              return true
//        }
//    return false
//    }
//
//func discount(for purchases: [Product]) -> Int {
//    count = 0
//    var price = 0
//    var count = 0
//    var evenDiscount = [Product]()
//        //  loops through the product ids and compares them to the valid ids that are acceptable creating an array of accepted products
//        for item in productIds{
//            evenDiscount = evenDiscount + purchases.compactMap{$0}.filter{ $0.id == item }
//        }
//    //  sorts the array price from highest to loweest
//    let sortedDiscount = evenDiscount.sorted { $1 > $0 }
//
//        //    loops through the sorted array
//        for item in sortedDiscount{
//            //     check to make sure its grabbing every other value
//            if count % 2 != 0{
//                price = price + item.price
//            }
//            count += 1
//        }
//
//            return price
//    }
//}
