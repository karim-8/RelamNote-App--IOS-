import UIKit
import RealmSwift

class NotesManager: NSObject {
    
    static let shared = NotesManager()
    
    private override init() {
        super.init()
        
    }
    
    func addNotebook (_ title:String) {
        let realm = try! Realm()
        
        let notebook = Notebook()
        notebook.title = title
        notebook.creationDate = Date()
        
        do {
            try realm.write {
                realm.add(notebook)
            }
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    func getNotebooks() -> [Notebook]?{
        let realm = try! Realm()
        let notebooks = realm.objects(Notebook.self)
        
        return notebooks.map({$0})
    }
    
    func addNote (_ notebook:Notebook, content contentString:String) {
        let realm = try! Realm()
        
        let note = Note()
        note.creationDate = Date()
        note.content = contentString
        
        do {
            try realm.write {
                notebook.notes.append(note)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func updateNote (_ note:Note, newContent content:String) {
        let realm = try! Realm()
        
        do {
            try realm.write {
                note.content = content
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func getNotes (_ notebook:Notebook) -> [Note]? {
        let notes = notebook.notes
        return notes.map({$0})
    }
    
    
    func deleteNote (_ note:Note) {
        let realm = try! Realm()
        
        do {
            try realm.write {
                realm.delete(note)
            }
        }catch{
            print(error.localizedDescription)
        }
    }

}
