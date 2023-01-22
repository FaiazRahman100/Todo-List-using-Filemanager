//
//  ViewController.swift
//  faiaz_rahman_file_manager_30024
//
//  Created by bjit on 21/12/22.
//

import UIKit
var indexX: Int = 0

//var myNotes: [String] = []

var myNotes: [DataClass] = []

let folderURL : URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("rootDirectoryOffice")
    .appendingPathComponent("notesFolder")

let imageFolderURL : URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("rootDirectoryOffice")
    .appendingPathComponent("imageFolder")


class ViewController: UIViewController {
    
    @IBOutlet weak var contentViewer: UITextView!
    @IBOutlet weak var containerImage: UIImageView!
    @IBOutlet weak var tableViewX: UITableView!
    @IBOutlet weak var viewContainer: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewX.dataSource = self
        tableViewX.delegate = self
        contentViewer.layer.cornerRadius = 20
        containerImage.layer.cornerRadius = 20
        viewContainer.layer.cornerRadius = 20
        createFileFolder()
        
        readAllFilesFromDirectory()
    }
    
    func createFileFolder(){
        do {
            try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
            print(folderURL)
            try FileManager.default.createDirectory(at: imageFolderURL, withIntermediateDirectories: true)
            
            print(folderURL.path)
        } catch {
            print(error)
        }
    }
    
    // Read files from directory
    func readAllFilesFromDirectory() {
        var titleText: String?
        var desc: String?
        let filePath = folderURL
           
         if let files = try? FileManager.default.contentsOfDirectory(atPath: filePath.path) {
                myNotes = []
                // loop through the files

                for file in files {
                     titleText = removeFileExtension(str: file)
                     desc = readDescription(fileUrl: filePath, fileName: file)
                    myNotes.append(DataClass(noteTitle: titleText!, noteDescription: desc!))
                    print(myNotes)

                }
            }
    
        tableViewX.reloadData()
        
        }

    // remove file extensions
    func removeFileExtension(str: String) -> String {
            // get the file extension
            let fileExtension = str.components(separatedBy: ".").last
            // remove the file extension
            let fileName = str.replacingOccurrences(of: ".\(fileExtension!)", with: "")
            return fileName
        }
    
    
    // read text files
    func readDescription(fileUrl: URL, fileName: String)-> String  {
        var desc: String = ""
        
            let filePath = fileUrl.appendingPathComponent(fileName)
            // read the data from the file
            if let data = try? Data(contentsOf: filePath) {
                // convert the data to a string
                if let text = String(data: data, encoding: .utf8) {
                    
                    desc = text
                }
            }
        return desc
    }
    
    
    
}

extension ViewController:  UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewX.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customCell
        
        let cellText = myNotes[indexPath.row]
        
        cell.cellLabel.text = cellText.noteTitle

        cell.layer.cornerRadius = 20
        //cell.layoutMargins.bottoms = 10
    
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let imageOfSelectedFile = imageFolderURL.appendingPathComponent(myNotes[indexPath.row].noteTitle + ".png")
        
        do {
            let readData = try Data(contentsOf: imageOfSelectedFile)
            let readImage = UIImage(data: readData)
            containerImage.image = readImage
        }
        catch {
            print(error)
        }

        contentViewer.text = myNotes[indexPath.row].noteDescription
    }
    
}

extension ViewController: UITableViewDelegate{

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueWay"{
            if let destinationVC = segue.destination as? SecondVC{
                destinationVC.delegate = self
                
            }
        }
        
    }
}

