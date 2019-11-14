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
        
        sideAmount = 0
        pizzaAmount = 0
        dessertAmount = 0
        garlicAmount = 0
    }
    func applies(to purchases: [Product]) -> Bool {

        var groupCount = 0
        // grabs the amount of needed items for each of the rules
        pizzaAmount = productIdGroupsAndQuantities[0].quantity
        sideAmount = productIdGroupsAndQuantities[1].quantity
        garlicAmount = productIdGroupsAndQuantities[2].quantity
        dessertAmount = productIdGroupsAndQuantities[3].quantity

        side = 0
        pizza = 0
        dessert = 0
        garlic = 0
        
        groupCount = 0
        // loops through the purchases and sorts the valid items into seperate arrays by type
        for IdGroups in productIdGroupsAndQuantities{
            for item in IdGroups.items{
                switch groupCount {
                case 0:
                    pizza = pizza + purchases.filter{$0.id == item}.count
                case 1:
                    side = side + purchases.filter{$0.id == item}.count
                case 2:
                    garlic = garlic + purchases.filter{$0.id == item}.count
                case 3:
                    dessert = dessert + purchases.filter{$0.id == item}.count
                default:
                    print("No cases triggered")
                }
        }
            groupCount += 1
            
        }

        // check to make sure each array has at least the amount of needed products for each rule
        if side >= sideAmount && pizza >= pizzaAmount && dessert >= dessertAmount && garlic >= garlicAmount {
            return true
        }
        return false
        
    }
    
    func discount(for purchases: [Product]) -> Int {
        var price = 0
        var sidesArray = [Product]()
        var pizzaArray = [Product]()
        var dessertsArray = [Product]()
        var garlicArray = [Product]()

        var groupCount = 0
        // loops through the purchases and sorts the valid items into seperate arrays by type
        for IdGroups in productIdGroupsAndQuantities{
            for item in IdGroups.items{
                switch groupCount {
                case 0:
                    pizzaArray = pizzaArray + purchases.compactMap{$0}.filter{ $0.id == item }
                case 1:
                    sidesArray = sidesArray + purchases.compactMap{$0}.filter{ $0.id == item }
                case 2:
                    dessertsArray = dessertsArray + purchases.compactMap{$0}.filter{ $0.id == item }
                case 3:
                    garlicArray = garlicArray + purchases.compactMap{$0}.filter{ $0.id == item }
                default:
                    print("No cases triggered")
                    
                }
                
            }
        groupCount += 1
        }
        //  sorts the arrays by price
        var sorted_PizzaArray = pizzaArray.sorted { $1 > $0 }
        var sorted_SidesArray = sidesArray.sorted { $1 > $0 }
        var sorted_DessertArray = dessertsArray.sorted { $1 > $0 }
        var sorted_GarlicArray = garlicArray.sorted { $1 > $0 }
        
        var count = 0
        var overall = 0
        var testPrice = 0
        
        while sorted_PizzaArray.count >= count {
            testPrice = 0
            
            let pizza2 = sorted_PizzaArray.prefix(2)
            let side2 = sorted_SidesArray.prefix(2)
            let dessert1 = sorted_DessertArray.prefix(1)
            let garlic1 = sorted_GarlicArray.prefix(1)
            
            if pizza2.count == 2 && side2.count == 2 && dessert1.count == 1 && garlic1.count == 1{

                let testArray = [pizza2, side2, dessert1, garlic1]
                        for group_Items in testArray{
                            for item in group_Items {
                                testPrice = testPrice + item.price
                            }
                        }
                if pizzaArray.count > 2 && sidesArray.count > 2 && dessertsArray.count > 1 && garlicArray.count > 1{
                    
                    sorted_PizzaArray.removeFirst(2)
                    sorted_SidesArray.removeFirst(2)
                    sorted_DessertArray.removeFirst(1)
                    sorted_GarlicArray.removeFirst(1)
                }
                if count <= 1{
                    overall = overall + testPrice - maxPrice

                }else{
                    overall = testPrice - maxPrice
                }
            }
            count += 1
            
        }
        return overall
        
    }
}
