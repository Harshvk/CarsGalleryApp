import UIKit

class ListToGridVC: UIViewController {

    //CollectionView Outlet
    @IBOutlet weak var CarsCollection: UICollectionView!
    
    //ChangeViewButton Outlet
    @IBOutlet weak var changeViewBtnOutlet: UIButton!
    

    //Variable to check whether showing list or grid view
    var flowToDisplay = flow.list
    
    
    //input data
    var CarData : [[String:String]] = [
        
        ["Name" : "Ford" ,          "Image" : "ford"],
        ["Name" : "Porsche" ,       "Image" : "porsche"],
        ["Name" : "Mustang" ,       "Image" : "mustang"],
        ["Name" : "Tata" ,          "Image" : "tata"],
        ["Name" : "Fiat" ,          "Image" : "fiat"],
        ["Name" : "Ferrari" ,       "Image" : "ferrari"],
        ["Name" : "Corvette" ,      "Image" : "corvette"],
        ["Name" : "Volvo" ,         "Image" : "volvo"],
        ["Name" : "DC" ,            "Image" : "dc"],
        ["Name" : "Infiniti" ,      "Image" : "infiniti"],
        ["Name" : "Toyota" ,        "Image" : "toyota"]
        
    ]

   //MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Adding Nib of cells to collection view
        let nibList = UINib(nibName: "ListCell", bundle: nil)
        CarsCollection.register(nibList, forCellWithReuseIdentifier: "ListCellID")
        
        let nibGrid = UINib(nibName: "GridCell", bundle: nil)
        CarsCollection.register(nibGrid, forCellWithReuseIdentifier: "GridCellID")

    
       //Setting Datasource and Delegates of Collection view
       CarsCollection.dataSource = self
       CarsCollection.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    //MARK: IBActions
    @IBAction func changeViewBtn(_ sender: UIButton)
    {
 
        if changeViewBtnOutlet.isSelected == true
        {
        
            flowToDisplay = flow.grid
            changeViewBtnOutlet.isSelected = false

        }
        else
        {
            flowToDisplay = flow.list
            changeViewBtnOutlet.isSelected = true
            
        }
        

        self.CarsCollection.reloadData()
        
    }
    
    
 }

//MARK: CollectionViewDelegate ,DataSource and FlowLayoutDelegate
extension ListToGridVC : UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    
    //Defining no of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return CarData.count
        
    }
    
    //Defining Cell for each item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        //Converting JSON data to CarModel type
        let car = CarModel(withJSON: CarData[indexPath.item])

        if flowToDisplay == flow.grid
        {
            //Making and configuring object of cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCellID", for: indexPath) as! GridCell
            cell.configureCell(withCar: car)
//            cell.layer.borderWidth = 1
//            cell.layer.borderColor = UIColor.black.cgColor
            print("cell made")
            
            return cell
        
        }
        else
        {
            //Making and configuring object of cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCellID", for: indexPath) as! ListCell
            cell.configureCell(withCar: car)
//            cell.layer.borderWidth = 1
//            cell.layer.borderColor = UIColor.black.cgColor
            print("cell made")

            return cell
        }
        
        
    }
    
    //Setting up size of items of collectionview
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        
        if flowToDisplay == flow.grid{
            
            return CGSize(width: 187, height: 120)
            
        }else{
            
            return CGSize(width: 375, height: 89)
            
        }
        
    }
    

    
    
    
}

//
enum flow {
    
    case list,grid
    
}

