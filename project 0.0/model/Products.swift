
import Foundation

class Products{
    
    //the whole respopnse products array
    static private var allProducts: [ProductsResponse] = []
    
//========================================================
    //set the products array
    static func setAllProducts(_ newProductsArr: [ProductsResponse]){
        
        allProducts = newProductsArr
    }
//========================================================
    //get all products of given type
    static func getAllTProductsByType(_ type: String) -> [ProductsResponse]{
        
        var arr: [ProductsResponse] = []
        
        for item in allProducts{
            if item.type == type{
                arr.append(item)
            }
        }
        return arr
    }
//========================================================
    //return number of products of given type
    static func getProductsNumByType(_ type: String) -> Int{
        
        return getAllTProductsByType(type).count
    }
//========================================================
    //return number of types
    static func getNumOfTypes() -> Int {
        return getListOfTypes().count
    }
//========================================================
    //return type of given index
    static func getType(_ index: Int) -> String{
        return getListOfTypes()[index]
    }
//========================================================
    //return array of types
    static private func getListOfTypes() -> [String]{
        
        var set: Set<String> = []
        for item in allProducts{
            set.insert(item.type)
        }
        return Array(set)
    }
//========================================================
}
