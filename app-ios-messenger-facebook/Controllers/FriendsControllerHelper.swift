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
            
            createMessageWithText(text: "Hello", minuteAgo: 1, friend: aphirat, context: context)
            
            let nattiya = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            nattiya.name = "Nattiya Nimanussonkul"
            nattiya.profileImageName = "nattiya_profile"
            
            createMessageWithText(text: "hey how r u today", minuteAgo: 1, friend: nattiya, context: context)
            
            let chanantapol = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            chanantapol.name = "Chanantapol Nimanussonkul"
            chanantapol.profileImageName = "chanantapol_profile"
            
            createMessageWithText(text: "I'm on my way", minuteAgo: 2, friend: chanantapol, context: context)
            
            let nattamon = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            nattamon.name = "Nattamon KlongDee"
            nattamon.profileImageName = "nattamon_profile"
            
            createMessageWithText(text: "Good morning son", minuteAgo: 2, friend: nattamon, context: context)
            createMessageWithText(text: "How r u?", minuteAgo: 3, friend: nattamon, context: context)
            
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
        loadData()
    }
    
    private func createMessageWithText(text: String, minuteAgo: Double, friend: Friend, context: NSManagedObjectContext) {
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.text = text
        message.date = NSDate().addingTimeInterval(-minuteAgo * 60) as Date
        message.friend = friend
        
        do {
            try context.save()
        } catch {
            print(error)
        }
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
                let entities = ["Friend", "Message"]
                for entity in entities {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
                    let objects = try context.fetch(fetchRequest) as? [NSManagedObject]
            
                    for object in objects! {
                        context.delete(object)
                    }
                }
                
                try context.save()
            } catch {
                print(error)
            }
            
        }
        
    }
    
}
