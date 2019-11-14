///Free softener with every detergent bought
class FreeSoftenerWithDetergentOffer : TriggerOffer {
   
    var triggerProductIds : Set<Int>
    var discountableProductIds : Set<Int>
    var name: String
    var detergent: Int
    var softeners: Int
    
    init(){
        name = "Free Softener with Detergent"
        triggerProductIds = [617,618] //detergent
        discountableProductIds = [619,620,621] //softeners
        softeners = 0 // amount of valid softeners
        detergent = 0 // amount of valid detergents
    }
    
    func applies(to purchases: [Product]) -> Bool {
         softeners = 0
         detergent = 0
        //  makes an array of the trigger products
        for item in triggerProductIds{
            detergent = detergent + purchases.filter{$0.id == item}.count
        }
        //  makes an array of the discountable products
        for item in discountableProductIds{
            softeners = softeners + purchases.filter{$0.id == item}.count
        }
        // checks to make sure each array has a length greater than 0
         if detergent > 0 && softeners > 0 {
             return true
         }
         return false
         }
    
    func discount(for purchases: [Product]) -> Int {
        var price = 0
        var softenersArray = [Product]()
        var detergentArray = [Product]()
            //  makes an array of the trigger products
            for item in discountableProductIds{
                    softenersArray = softenersArray + purchases.compactMap{$0}.filter{ $0.id == item }
            }
            //  makes an array of the discountable products
            for item in triggerProductIds{
                     detergentArray = detergentArray + purchases.compactMap{$0}.filter{ $0.id == item }
            }
        //  sorts each array by price
        let sorted_DetergentArray = detergentArray.sorted { $0.price > $1.price }
        let sorted_SoftenersArray = softenersArray.sorted { $0.price > $1.price }

        var count = 0
        //  loops through sorted_DetergentArray
        for _ in sorted_DetergentArray{
//            checks to make sure their is a softerner 
            if count < sorted_SoftenersArray.count{
                price = price + sorted_SoftenersArray[count].price
                count += 1
            }
        }
            return price
        }
}
