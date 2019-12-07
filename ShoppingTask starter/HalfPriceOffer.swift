///Half price on Wine 🍷
class HalfPriceOffer : DiscountedPriceOffer {
    
    var name: String
    var productIds : Set<Int>
    var discountPercentage: Double

    init(){
        name = "Half Price on Wine"
        productIds = [901,902];
        discountPercentage = 0.5
    }
}
