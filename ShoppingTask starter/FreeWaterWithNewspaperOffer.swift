///Free bottle of 💧 (product ID 410) with every 📰 purchased (product ID 565)
class FreeWaterWithNewspaperOffer : TriggerOffer{
    
    var name: String
    var triggerProductIds : Set<Int>
    var discountableProductIds : Set<Int>
    var paper: Int
    var water: Int
    var price: Int
    
    init() {
        name = "Free Water with The Times"
        triggerProductIds = [565] //newspaper
        discountableProductIds = [410] //water
        paper = 0
        water = 0
        price = 0
    }
    func applies(to purchases: [Product]) -> Bool {

        //  makes an array of the trigger products
        for item in triggerProductIds{
            paper = purchases.filter{$0.id == item}.count
        }
        //  makes an array of dicounted products
        for item in discountableProductIds{
            water = purchases.filter{$0.id == item}.count
        }
        // checks to make sure each array has a length greater than 0
        if paper > 0 && water > 0 {
            return true
        }
        return false
            
        }
    
    func discount(for purchases: [Product]) -> Int {
            var discount = [Product]()
            var discountWater = [Product]()
            var count = 0
                //  makes an array of the trigger products
                for item in triggerProductIds{
                    discount = discount + purchases.compactMap{$0}.filter{ $0.id == item }
                }
                //  makes an array of dicounted products
                for item in discountableProductIds{
                    discountWater =  discountWater + purchases.compactMap{$0}.filter{ $0.id == item }
                }
        
        // checks to make sure each array has a length greater than 0
        if discountWater.count > 0 && discount.count > 0 {
            price = 0
//            loops through each item in discount
            for _ in discount{
                if count < discountWater.count{
                price = price + discountWater[count].price
                count += 1
                }
            }
        }
            return price
        }
}
