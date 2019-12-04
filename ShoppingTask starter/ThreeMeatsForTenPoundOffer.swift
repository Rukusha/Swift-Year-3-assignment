///Three meats for a maximum of £10 🍗🍗🍗
class ThreeMeatsForTenPoundOffer : CappedOffer{

    var name: String
    var productIds : Set<Int>
    var maxPrice: Int
    var productQuantity : Int
    var count: Int
    var price: Int
    
    init(){
        name = "Three meats for £10"
        productIds = [301,302,303,304,305,306]
        maxPrice = 1000
        productQuantity = 3
        count = 0
        price = 0
    }
}
