//
//  AddMovieVC.swift
//  MoviesTask
//
//  Created by mac on 2/27/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class AddMovieVC: UIViewController,UITextFieldDelegate {
    // MARK: OUTLET
    @IBOutlet weak var movieTitleTF: UITextField!
    @IBOutlet weak var movieOverallTF: UITextField!
    @IBOutlet weak var movieDateTF: UITextField!
    @IBOutlet var imageView: UIImageView!
    
    
    //MARK:Image picker
    private let imagePicker = UIImagePickerController()
    
    //date picker
    private let datePicker = UIDatePicker()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        movieTitleTF.delegate=self
        movieOverallTF.delegate=self
        showDatePicker()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
        func showDatePicker(){
            //Formate Date
            datePicker.datePickerMode = .date
            
            //ToolBar
            let toolbar = UIToolbar();
            toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
            
            toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
            
            movieDateTF.inputAccessoryView = toolbar
            movieDateTF.inputView = datePicker
            
        }
        
        @objc func donedatePicker(){
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-mm-dd"
            movieDateTF.text = formatter.string(from: datePicker.date)
            self.view.endEditing(true)
        }
        
        @objc func cancelDatePicker(){
            self.view.endEditing(true)
        }
    
    @IBAction func AddPhotoButton(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func SubmitButton(_ sender: Any) {
        
//        guard  let title=movieTitleTF.text,!title.isEmpty else {
//              print("title empty")
//            return
//        }
//        guard  let overall=movieOverallTF.text,!overall.isEmpty else {
//            print("overall empty")
//            return
//        }
//        guard  let date=movieDateTF.text,!date.isEmpty  else {
//            print("date empty")
//            return
//        }
        let title=movieTitleTF.text!
        let overall=movieOverallTF.text!
        let date=movieDateTF.text!
        
        
        
        
        
//        if validCount(string: title) && validCount(string: overall) && validCount(string: date) {
//            print("succ")
//        }else{
//            print("all fields requires")
//        }
        guard  imageView.image != nil else {
            print("image empty")
            return
        }

        
        
        if !title.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty && !overall.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty && !date.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty{
           print("spacing empty ")
            
            
            if validCount(string: title) && validCount(string: overall) && validCount(string: date){
                print("success")
                        let image=imageView.image
                        let imgData=image?.pngData()! as! NSData
                        // init core
                        let movie=Movie(context: persistentService.context)
                        movie.title=title
                        movie.overview=overall
                        movie.date=date
                        movie.photo=imgData
                
                        persistentService.saveContext()
                        dismiss(animated: true, completion: nil)
            }else{
                print("all fields require")
            }
            
        }else{
            print("not ")
        }
        
        
        
        
        
        
        

        
        
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func validCount(string:String) -> Bool {
        return string.count > 2
    }
  
    func validate(string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet.letters.inverted) == nil
    }
    
}
extension AddMovieVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
  
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
         dismiss(animated: true, completion: nil)
    }
    
    
    
}
