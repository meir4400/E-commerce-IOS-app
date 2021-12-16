

import UIKit

class MainMenuViewController: UITableViewController {

    @IBOutlet var menuTable: UITableView!

    //============================================
    override func viewDidLoad() {
        super.viewDidLoad()

        print(#function + ".......view load")

        //handle unAuthorized user or missing token
        if !CoreDataManager.isAuthorized() ||
            CoreDataManager.getToken() == nil {

            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "MainMenuToSignIn", sender: self)
            }
        }

        menuTable.register(UINib(nibName: "MainMenuCell", bundle: nil), forCellReuseIdentifier: "menuCell")

        fetchProducts()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    //============================================
    func updateTable(){

        DispatchQueue.main.async {
            self.menuTable.reloadData()
        }
    }
    //============================================
    func fetchProducts(){


        print(#function + ".......fetchProducts")

        if let url = URL(string: K.url + K.productsPath){

            var request = URLRequest(url: url)
            if let token = CoreDataManager.getToken(){
                request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
            }

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

                // Check for Error
                if let error = error {
                    print("Error took place \(error)")
                    return
                }

                // Convert HTTP Response Data to a String
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    //print("Response products string:\n \(dataString)")
                }

                self.decode(data: data)
            }

            task.resume()
        }
    }
    //===========================================
    //decode response data
    func decode(data: Data?){

        print(#function + ".......decode")

        if let decodedData = data {
            let decoder = JSONDecoder()

            //--------handle success response--------
            do{
                let result = try decoder.decode([ProductsResponse].self, from: decodedData)

                //handle success get products
                Products.setAllProducts(result)
                updateTable()

            }catch{
                print("error in decoding to ProductsResponse: \(error)")

                //-----------handle faild response--------
                do{
                    let result = try decoder.decode(ProductsResponse/*???*/.self, from: decodedData)
                    //handle faild sign in

                }catch{
                    print("error in decoding to AuthFaildResponse: \(error)")

                }
            }

        }
    }
    //============================================
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //============================================
    // MARK: - Table view data source

    //============================================
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //============================================
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Products.getNumOfTypes()
    }

    //============================================
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableCell

        cell.cellLabel.text = Products.getType(indexPath.row)
        //cell.imageCell =

        return cell
    }
    //============================================
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "MainMenuToSubMenu",sender: self)
    }
    //============================================
     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let index = menuTable.indexPathForSelectedRow{
            let dest = segue.destination as! SubMenuViewController
            dest.type = Products.getType(index.row)
        }
    }
    //============================================


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

 }

