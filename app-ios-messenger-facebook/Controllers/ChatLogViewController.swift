
import UIKit

class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var friend: Friend? {
        didSet {
            navigationItem.title = friend?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
