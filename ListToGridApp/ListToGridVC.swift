import UIKit

class ListToGridVC: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var carsCollection: UICollectionView!
    
    @IBOutlet weak var changeViewBtnOutlet: UIButton!

    @IBOutlet weak var deleteBtnOutlet: UIButton!
    
    //array of indexPaths of selected Items
    var selectedCellsIndexPath = [IndexPath]()
    
    //Variable to check whether showing list or grid view
    var flowToDisplay = Flow.list
    
    //Objects of flow layouts
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
        
        //Setting up Gesture recogniser
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(selecetCell))
        longPressGesture.delegate = self
        longPressGesture.minimumPressDuration = 0.5
        carsCollection.addGestureRecognizer(longPressGesture)
      
        deleteToChangeView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    //MARK: IBActions
    @IBAction func changeViewBtn(_ sender: UIButton)
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
    
    @IBAction func deleteBtnAction(_ sender: UIButton) {
        
        for index in selectedCellsIndexPath.sorted().reversed(){
            
            carData.remove(at: index.row)
            carsCollection.deleteItems(at: [index])
            
        }
        
        deleteToChangeView()
        selectedCellsIndexPath.removeAll()

        
    }
    
    //MARK: Private Functions
    
    //Hide delete Button and show changeView Button
    func deleteToChangeView(){
        
        self.changeViewBtnOutlet.isHidden = false
        self.changeViewBtnOutlet.isEnabled = true
        
        self.deleteBtnOutlet.isHidden = true
        self.deleteBtnOutlet.isEnabled = false
        
        carsCollection.allowsSelection = false
        
        
    }
    //Hideshow changeView  and delete Button Button
    func changeViewToDelete(){
        
        carsCollection.allowsMultipleSelection = true
        
        self.changeViewBtnOutlet.isHidden = true
        self.changeViewBtnOutlet.isEnabled = false
        
        self.deleteBtnOutlet.isHidden = false
        self.deleteBtnOutlet.isEnabled = true

    
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
        if !(selectedCellsIndexPath.contains(indexPath)){
        selectedCellsIndexPath.append(indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath){
        
        let cell = self.carsCollection.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.lightGray
        selectedCellsIndexPath.remove(at: selectedCellsIndexPath.index(of: indexPath)!)
        
        if selectedCellsIndexPath.isEmpty{
            
           deleteToChangeView()
            
        }
        
    }
    
    func selecetCell(gesture : UILongPressGestureRecognizer!){
        
        if gesture.state == .ended {
            return
        }

        changeViewToDelete()
        
        let p = gesture.location(in: self.carsCollection)

        if let indexPath = self.carsCollection.indexPathForItem(at: p) {

        carsCollection.selectItem(at: indexPath, animated: true, scrollPosition: .top)
        collectionView(carsCollection, didSelectItemAt: indexPath)

            
        } else {
            print("couldn't find index path") 
        }
    }

   
        
    }
    
    



// defining an enum for flow
enum Flow {
    
    case list,grid
    
}

