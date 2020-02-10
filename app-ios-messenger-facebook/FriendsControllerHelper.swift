import UIKit

class Friend: NSObject {
    
    var name: String?
    var profileImageName: String?
    
}

class Message: NSObject {
    
    var text: String?
    var date: NSDate?
    var friend: Friend?
    
}

extension FriendsController {
    
    func setupData() {
        
        let aphirat = Friend()
        aphirat.name = "Aphirat Nimanussonkul"
        aphirat.profileImageName = "aphirat_profile"
        
        let messageAphirat = Message()
        messageAphirat.text = "Hello IOS"
        messageAphirat.date = NSDate()
        messageAphirat.friend = aphirat
        
        let nattiya = Friend()
        nattiya.name = "Nattiya Nimanussonkul"
        nattiya.profileImageName = "nattiya_profile"
        
        let messageNattiya = Message()
        messageNattiya.text = "hey how r u today"
        messageNattiya.date = NSDate()
        messageNattiya.friend = nattiya
        
        let chanantapol = Friend()
        chanantapol.name = "Chanantapol Nimanussonkul"
        chanantapol.profileImageName = "chanantapol_profile"
        
        let messageChanantapol = Message()
        messageChanantapol.text = "Im on my way"
        messageChanantapol.date = NSDate()
        messageChanantapol.friend = chanantapol
        
        let nattamon = Friend()
        nattamon.name = "Nattamon KlongDee"
        nattamon.profileImageName = "nattamon_profile"
        
        let messageNattamon = Message()
        messageNattamon.text = "good morning son"
        messageNattamon.date = NSDate()
        messageNattamon.friend = nattamon
        
        messages = [messageAphirat, messageNattiya, messageChanantapol, messageNattamon]
    
    }
}
