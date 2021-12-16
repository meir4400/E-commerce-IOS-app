
import UIKit

class EntryViewColntroller: UIViewController {
    
//===========================================
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
//===========================================
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

//===========================================
    @IBAction func signInPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "entryToSignIn", sender: self)
    }
//===========================================
    @IBAction func signUpPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "entryToSignUp", sender: self)
    }
//===========================================
    
}

