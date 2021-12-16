
import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    
    //===========================================
    @IBAction func signInPressed(_ sender: UIButton) {
        
        if validate(){
            fetchSignIn()
        }
    }
    //===========================================
    override func viewDidLoad() {
        
        super.viewDidLoad()
                
        userNameTextField.delegate = self
        pwdTextField.delegate = self

    }
    //===========================================
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    //===========================================
    func validate() -> Bool{
            
        if !FormValidation.isValidUserName(input: userNameTextField.text){
            userNameTextField.placeholder = "enter valid username (4-10 letters/numbers)"
        }
            
        else if !FormValidation.isValidPwd(input: pwdTextField.text){
            pwdTextField.placeholder = "enter valid password (8-16 letters/numbers)"
        }
            
            //else means all fields are correct
        else{
            return true
        }
        
        //not else means some field or more is incorrect
        return false
    }
    //===========================================
    func fetchSignIn(){
        
        if let url = URL(string: K.url + K.loginPath){
            
            let parameters = "username=\(userNameTextField.text!)&password=\(pwdTextField.text!)"
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = parameters.data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check for Error
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
                
                // Convert HTTP Response Data to a String
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    //print("Response data string:\n \(dataString)")
                }
                
                self.decode(data: data)
            }
            
            task.resume()
        }
    }
    //===========================================
    //decode response data
    func decode(data: Data?){
        
        if let decodedData = data {
            let decoder = JSONDecoder()
            
            //========handle success response=======
            do{
                let result = try decoder.decode(AuthSuccessResponse.self, from: decodedData)
                
                //print("........decoded response in signin: \(result)")
                
                //handle success sign in
                //save token
                CoreDataManager.setToken(result.access_token)
                CoreDataManager.setAuthorized(true)
                
                
                //................will delete....for convinience
                CoreDataManager.setRegistered(true)
                //----------------------------??????????????????
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "signInToMainMenu", sender: self)
                }
                
            }catch{
                print("error in decoding to AuthSuccessResponse: \(error)")
                
                //========handle faild response=======
                do{
                    let result = try decoder.decode(AuthFaildResponse.self, from: decodedData)
                    //handle faild sign in
                    
                }catch{
                    print("error in decoding to AuthFaildResponse: \(error)")
                    
                }
            }
            
        }
    }
    //===========================================

}
