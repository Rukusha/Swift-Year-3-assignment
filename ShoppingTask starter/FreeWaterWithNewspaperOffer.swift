///Free bottle of 💧 (product ID 410) with every 📰 purchased (product ID 565)
class FreeWaterWithNewspaperOffer : TriggerOffer{
    
    var name: String
    var triggerProductIds : Set<Int>
    var discountableProductIds : Set<Int>
    var count: Int
    var price: Int
    
    init() {
        name = "Free Water with The Times"
        triggerProductIds = [565] //newspaper
        discountableProductIds = [410] //water
        count = 0
        price = 0
    }
}
