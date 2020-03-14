//
//  ViewController.swift
//  pickerDemo
//
//  Created by Hasan Ali on 14.03.2020.
//  Copyright © 2020 Hasan Ali Şişeci. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    // Veri olarak kaydettiğimiz görüntüye çevireceğimiz değişkenimize
    //başlangıç değeri olarak "firstImage"i atıyoruz.
    var storedImage : UIImage = (UIImage(named: "firstImage") ?? nil)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Datamızın boş olup olmadığını kontrol edip öyle UIImage'a çeviriyoruz.
        if  UserDefaults.standard.object(forKey: "imageData") != nil {
            //Kaydettiğimiz datayı bir değişkene aktarıyoruz ve
            //kesin olarak Data olduğunu belirtmek için cast ediyoruz
            let storedData = UserDefaults.standard.object(forKey: "imageData") as! Data
            //Aldığımız datayı UIImage'a çevirip değişkenimize aktarıyoruz.
            storedImage = UIImage(data: storedData)!

        }
        
        //Değişkenimizdeki görseli imageView'da gösteriyoruz.
        //Data dolu geldiyse seçilen görsel, boş ise default olarak ayarladığımız görsel gelecek.
        imageView.image = storedImage

        //imageView'ı tıklanılabilir hale getiriyoruz.
        imageView.isUserInteractionEnabled = true
        //Bir Gesture Recognizer oluşturup, görsel seçme fonksiyonunu içine koyuyoruz.
        let gesRec = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        //Gesture Recognizer'ı imageView'a ekliyoruz.
        imageView.addGestureRecognizer(gesRec)
    }

    @IBAction func saveButton(_ sender: Any) {
        
        //ImageView'da bulunan görseli veri haline getirip data değişkenine aktarıyoruz.
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        
        //Data adlı değişkenimizi bir anahtar kelime ile uygulama hafızasına kaydediyoruz.
        UserDefaults.standard.set(data,forKey: "imageData")
    
    }
    
    @objc func selectImage() {
        //Bir picker oluşturuyoruz.
        let picker = UIImagePickerController()
        
        //Picker fonksiyonlarını kullabilmemizi sağlayan komut.
        picker.delegate = self
        
        //Picker'ın fotoğrafı nereden seçiçeğini belirliyoruz.
        picker.sourceType = .photoLibrary
        
        //Seçilen fotoğrafın editlenebilir mi olduğunu belirliyoruz.
        picker.allowsEditing = true
        
        //Picker'ı göstermek için ise present komutunu kullanıyoruz.
        present(picker, animated: true, completion:  nil)
        
        
    }
    
    
    //Bu fonksiyon ise görsel seçildikten sonra ne olacağını belirlediğimiz fonksiyon.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            //Seçtiğimiz görseli imageView görünümüne gönderiyoruz.
           imageView.image = info[.editedImage] as? UIImage
            
           //Gelen galeri görünümünün kapanmasını sağlar.
           //Bu satırı yazmazsak açılan pop-up'ı manuel olarak kapatmamız gerekir.
           self.dismiss(animated: true, completion: nil)
        
       }
}

