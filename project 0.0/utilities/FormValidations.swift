
import Foundation

class FormValidation{
    
    static func isValidFName(input: String?) -> Bool{
        
        let FNameRegex = "[A-Za-z]{2,10}"
        return NSPredicate(format: "SELF MATCHES %@", FNameRegex).evaluate(with: input)
    }
    
    static func isValidLName(input: String?) -> Bool{
        
        let LNameRegex = "[A-Za-z]{2,12}"
        return NSPredicate(format: "SELF MATCHES %@", LNameRegex).evaluate(with: input)
    }
    
    static func isValidUserName(input: String?) -> Bool{
        
        let UserNameRegex = "[A-Za-z0-9]{4,10}"
        return NSPredicate(format: "SELF MATCHES %@", UserNameRegex).evaluate(with: input)
    }
    
    static func isValidPwd(input: String?) -> Bool{
        
        let PwdRegex = "[A-Za-z0-9]{8,16}"
        return NSPredicate(format: "SELF MATCHES %@", PwdRegex).evaluate(with: input)
    }
}
