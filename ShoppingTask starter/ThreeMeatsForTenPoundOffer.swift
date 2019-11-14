///Three meats for a maximum of £10 🍗🍗🍗
class ThreeMeatsForTenPoundOffer : CappedOffer{

    var name: String
    var productIds : Set<Int>
    var maxPrice: Int
    var productQuantity : Int
    
    init(){
        name = "Three meats for £10"
        productIds = [301,302,303,304,305,306]
        maxPrice = 1000
        productQuantity = 3
    }
    
    
    func applies(to purchases: [Product]) -> Bool {
        var priceFinal = 0
        var discount = [Product]()
         
            //  Creating an array of the valid items
            for item in productIds{
                discount = discount + purchases.compactMap{$0}.filter{ $0.id == item }
            }
        //  sorting the array from highest to lowest
         discount = discount.sorted { $1 > $0 }
        // check to make sure the array is equal to 3 or bigger
        if discount.count >= productQuantity{
            //  grabs the first 3 elements of the array
            let first3 = discount.prefix(3)
            //  loops through and prices them up
            for item in first3{
                priceFinal = priceFinal + item.price
            }
            //  check to make sur ethe price returned is greater than the max price
            if priceFinal >= maxPrice{
                return true
            }
        }
            return false
    }

    func discount(for purchases: [Product]) -> Int {
        var price = 0
        var discount = [Product]()
            //  Creating an array of the valid items
            for item in productIds{
                discount = discount + purchases.compactMap{$0}.filter{ $0.id == item }
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
