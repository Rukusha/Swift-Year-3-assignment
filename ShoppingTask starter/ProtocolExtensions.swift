extension SimpleOffer {
    /**
     Returns an array containing only the Products to which the offer could be applied
     
     - parameter list: The array of Products objects to be checked
     - returns: An array of Products objects to which the offer is applicable
     */
    func qualifyingProducts(list:[Product]) -> [Product]{
        var productsInOffer = [Product]()
        
        for itemInShoppingList in list {
            if productIds.contains(itemInShoppingList.id) {
                productsInOffer.append(itemInShoppingList)
            }
        }
        return productsInOffer
    }
}
extension Transaction{
    func priceBeforeDiscounts() -> Int{
        //   sum up the price of all items
        //   initialising a variable for totalPrice
        var totalPrice: Int = 0
        //   this is where I seperate the item from the Items array and specify that I want to grab the price for each
        for item in items{
            let price: Int = item.price
            totalPrice = totalPrice + price
        }
        //   Returns the price amount before the discounts have been added
        return totalPrice;
    }
    
    func discount() -> Int{
        let discounts = Discounter(couponsEnabled: couponsEnabled).offerDiscounts(list: items)
        var total = 0
        for discount in discounts {
            total += discount.valueInPence;
        }
        return  total
    }
    
    func finalPrice() -> Int{
        //  Here I just call appon the priceBeforeDiscounts function and then remove the discount from the total using the discount function
        let totalAmount = priceBeforeDiscounts() - discount()
        
        return totalAmount
    }
    
}
extension HalfPriceOffer{
    func applies(to purchases: [Product]) -> Bool {
        //  loops through the product ids and compares them to the valid ids that are acceptable creating an array of accepted products
        for item in productIds{
            for items in purchases{
                if items.id == item{
                    return true
                }
            }
        }
        return false
    }
    func discount(for purchases: [Product]) -> Int {
        var halfOfWine : Double
        halfOfWine = 0

        //  loops through the product ids and compares them to the valid ids that are acceptable creating an array of accepted products
        for item in productIds{
            for items in purchases{
                if items.id == item{
                    //   converts price into a double
                    let doublePrice = Double(items.price)
                    //   times the item price by the discount amount
                    var result = doublePrice * discountPercentage
                    //   rounds the value down
                    result = result.rounded(.down)
                    //  returned total amount after the items have been added and discounted
                    halfOfWine = halfOfWine + result
                }
            }
        }

//        converts total back to a int
        let IntWine = Int(halfOfWine)
        return IntWine
    }
}

extension MultiBuyOffer{

        func applies(to purchases: [Product]) -> Bool {
            var count = 0
            for item in productIds{
                for items in purchases{
                    if items.id == item{
                        count += 1
                        if count >= quantityPaid + quantityFree{
                            return true
                        }
                    }
                }
            }
            return false
        }
        func discount(for purchases: [Product]) -> Int {
            var count = 0
            var price = 0
            var evenDiscount = [Product]()
            
            //  loops through the product ids and compares them to the valid ids that are acceptable creating an array of accepted products
            for item in productIds{
                for items in purchases{
                    if items.id == item{
                        evenDiscount.append(items)
                    }
                }
            }
            //  sorts the array from highest to lowest
            let sortedDiscount = evenDiscount.sorted { $1.price < $0.price }
            //  combines the paid and free amounts
            let amount = quantityPaid + quantityFree
            //grabs the items at the index of amount in this case every 2 or 3 positions
            let holder =  sortedDiscount.enumerated().compactMap { index, element in index % amount == 0 ? nil : element }

            if quantityPaid < 2{
                for item in holder{
                    price = price + item.price
                }
            }else{
                for item in holder{
                    if count != quantityPaid && count != 0{
                        price = price + item.price
                    }
                    count += 1
                }
            }
            return price
        }
    }


