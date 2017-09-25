//
//  MemeTableController.swift
//  MemeMe
//
//  Created by Justin Priday on 2017/09/25.
//  Copyright © 2017 Justin Priday. All rights reserved.
//

import UIKit

class MemeTableController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let reuseIdentifier = "MemeItemListCell"
    
    var memes: [MemeImage] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    @IBOutlet weak var memeTable: UITableView!
    
    //MARK: IBActions
    
    @IBAction func createExit(segue: UIStoryboardSegue) {
        //Create Meme Exit Segue Action for reloading list data
        memeTable.reloadData()
    }
    
    // MARK: UIViewController Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memeTable.reloadData()
    }
    
    //MARK: UITableView all Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! MemeItemListCell
        
        cell.memeImage.image = memes[indexPath.row].getMemedImage()
        cell.memeLabel.text = memes[indexPath.row].fullTitle()
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CreateMemeController") as! CreateMemeController
        controller.memeItem = memes[indexPath.row]
        self.present(controller, animated: true, completion: nil)
    }
    
}
