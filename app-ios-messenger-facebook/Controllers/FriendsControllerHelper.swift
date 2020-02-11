import UIKit
import CoreData

extension FriendsController {
    
    func setupData() {
        
        clearData()
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            
            let aphirat = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            aphirat.name = "Aphirat Nimanussonkul"
            aphirat.profileImageName = "aphirat_profile"
            
            let messageAphirat = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            messageAphirat.text = "Hello IOS"
            messageAphirat.date = NSDate() as Date
            messageAphirat.friend = aphirat
            
            let nattiya = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            nattiya.name = "Nattiya Nimanussonkul"
            nattiya.profileImageName = "nattiya_profile"
            
            let messageNattiya = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            messageNattiya.text = "hey how r u today"
            messageNattiya.date = NSDate() as Date
            messageNattiya.friend = nattiya
            
            let chanantapol = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            chanantapol.name = "Chanantapol Nimanussonkul"
            chanantapol.profileImageName = "chanantapol_profile"
            
            let messageChanantapol = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            messageChanantapol.text = "Im on my way"
            messageChanantapol.date = NSDate() as Date
            messageChanantapol.friend = chanantapol
            
            let nattamon = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            nattamon.name = "Nattamon KlongDee"
            nattamon.profileImageName = "nattamon_profile"
            
            let messageNattamon = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            messageNattamon.text = "good morning son"
            messageNattamon.date = NSDate() as Date
            messageNattamon.friend = nattamon
            
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
        loadData()
    }
    
    func loadData(){
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
            
            do {
                messages = try context.fetch(fetchRequest) as? [Message]
            } catch {
                print(error)
            }
        }
    }
    
    func clearData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
                messages = try context.fetch(fetchRequest) as? [Message]
                
                for message in messages! {
                    context.delete(message)
                }
                
                try context.save()

            } catch {
                print(error)
            }
        }
    }
    
}