extension CappedOffer{
    func applies(to purchases: [Product]) -> Bool {
            var count = 0
            var price = 0
        
        let purchasesSorted = purchases.sorted { $1.price < $0.price }

            for items in purchasesSorted{
                for item in productIds{
                    if items.id == item && count < productQuantity{
                        price = price + items.price
                        count += 1
                        if count == productQuantity && price > maxPrice{
                            return true
                        }else if count > productQuantity{
                            return false
                        }
                    }
                }
            }
                return false
            }


        func discount(for purchases: [Product]) -> Int {
            var price = 0
            var discount = [Product]()
            
            //  loops through the product ids and compares them to the valid ids that are acceptable creating an array of accepted products
            for item in productIds{
                for items in purchases{
                    if items.id == item{
                        discount.append(items)
                    }
                }
            }
            //  sorting the array
            let sortedDiscount = discount.sorted { $0.price > $1.price }
            //  striding through the array creating an array of "chunks"
            let chunks = stride(from: 0, to: sortedDiscount.count, by: productQuantity).map {
                Array(sortedDiscount[$0..<min($0 + productQuantity, sortedDiscount.count)])
            }
            var noDiscount = 0
            var finalPrice = 0

            //  loops through the chunks
            for chunk in chunks{
                var insidePrice = 0
                // checks chunk length is == 3
                if chunk.count == productQuantity{
                    // loops through each item in the current chunk
                    for product in chunk{
                        // adds up the price
                        insidePrice = insidePrice + product.price
                    }
                    //  checks to make sure price is greater than the max price and if it is it removes the max price from the total
                    if insidePrice > maxPrice{
                        price = insidePrice - maxPrice
                        finalPrice = finalPrice + price
                    }else{
                        //  if it doesnt pass it returns a 0 as no discoutn is applied
                        noDiscount = 0
                    }
                }
            }

            return finalPrice + noDiscount
        }
}
extension TriggerOffer{
    func applies(to purchases: [Product]) -> Bool {
        var discountable = 0
        var trigger = 0

        for item in triggerProductIds{
            for items in purchases{
                if trigger == 1{
                    break
                }
                if items.id == item{
                    trigger += 1
                    break
                }

            }
        }

        for item in discountableProductIds{
            for items in purchases{
                if discountable == 1{
                    break
                }
                if items.id == item{
                    discountable += 1
                    break
                }
            }
        }
        if discountable + trigger == 2 {
            return true
        }
        return false
    }
    
    func discount(for purchases: [Product]) -> Int {
        var trigger = [Product]()
        var discount = [Product]()
        var triggerCount = 0
        var price = 0

        //  makes an array of the trigger products
        for Ids in triggerProductIds{
            for item in purchases{
                if Ids == item.id{
                    triggerCount += 1
                }
            }
        }
        
        //  loops through the product ids and compares them to the valid ids that are acceptable creating an array of accepted products
        for item in triggerProductIds{
            for items in purchases{
                if items.id == item{
                    trigger.append(items)
                }
            }
        }
        for item in discountableProductIds{
            for items in purchases{
                if items.id == item{
                    discount.append(items)
                }
            }
        }
        // Sorts the array
        discount = discount.sorted{$0.price > $1.price}
        // checks to make sure each array has a length greater than 0
        if discount.count > 0 && triggerCount > 0 {
            //            loops through each item in discount
            var holder = 0

            for _ in trigger{
                if holder < discount.count{
                    price = price + discount[holder].price
                    holder += 1
                }
            }
        }
        return price
    }
}

extension SelectionOffer{
    func applies(to purchases: [Product]) -> Bool {
        
        var side = [Int]()
        //        loops througn the food items ids and sorts them into an array 4 seperate arrays
        var count = 0

        for groups in productIdGroups{
            count = 0
            for items in purchases{
                for item in groups{
                        if items.id == item{
                            if count != 1{
                                count += 1
                                side.append(count)
                            }else{
                                break
                            }
                        }
                }
            }
        }
        //        check to make sure  array has at least one count of each in it
        if side.count == 4 {
            return true
        }
        return false
    }
    
