/// Third item free when you buy any two deodorants
class BuyTwoGetThirdFreeOffer :MultiBuyOffer {
    
    var quantityPaid: Int
    var quantityFree: Int
    var name: String
    var productIds : Set<Int>

    
    init(){
        name = "3 for 2 on Deodorants"
        productIds = [65,66];
        quantityPaid = 2
        quantityFree = 1

    }
    
    func applies(to purchases: [Product]) -> Bool {
        var evenDiscount = [Product]()
            //  loops through the product ids and compares them to the valid ids that are acceptable creating an array of accepted products
            for item in productIds{
                evenDiscount = evenDiscount + purchases.compactMap{$0}.filter{ $0.id == item }
                // check to make sure count is equal to or greater than 3
                if evenDiscount.count >= 3{
                    return true
                }
            }
            return false
        }

    func discount(for purchases: [Product]) -> Int {
        var price = 0
        var evenDiscount = [Product]()
            
        //  loops through the product ids and compares them to the valid ids that are acceptable creating an array of accepted products
        for item in productIds{
            evenDiscount = evenDiscount + purchases.compactMap{$0}.filter{ $0.id == item }
        }
        //  sorts the array from highest to lowest
        let sortedDiscount = evenDiscount.sorted { $1 > $0 }
        //  strides through the array 3 at a time and begins at position 3. this is then added to the strided array
        let stridedArray = stride(from: sortedDiscount.startIndex + 2, to: sortedDiscount.endIndex, by: 3).map { sortedDiscount[$0] }
        //  loops through stridedArray and adds up the price
        for item in stridedArray{
            price = price + item.price
        }
        return price
    }
}

