
import UIKit

class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellId = "CellId"
    
    var friend: Friend? {
        didSet {
            navigationItem.title = friend?.name
            messages = friend?.message?.allObjects as? [Message]
            messages = messages?.sorted{ $0.date?.compare($1.date!) == .orderedAscending }
        }
    }
    
    var messages: [Message]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.white
        collectionView.register(ChatLogMessageCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatLogMessageCell
        cell.messageTextView.text = messages?[indexPath.item].text
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    
}

class ChatLogMessageCell: BaseCell {
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.text = "test message"
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
    }()
    
    override func setupView() {
        super.setupView()
        
        addSubview(messageTextView)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: messageTextView)
        addConstraintWithFormat(format: "V:|[v0]|", views: messageTextView)
    }
}
