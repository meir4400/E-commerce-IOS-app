
import UIKit

class SubMenuViewController: UICollectionViewController {

    //var products: [ProductsResponse] = []
    var type = ""
    //===========================================
    override func viewDidLoad() {
        super.viewDidLoad()

        //products = Products.getAllProductsType(type)
        title = "\(type)"
        
    }
    //===========================================

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
    //===========================================
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Products.getProductsNumByType(self.type)
    }
    //===========================================
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        var cell = UICollectionViewCell()
        
        if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CollectionCell{
            
            customCell.configure(type, indexPath.row)
            cell = customCell
        }
    
        return cell
    }


}

