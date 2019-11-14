///Half price on Wine 🍷
class HalfPriceOffer : DiscountedPriceOffer {
    
    var name: String
    var productIds : Set<Int>
    var discountPercentage: Double
    var halfOfWine : Int

    init(){
        name = "Half Price on Wine"
        productIds = [901,902];
        discountPercentage = 0.5
        halfOfWine = 0
    }

    func applies(to purchases: [Product]) -> Bool {
      var evenDiscount = [Product]()
//  loops through the product ids and compares them to the valid ids that are acceptable creating an array of accepted products
            for item in productIds{
                evenDiscount = purchases.compactMap{$0}.filter{ $0.id == item }
//  checks length of acceptated product array
                if evenDiscount.count > 0{
                    return true
                }
            }
            return false
        }

    func discount(for purchases: [Product]) -> Int {
        var evenDiscount = [Product]()
        halfOfWine = 0
        var result = 0
//  loops through the product ids and compares them to the valid ids that are acceptable creating an array of accepted products
            for item in productIds{
                evenDiscount = evenDiscount + purchases.compactMap{$0}.filter{ $0.id == item }
            }
//  Maths to workout the price after the disocunt has been applied
//  urns the 0.5 into a whole number
        let dis = discountPercentage * 10
//  loops through the accepted products array
            for item in evenDiscount{
//    times the item price by 10 so that the scale matches the whole number discount value
                result = item.price * 10
//                chops returned amount down to the needed size
                halfOfWine = halfOfWine + result / Int(dis) / 4
             }
        return halfOfWine
    }
}
