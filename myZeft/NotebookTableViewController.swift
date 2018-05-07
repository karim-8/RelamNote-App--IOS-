

import UIKit

class NotebookTableViewController: UITableViewController {

    var notebookArray = [Notebook]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        loadData()
        
    }
    
    func loadData() {
        if let notebooks = NotesManager.shared.getNotebooks() {
            notebookArray = notebooks
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    

    @IBAction func addNotebook(_ sender: Any) {
        let addAlert = UIAlertController(title: "Add Notebook", message: "Enter the title of your new notebook", preferredStyle: .alert)
        
        addAlert.addTextField { (textield:UITextField) in
            textield.placeholder = "Notebook title"
        }
        addAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        addAlert.addAction(UIAlertAction(title: "Create", style: .default, handler: { (action) in
            
            if let title = addAlert.textFields?.first?.text {
                NotesManager.shared.addNotebook(title)
                self.loadData()
            }
        }))
        
        self.present(addAlert, animated: true, completion: nil)
        
    }
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notebookArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let notebook = notebookArray[indexPath.row]
        
        cell.textLabel?.text = notebook.title

        return cell
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let selectedNotebookIndexPath = self.tableView.indexPathForSelectedRow {
            
            let selectedNotebook = notebookArray[selectedNotebookIndexPath.row]
            let noteTableVC = segue.destination as! NoteTableViewController
            noteTableVC.notebookObject = selectedNotebook
        }
        
    }

}
