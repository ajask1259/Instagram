//
//  CommentViewController.swift
//  instagram
//
//  Created by 荒井竣哉 on 2021/04/29.
//

import UIKit
import Firebase
import FirebaseUI

class CommentViewController: UIViewController {
    
    var postArray: [PostData] = []
    var postData : PostData!
    
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //背景タップ時dismissKeyboradを呼ぶ設定
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
        
        // キャプションの表示
        self.captionLabel.text = "\(postData.name!): \(postData.caption!) "
    }
    
    
    @IBAction func commentButton(_ sender: Any) {
        
        let comment = commentTextField.text!
        
        let displayname = Auth.auth().currentUser!.displayName!
        
        let commentData = displayname + ":" + comment
        // commentを更新する
        if  !comment.isEmpty{
            // 更新データを作成する
            var updateValue: FieldValue

            // 今回新たにコメントした場合は、commentを追加する更新データを作成
            updateValue = FieldValue.arrayUnion([commentData])

            // likesに更新データを書き込む
            let postRef =   Firestore.firestore().collection(Const.PostPath)    .document(postData.id)
            postRef.updateData(["comment": updateValue])
        }
        
        
        
        //最後に戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @objc func dismissKeyboard(){
        //キーボード閉じる
        view.endEditing(true)
    }
}
