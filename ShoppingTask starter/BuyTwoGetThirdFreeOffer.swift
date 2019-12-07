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
}

