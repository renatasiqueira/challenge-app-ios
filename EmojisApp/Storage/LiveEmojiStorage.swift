import Foundation

protocol EmojiStorage{
    var emojis: [Emoji] {
        get set
    }
}


/* class LiveEmojiStorage: EmojiStorage {
    var emojis: [Emoji] = []
    weak var delegate: EmojiStorageDelegate?
    let url = URL(string: "https://api.github.com/emojis")!
    
    init(){
        loadEmojis()
    }
    
    func loadEmojis() {
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if lrt data = data {
                let json = try?JSONSerialization.jsonObject(with: data) as? Dictionary<String,String>
 
            }
        }
*/
