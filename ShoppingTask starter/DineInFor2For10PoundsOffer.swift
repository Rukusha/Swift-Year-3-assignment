///Buy one item from each category and pay just £10
class DineInFor2For10PoundsOffer : SelectionOffer {
    var productIdGroups: Set<Set<Int>>
    
    var maxPrice: Int

    var name: String
    
    var sides: Int
    var mains: Int
    var desserts: Int
    var wines: Int
    
    init(){
        
        let sideIds : Set<Int> = [1011,1012] //garlic bread, mushrooms
        let mainIds : Set<Int> = [305,306] //pork chops, chicken drumsticks
        let dessertIds : Set<Int> = [1001,1002,1003] //choc puding, tiramisu, profiteroles
        let wineIds : Set<Int> = [901,902] //sauv blanc, cabernet sauvignon

        
        productIdGroups = [sideIds,mainIds,dessertIds,wineIds]
        maxPrice = 1000
        
        name = "Dine in for 2 for £10"
        sides = 0
        mains = 0
        desserts = 0
        wines = 0
    }
    func applies(to purchases: [Product]) -> Bool {
        
        sides = 0
        mains = 0
        desserts = 0
        wines = 0
        
        var groupCount = 0
//        loops througn the food items ids and sorts them into 4 seperate arrays
        for IdGroups in productIdGroups{
            for item in IdGroups{
                switch groupCount {
                case 0:
                    sides = sides + purchases.filter{$0.id == item}.count
                case 1:
                    mains = mains + purchases.filter{$0.id == item}.count
                case 2:
                    desserts = desserts + purchases.filter{$0.id == item}.count
                case 3:
                    wines = wines + purchases.filter{$0.id == item}.count
                default:
                    print("No cases triggered")
                }
            }
            groupCount += 1
        }
//        check to make sure each array has at least one item in it
         if sides > 0 && mains > 0 && desserts > 0 && wines > 0 {
             return true
         }
         return false
    }
    
    func discount(for purchases: [Product]) -> Int {
        var price = 0
        
        var sidesArray = [Product]()
        var mainsArray = [Product]()
        var dessertsArray = [Product]()
        var winesArray = [Product]()

        var groupCount = 0
        //  loops througn the food items ids and sorts them into 4 seperate arrays

        for IdGroups in productIdGroups{
            for item in IdGroups{
                switch groupCount {
                case 0:
                    sidesArray = sidesArray + purchases.compactMap{$0}.filter{ $0.id == item }
                case 1:
                    mainsArray = mainsArray + purchases.compactMap{$0}.filter{ $0.id == item }
                case 2:
                    dessertsArray = dessertsArray + purchases.compactMap{$0}.filter{ $0.id == item }
                case 3:
                    winesArray = winesArray + purchases.compactMap{$0}.filter{ $0.id == item }
                default:
                    print("No cases triggered")
                }
            }
            groupCount += 1
        }
        //  sorts the arrays by price
        let sorted_sidesArray = sidesArray.sorted { $0.price > $1.price }
        let sorted_mainsArray = mainsArray.sorted { $0.price > $1.price }
        let sorted_dessertsArray = dessertsArray.sorted { $0.price > $1.price }
        let sorted_winesArray = winesArray.sorted { $0.price > $1.price }
        
        //  strides through each array and creates a new array/ arrays of chunks
        let sideChunks = stride(from: 0, to: sorted_sidesArray.count, by: 1).map {
            Array(sorted_sidesArray[$0..<min($0 + 1, sorted_sidesArray.count)])
        }
        let mainChunks = stride(from: 0, to: sorted_mainsArray.count, by: 1).map {
            Array(sorted_mainsArray[$0..<min($0 + 1, sorted_mainsArray.count)])
        }
        let dessertChunks = stride(from: 0, to: sorted_dessertsArray.count, by: 1).map {
            Array(sorted_dessertsArray[$0..<min($0 + 1, sorted_dessertsArray.count)])
        }
        let wineChunks = stride(from: 0, to: sorted_winesArray.count, by: 1).map {
            Array(sorted_winesArray[$0..<min($0 + 1, sorted_winesArray.count)])
        }
        
        let count = 0
        var outSideCount = 0
        var finalDiscount = 0
        
        //  creates an array of all the chunks lengths
        let order = [sideChunks.count, mainChunks.count, dessertChunks.count, wineChunks.count]
        //  grabs the lowest value
        let lowestArray = order.min()
        //  while loop to iterate over the Chunks by the amount of applicable chunks. chunk that has 1 item in each of their 4 arrays
        while outSideCount < lowestArray!{
            price = 0
            // while to compare the current total vs the maxprice
            while maxPrice >= price{
                // adds up the prices in the current chunk
                price = price + sideChunks[outSideCount][count].price + mainChunks[outSideCount][count].price + dessertChunks[outSideCount][count].price + wineChunks[outSideCount][count].price
                
                finalDiscount = finalDiscount + price
            }
            // check to make sure the final amount if greater than the max price
            if finalDiscount > maxPrice{
                finalDiscount = finalDiscount - maxPrice
            }
            outSideCount += 1
        }
        return finalDiscount
    }

    
}
