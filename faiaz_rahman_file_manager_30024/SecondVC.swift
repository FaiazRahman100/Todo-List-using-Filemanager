//
//  SecondVC.swift
//  faiaz_rahman_file_manager_30024
//
//  Created by bjit on 21/12/22.
//

import UIKit





class SecondVC: UIViewController{
    
    
    var delegate : ViewController?

    @IBOutlet weak var textFieldX: UITextField!
    
  //  @IBOutlet weak var favCharecterField: UITextField!
    

    @IBOutlet weak var stickyFrame: UIImageView!
    
    @IBOutlet weak var stickyFrameImage: UIImageView!
    
    var noteImage = UIImage(named: "programmer")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    
    func datePicker() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh-mm-ss, MMM d, YY"
        let currentDate = dateFormatter.string(from: date)
        
        return currentDate
    }
    
    
    @IBAction func imageAttach(_ sender: Any) {
        showImagePicker()
    }
    
    func showImagePicker() {
        let pickerController = UIImagePickerController()
        
        pickerController.delegate = self
        
        present(pickerController, animated: true)
    }
    
    @IBAction func appendTextField(_ sender: Any) {

        let currentDate = datePicker()
        
        let fileName = "File " + "\(currentDate)" + ".txt"
        let fileURL = folderURL.appendingPathComponent(fileName)
        print(fileURL)

        let note = textFieldX.text ?? ""
        let data = note.data(using: .utf8)
        
        FileManager.default.createFile(atPath: fileURL.path , contents: data)
        
        let imageLocation = imageFolderURL.appendingPathComponent("File " + "\(currentDate)" + ".png")
        
       // let favHero = favCharecterField.text ?? ""
        
        let imageData = noteImage?.pngData()
        
        do {
            try imageData!.write(to: imageLocation)
            } catch let error {
                print("error saving file with error", error)
            }
        
//        if favHero == "hinata"{
//
//
//            let imageData = UIImage(named: "F")?.pngData()
//
//            do {
//                try imageData!.write(to: imageLocation)
//                } catch let error {
//                    print("error saving file with error", error)
//                }
//
//        }else{
//
//            let imageData = UIImage(named: "B")?.pngData()
//
//            do {
//                try imageData!.write(to: imageLocation)
//                } catch let error {
//                    print("error saving file with error", error)
//                }
//        }

        delegate?.readAllFilesFromDirectory()
        self.dismiss(animated: true)

    
    }
    
    
    
        
    }
    
extension SecondVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        
        //let imageLocation = imageFolderURL.appendingPathComponent("File " + "\(currentDate)" + ".png")
        
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
           // imagesX.append(originalImage)
           // collectionViewX.reloadData()
            
            noteImage = originalImage
            
            //let originalImageData = originalImage.pngData()
           
            stickyFrame.image = UIImage(named: "noticeBoard")
            stickyFrameImage.image = originalImage
            
            
            //let imageData = UIImage(named: "F")?.pngData()
            
//            do {
//                try originalImageData!.write(to: imageLocation)
//                } catch let error {
//                    print("error saving file with error", error)
//                }
            
        }
        
        picker.dismiss(animated: true)
    }
    
}

