import SwiftUI

class FriendsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Recent"
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(FriendCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
}

class FriendCell: BaseCell {
    
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
        timeLabel.font = UIFont.systemFont(ofSize: 15)
        timeLabel.textColor = UIColor.gray
        timeLabel.textAlignment = .right
        return timeLabel
    }()
    
    override func setupView() {
        
        addSubview(profileImageView)
        profileImageView.image = UIImage(named: "aphirat_profile")
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
        
        containerView.addConstraintWithFormat(format: "H:|[v0][v1(80)]-12-|", views: nameLabel, timeLabel)
        containerView.addConstraintWithFormat(format: "V:|[v0][v1(24)]|", views: nameLabel, messageLabel)
        containerView.addConstraintWithFormat(format: "H:|[v0]-12-|", views: messageLabel)
        containerView.addConstraintWithFormat(format: "V:|[v0(20)]", views: timeLabel)
        
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
    
    func setupView() {
        backgroundColor = UIColor.blue
    }
    
}
