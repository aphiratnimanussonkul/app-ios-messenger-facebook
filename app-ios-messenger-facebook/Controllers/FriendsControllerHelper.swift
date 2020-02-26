import UIKit
import CoreData

extension FriendsController {
    
    func setupData() {
        
        clearData()
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            
            let sirirak = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            sirirak.name = "Nut Sirirak"
            sirirak.profileImageName = "sirirak_profile"
            
            createMessageWithText(text: "Wake up! I have some news to tell you! The politician who exposed funding of alleged secret military cyber operations against peace activists in the South says he's still waiting for a clear answer from the prime minister.", minuteAgo: 0.5, friend: sirirak, context: context)
            
            let aphirat = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            aphirat.name = "Aphirat Nimanussonkul"
            aphirat.profileImageName = "aphirat_profile"
            
            createMessageWithText(text: "Hello", minuteAgo: 60 * 2, friend: aphirat, context: context)
            
            let nattiya = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            nattiya.name = "Nattiya Nimanussonkul"
            nattiya.profileImageName = "nattiya_profile"
            
            createMessageWithText(text: "hey how r u today", minuteAgo: 24 * 60 * 9, friend: nattiya, context: context)
            
            let chanantapol = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            chanantapol.name = "Chanantapol Nimanussonkul"
            chanantapol.profileImageName = "chanantapol_profile"
            
            createMessageWithText(text: "I'm on my way", minuteAgo: 24 * 60, friend: chanantapol, context: context)
            
            let nattamon = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            nattamon.name = "Nattamon KlongDee"
            nattamon.profileImageName = "nattamon_profile"
            
            createMessageWithText(text: "How r u?", minuteAgo: 3, friend: nattamon, context: context)
            createMessageWithText(text: "Good morning son", minuteAgo: 2, friend: nattamon, context: context)
            
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
            
            if let friends = fetchFriend() {
                
                messages = [Message]()
                
                for friend in friends {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
                    
                    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                    fetchRequest.fetchLimit = 1
                    fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
                    
                    do {
                        let fetchMessages = try context.fetch(fetchRequest) as? [Message]
                        messages?.append(contentsOf: fetchMessages!)
                    } catch {
                        print(error)
                    }
                }
                
                messages = messages?.sorted{$0.date!.compare($1.date!) == .orderedDescending}
            }
        }
    }
    
    func fetchFriend() -> [Friend]? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            let fetchFriendRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
            do {
                return try context.fetch(fetchFriendRequest) as? [Friend]
            } catch {
                print(error)
            }
        }
        return nil
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
