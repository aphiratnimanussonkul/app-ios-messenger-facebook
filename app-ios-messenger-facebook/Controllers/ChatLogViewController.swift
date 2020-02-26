
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
        cell.profileImage.image = UIImage(named: (messages?[indexPath.item].friend!.profileImageName)!)
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
        textView.layer.cornerRadius = 10
        textView.backgroundColor = UIColor(displayP3Red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return textView
    }()
    
    let profileImage: UIImageView = {
       let profileImg = UIImageView()
        profileImg.contentMode = .scaleAspectFill
        profileImg.layer.cornerRadius = 16
        profileImg.layer.masksToBounds = true
        return profileImg
    }()
    
    
    override func setupView() {
        super.setupView()
        
        addSubview(messageTextView)
        addSubview(profileImage)
        addConstraintWithFormat(format: "H:|-10-[v0(32)]-10-[v1]-50-|", views: profileImage, messageTextView)
        addConstraintWithFormat(format: "V:|-20-[v0]|", views: messageTextView)
    
        addConstraintWithFormat(format: "V:[v0(32)]|", views: profileImage)
    }
}
