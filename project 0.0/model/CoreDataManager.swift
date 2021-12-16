
import Foundation

class CoreDataManager{
    
//    {
//        get{return StorageManager.defaults.string(forKey: "token")}
//        set{ StorageManager.defaults.set(StorageManager.token, forKey: "token")}
//    }

    //static var registered = false
//    {
//        get{return StorageManager.defaults.bool(forKey: "isRegistered")}
//        set{ StorageManager.defaults.set(StorageManager.isRegistered, forKey: "isRegistered")}
//    }

    //static var authorized = false
//    {
//        get{return StorageManager.defaults.bool(forKey: "isAuthorized")}
//        set{ StorageManager.defaults.set(StorageManager.isAuthorized, forKey: "isAuthorized")}
//    }
    
    
    static var defaults = UserDefaults.standard
    static var token: String? = nil
    
    init(){
        CoreDataManager.defaults.set("", forKey: "token")
        CoreDataManager.defaults.set(false, forKey: "isRegistered")
        CoreDataManager.defaults.set(false, forKey: "isAuthorized")
    }
    
    static func getToken() -> String? {
        return CoreDataManager.defaults.string(forKey: "token")
    }
    static func setToken(_ token: String){
        CoreDataManager.defaults.set(token, forKey: "token")
    }
    
    static func isRegistered() -> Bool {
        return CoreDataManager.defaults.bool(forKey: "isRegistered")
    }
    static func setRegistered(_ bool: Bool){
        CoreDataManager.defaults.set(bool, forKey: "isRegistered")
    }
    
    static func isAuthorized() -> Bool {
        return CoreDataManager.defaults.bool(forKey: "isAuthorized")
    }
    static func setAuthorized(_ bool: Bool){
        CoreDataManager.defaults.set(bool, forKey: "isAuthorized")
    }

}
