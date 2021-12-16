
import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    
    
    //===========================================
    @IBAction func signUpPressed(_ sender: UIButton) {
        
        if validate(){
            fetchSignUp()
        }
    }
    //===========================================
    override func viewDidLoad() {
        
        super.viewDidLoad()
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        userNameTextField.delegate = self
        pwdTextField.delegate = self
        
    }
    //===========================================
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //===========================================
    func validate() -> Bool{
        
        if !FormValidation.isValidFName(input: firstNameTextField.text){
            firstNameTextField.placeholder = "enter valid name (2-10 letters)"
        }
        
        else if !FormValidation.isValidLName(input: lastNameTextField.text){
            lastNameTextField.placeholder = "enter valid name (2-10 letters)"
        }
        
        else if !FormValidation.isValidUserName(input: userNameTextField.text){
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
    func fetchSignUp(){
        
        if let url = URL(string: K.url + K.registerPath){
            
            let parameters = "firstname=\(firstNameTextField.text!)&lastname=\(lastNameTextField.text!)&username=\(userNameTextField.text!)&password=\(pwdTextField.text!)"
            
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
                
                //handle success sign up
                //save token
                CoreDataManager.setToken(result.access_token)
                CoreDataManager.setAuthorized(true)
                CoreDataManager.setRegistered(true)
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "signUpToMainMenu", sender: self)
                }
                
            }catch{
                print("error in decoding to SignUpSuccessResponse: \(error)")
                
                //========handle faild response=======
                do{
                    let result = try decoder.decode(AuthFaildResponse.self, from: decodedData)
                    //handle faild sign up
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "signUpToSignIn", sender: self)
                    }
                    
                }catch{
                    print("error in decoding to SignUpFaildResponse: \(error)")
                    
                }
            }
            
        }
    }
    //===========================================
}

