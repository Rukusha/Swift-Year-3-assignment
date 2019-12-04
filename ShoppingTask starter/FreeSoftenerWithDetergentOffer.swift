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
}