    func discount(for purchases: [Product]) -> Int {
        var price = 0
        let count = 0
        var outSideCount = 0
        var finalDiscount = 0
        
        var sidesArray = [Product]()
        var mainsArray = [Product]()
        var dessertsArray = [Product]()
        var winesArray = [Product]()
        
        var groupCount = 0
        //  loops througn the food items ids and sorts them into 4 seperate arrays

        for IdGroups in productIdGroups{
            for item in IdGroups{
                for items in purchases{
                    if item == items.id{
                        switch groupCount {
                        case 0:
                            sidesArray.append(items)
                        case 1:
                            mainsArray.append(items)
                        case 2:
                            dessertsArray.append(items)
                        case 3:
                            winesArray.append(items)
                        default:
                            print("No cases triggered")
                        }
                    }
                }
            }
            groupCount += 1
        }
        //  sorts the arrays by price
        let sorted_sidesArray = sidesArray.sorted { $0.price > $1.price }
        let sorted_mainsArray = mainsArray.sorted { $0.price > $1.price }
        let sorted_dessertsArray = dessertsArray.sorted { $0.price > $1.price }
        let sorted_winesArray = winesArray.sorted { $0.price > $1.price }
        
        //  strides through each array and creates a new chunks
        let sideChunks = stride(from: 0, to: sorted_sidesArray.count, by: 1).map {
            Array(sorted_sidesArray[$0..<min($0 + 1, sorted_sidesArray.count)])
        }
        let mainChunks = stride(from: 0, to: sorted_mainsArray.count, by: 1).map {
            Array(sorted_mainsArray[$0..<min($0 + 1, sorted_mainsArray.count)])
        }
        let dessertChunks = stride(from: 0, to: sorted_dessertsArray.count, by: 1).map {
            Array(sorted_dessertsArray[$0..<min($0 + 1, sorted_dessertsArray.count)])
        }
        let wineChunks = stride(from: 0, to: sorted_winesArray.count, by: 1).map {
            Array(sorted_winesArray[$0..<min($0 + 1, sorted_winesArray.count)])
        }

        
        //  creates an array of all the chunks lengths
        let order = [sideChunks.count, mainChunks.count, dessertChunks.count, wineChunks.count]
        //  grabs the lowest value
        let lowestArray = order.min()
        //  while loop to iterate over the Chunks by the amount of applicable chunks. chunk that has 1 item in each of their 4 arrays
        while outSideCount < lowestArray!{
            price = 0
            // while to compare the current total vs the maxprice
            while maxPrice >= price{
                // adds up the prices in the current chunk
                price = price + sideChunks[outSideCount][count].price + mainChunks[outSideCount][count].price + dessertChunks[outSideCount][count].price + wineChunks[outSideCount][count].price
                
                finalDiscount = finalDiscount + price
            }
            // check to make sure the final amount if greater than the max price
            if finalDiscount > maxPrice{
                finalDiscount = finalDiscount - maxPrice
            }
            outSideCount += 1
        }
        return finalDiscount
    }
    
}
extension WinterWarmerOffer{
    func applies(to purchases: [Product]) -> Bool {
        var groupCount = 0

//        loop to get the amount of each dish required
        for _ in productIdGroupsAndQuantities{
            switch groupCount {
            case 0:
                pizzaAmount = productIdGroupsAndQuantities[groupCount].quantity
            case 1:
                sideAmount = productIdGroupsAndQuantities[groupCount].quantity
            case 2:
                garlicAmount = productIdGroupsAndQuantities[groupCount].quantity
            case 3:
                dessertAmount = productIdGroupsAndQuantities[groupCount].quantity
            default:
                print("No cases triggered")
            }
            groupCount += 1
        }
        pizza = 0
        side = 0
        garlic = 0
        dessert = 0
                
        groupCount = 0

        // loops through the purchases and sorts the valid items into seperate arrays by type
        for IdGroups in productIdGroupsAndQuantities{
            for item in IdGroups.items{
                for items in purchases{
                    if item == items.id{
                        switch groupCount {
                        case 0:
                            if pizza == 2{
                                break
                            }
                            pizza += 1
                        case 1:
                            if side == 2{
                                break
                            }
                            side += 1
                        case 2:
                            if garlic == 1{
                                break
                            }
                            garlic += 1
                        case 3:
                            if dessert == 1{
                                break
                            }
                            dessert += 1
                        default:
                            print("No cases triggered")
                        }
                    }
                }
            }
            groupCount += 1
        }
        
        // check to make sure each array has at least the amount of needed products for each rule
        if side >= sideAmount && pizza >= pizzaAmount && dessert >= dessertAmount && garlic >= garlicAmount {
            return true
        }
        return false
        
    }
    
