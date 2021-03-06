import SwiftUI

class FriendsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    var messages: [Message]?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.title = "Recent"
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(MessageCell.self, forCellWithReuseIdentifier: cellId)
        
        setupData()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessageCell
        if let message = messages?[indexPath.item] {
            cell.message = message
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let chatLogController = ChatLogController(collectionViewLayout: layout)
        chatLogController.friend = messages?[indexPath.item].friend
        navigationController?.pushViewController(chatLogController, animated: true)
    }
    
}

class MessageCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor(displayP3Red: 0, green: 134/255, blue: 249/255, alpha: 1) : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            messageLabel.textColor = isHighlighted ? UIColor.white : UIColor.gray
            timeLabel.textColor = isHighlighted ? UIColor.white : UIColor.gray
        }
    }
    
    var message: Message? {
        didSet {
            nameLabel.text = message?.friend?.name
            if let imageProfile = message?.friend?.profileImageName {
                profileImageView.image = UIImage(named: imageProfile)
                hasReadImageView.image = UIImage(named: imageProfile)
            }
            messageLabel.text = message?.text
            if let dateMessage = message?.date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                
                let elapedTimeInSecond = NSDate().timeIntervalSince(dateMessage)
                let secondInDay: TimeInterval = 60 * 60 * 24
                if elapedTimeInSecond > 7 * secondInDay {
                    dateFormatter.dateFormat = "dd/MM/yy"
                    timeLabel.text = dateFormatter.string(from: dateMessage as Date)
                } else if elapedTimeInSecond > secondInDay {
                    dateFormatter.dateFormat = "EEE"
                    timeLabel.text = dateFormatter.string(from: dateMessage as Date)
                } else if elapedTimeInSecond / 60 > 60 {
                    timeLabel.text = "\(Int(elapedTimeInSecond / (60 * 60))) hour ago"
                } else if elapedTimeInSecond / 60 < 60 && elapedTimeInSecond / 60 > 1{
                    timeLabel.text = "\(Int(elapedTimeInSecond / 60)) min ago"
                } else {
                    timeLabel.text = "\(Int(elapedTimeInSecond)) sec ago"
                }
                
                
            }
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Friend Name"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Friend Message and somethings"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = "12.00 pm"
        timeLabel.font = UIFont.systemFont(ofSize: 13)
        timeLabel.textColor = UIColor.gray
        timeLabel.textAlignment = .right
        return timeLabel
    }()
    
    let hasReadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func setupView() {
        
        addSubview(profileImageView)
        addConstraintWithFormat(format: "H:|-12-[v0(68)]", views: profileImageView)
        addConstraintWithFormat(format: "V:[v0(68)]", views: profileImageView)
        addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addSubview(dividerLineView)
        addConstraintWithFormat(format: "H:|-82-[v0]|", views: dividerLineView)
        addConstraintWithFormat(format: "V:[v0(1)]|", views: dividerLineView)
        
        setupContainerView()
        
    }
    
    private func setupContainerView() {
        
        let containerView = UIView()
        addSubview(containerView)
        
        addConstraintWithFormat(format: "H:|-90-[v0]|", views: containerView)
        addConstraintWithFormat(format: "V:[v0(50)]", views: containerView)
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    
        containerView.addSubview(nameLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(hasReadImageView)
        
        containerView.addConstraintWithFormat(format: "H:|[v0]|", views: nameLabel)
        containerView.addConstraintWithFormat(format: "V:|[v0][v1(24)]|", views: nameLabel, messageLabel)
        containerView.addConstraintWithFormat(format: "H:|[v0]-8-[v1(100)]-8-[v2(24)]-12-|", views: messageLabel, timeLabel, hasReadImageView)
        containerView.addConstraintWithFormat(format: "V:[v0(24)]|", views: timeLabel)
        containerView.addConstraintWithFormat(format: "V:[v0(24)]|", views: hasReadImageView)
        
    }
    
}

extension UIView {
    
    func addConstraintWithFormat(format: String, views: UIView...) {
        
        var viewDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDictionary))
        
    }
    
}

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {}
    
}
