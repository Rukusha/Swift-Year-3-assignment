///Buy a certain number if items from of each group and pay £20.99 (e.g. 2 pizzas, 2 sides, 1 garlic bread and 1 dessert)
class WinterWarmerOffer : ComplexSelectionOffer {
    var productIdGroupsAndQuantities: Array<(items: Set<Int>, quantity: Int)>
    var maxPrice: Int
    var name: String
    
    var side: Int
    var pizza: Int
    var dessert: Int
    var garlic: Int
    
    var pizzaAmount: Int
    var sideAmount: Int
    var garlicAmount: Int
    var dessertAmount: Int

    
    init(){
        let pizzas = [2002, 2004, 2001]
        let sides = [2006, 2003]
        let garlicBreads = [2005, 1011]
        let desserts = [2007]
        
        let pizzaRule = (items: Set(pizzas), quantity: 2)
        let sidesRule = (items: Set(sides), quantity: 2)
        let garlicBreadRule = (items: Set(garlicBreads), quantity: 1)
        let dessertRule = (items: Set(desserts), quantity: 1)
        
        name = "Winter Warmer"
        productIdGroupsAndQuantities = [pizzaRule, sidesRule, garlicBreadRule, dessertRule]
        maxPrice = 2099
        
        side = 0
        pizza = 0
        dessert = 0
        garlic = 0
        
        pizzaAmount = productIdGroupsAndQuantities[0].quantity
        sideAmount = productIdGroupsAndQuantities[1].quantity
        garlicAmount = productIdGroupsAndQuantities[2].quantity
        dessertAmount = productIdGroupsAndQuantities[3].quantity
    }
}
