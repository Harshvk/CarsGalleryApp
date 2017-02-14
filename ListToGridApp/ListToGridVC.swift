import UIKit

class ListToGridVC: UIViewController {

    //CollectionView Outlet
    @IBOutlet weak var carsCollection: UICollectionView!
    
    //ChangeViewButton Outlet
    @IBOutlet weak var changeViewBtnOutlet: UIButton!
    
    var cellSelectCell = false

    //Variable to check whether showing list or grid view
    var flowToDisplay = Flow.list
    
    let gridFlowLayout = ProductsGridFlowLayout()
    let listFlowLayout = ProductsListFlowLayout()

    //input data
    var carData : [[String:String]] = [
        
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
        carsCollection.register(nibList, forCellWithReuseIdentifier: "ListCellID")
        
        let nibGrid = UINib(nibName: "GridCell", bundle: nil)
        carsCollection.register(nibGrid, forCellWithReuseIdentifier: "GridCellID")

    
        //Setting Datasource and Delegates of Collection view
        carsCollection.dataSource = self
        carsCollection.delegate = self
        
        //Defining initial flowlayout
        carsCollection.collectionViewLayout = listFlowLayout
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(selecetCell))
        longPressGesture.delegate = self
        longPressGesture.minimumPressDuration = 0.5
        carsCollection.addGestureRecognizer(longPressGesture)
        carsCollection.allowsSelection = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    //MARK: IBActions
    @IBAction func changeViewBtn(_ sender: UIButton)
    {
        
        
        if changeViewBtnOutlet.isHighlighted
        {
            
            if changeViewBtnOutlet.isSelected
            {
                
                for (index,_) in carData.enumerated().reversed(){
                    
                    let indexPathh : IndexPath = [0 , index]
               let cell = carsCollection.cellForItem(at: indexPathh) as! GridCell
                if (cell.isSelected){
                    
                    carData.remove(at: index)
                    
                }
                
            }
            }else
            {
                
                for (index,_) in carData.enumerated().reversed(){
                    
                    let indexPathh : IndexPath = [0 , index]
                    let cell = carsCollection.cellForItem(at: indexPathh) as! ListCell
                    if (cell.isSelected){
                        
                        carData.remove(at: index)
                        
                    }
                
                }
            }
            self.carsCollection.reloadData()
            changeViewBtnOutlet.isHighlighted = false
        }
        else
        {
        
            self.carsCollection.reloadData()
            
            if changeViewBtnOutlet.isSelected == true
            {
        
                flowToDisplay = Flow.grid
                changeViewBtnOutlet.isSelected = false

                UIView.animate(withDuration: 0.5) { () -> Void in
                    self.carsCollection.collectionViewLayout.invalidateLayout()
                    self.carsCollection.setCollectionViewLayout(self.gridFlowLayout, animated: true)
                }
            
            }
            else
            {
                flowToDisplay = Flow.list
                changeViewBtnOutlet.isSelected = true

                UIView.animate(withDuration: 0.5) { () -> Void in
                    self.carsCollection.collectionViewLayout.invalidateLayout()
                    self.carsCollection.setCollectionViewLayout(self.listFlowLayout, animated: true)

                }
           

            }
            
        }

       
        
                
    }
    
    
 }

//MARK: CollectionViewDelegate ,DataSource and FlowLayoutDelegate
extension ListToGridVC : UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate{
    
    
    //Defining no of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return carData.count
        
    }
    
    //Defining Cell for each item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        //Converting JSON data to CarModel type
        let car = CarModel(withJSON: carData[indexPath.item])

        if flowToDisplay == Flow.grid
        {
            //Making and configuring object of cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCellID", for: indexPath) as! GridCell
            cell.configureCell(withCar: car)
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.black.cgColor
            print("grid made")
            
            return cell
        
        }
        else
        {
            //Making and configuring object of cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCellID", for: indexPath) as! ListCell
            cell.configureCell(withCar: car)
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.black.cgColor
            print("list made")

            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let cell = self.carsCollection.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.black
        print(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath){
        
        let cell = self.carsCollection.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.lightGray
    }
    
    func selecetCell(gesture : UILongPressGestureRecognizer!){
        if gesture.state == .ended {
            return
        }
        carsCollection.allowsMultipleSelection = true
        carsCollection.allowsSelection = true

        self.changeViewBtnOutlet.isHighlighted = true
        self.changeViewBtnOutlet.isSelected = false
        
        let p = gesture.location(in: self.carsCollection)

        if let indexPath = self.carsCollection.indexPathForItem(at: p) {
            // get the cell at indexPath (the one you long pressed)
            
            let cell : UICollectionViewCell!
            
            if flowToDisplay == Flow.grid{
                cell = self.carsCollection.cellForItem(at: indexPath) as! GridCell
            }else{
                cell = self.carsCollection.cellForItem(at: indexPath) as! ListCell
            }
          
            cell.isSelected = true

            // do stuff with the cell
        } else {
            print("couldn't find index path")
            carsCollection.allowsMultipleSelection = false
            carsCollection.allowsSelection = false
        }
    }

    
    }


// defining an enum for flow
enum Flow {
    
    case list,grid
    
}

