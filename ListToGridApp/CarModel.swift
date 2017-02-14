import UIKit


class CarModel {
    
    var image : String!
    var name : String!
    
    init(withJSON data : [String:Any])
    {
        image = data["Image"] as! String!
        name = data["Name"] as! String!
    }
}