    func discount(for purchases: [Product]) -> Int {
        var count = 0
        var overall = 0
        var price = 0
        var groupCount = 0

        var sidesArray = [Product]()
        var pizzaArray = [Product]()
        var dessertsArray = [Product]()
        var garlicArray = [Product]()
        
        // loops through the purchases and sorts the valid items into seperate arrays by type
        for IdGroups in productIdGroupsAndQuantities{
            for item in IdGroups.items{
                for items in purchases{
                    if item == items.id{
                        switch groupCount {
                        case 0:
                            pizzaArray.append(items)
                        case 1:
                            sidesArray.append(items)
                        case 2:
                            dessertsArray.append(items)
                        case 3:
                            garlicArray.append(items)
                        default:
                            print("No cases triggered")
                        }
                    }
                }
            }
            groupCount += 1
        }

        //  sorts the arrays by price
        var sorted_PizzaArray = pizzaArray.sorted { $1.price < $0.price }
        var sorted_SidesArray = sidesArray.sorted { $1.price < $0.price }
        var sorted_DessertArray = dessertsArray.sorted { $1.price < $0.price }
        var sorted_GarlicArray = garlicArray.sorted { $1.price < $0.price }
        

        // while loop that will keep running untill there is no more pizzas left
        while sorted_PizzaArray.count >= count {
            price = 0
            // Grabs the amount of each item needed from the sorted array e.g. 2 pizzas
            let pizza_2items = sorted_PizzaArray.prefix(pizzaAmount)
            let side_2items = sorted_SidesArray.prefix(sideAmount)
            let dessert_1items = sorted_DessertArray.prefix(dessertAmount)
            let garlic_1items = sorted_GarlicArray.prefix(garlicAmount)
            
            // check to make sure there are enough of the items in the arrays
            if pizza_2items.count == pizzaAmount && side_2items.count == sideAmount && dessert_1items.count == dessertAmount && garlic_1items.count == garlicAmount{
                
                // creates an array of all the items for this pass of the order
                let mealArray = [pizza_2items, side_2items, dessert_1items, garlic_1items]
                // loops through the array and tallies up the price
                for group_Items in mealArray{
                    for item in group_Items {
                        price = price + item.price
                    }
                }
                // checks to make sure that there are more items of each kind needed in the original sorted arrays
                if pizzaArray.count > pizzaAmount && sidesArray.count > sideAmount && dessertsArray.count > dessertAmount && garlicArray.count > garlicAmount{
                    
                    // removes the items from the original array
                    sorted_PizzaArray.removeFirst(pizzaAmount)
                    sorted_SidesArray.removeFirst(sideAmount)
                    sorted_DessertArray.removeFirst(dessertAmount)
                    sorted_GarlicArray.removeFirst(garlicAmount)
                }
//                checks to see if its the first pass over the list
                if count <= 1{
                    overall = overall + price - maxPrice
                    
                }else{
                    overall = price - maxPrice
                }
            }
            count += 1
        }
        return overall
    }
}
