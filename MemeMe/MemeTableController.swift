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
    @IBOutlet weak var noMemesLabel: UILabel!
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let memeRow = memeTable.indexPathForSelectedRow?.row {
            let viewMeme = segue.destination as! ViewMemeController
            viewMeme.memeItem = memes[memeRow]
            memeTable.deselectRow(at: memeTable.indexPathForSelectedRow!, animated: false)
        }
    }
    
    //MARK: UITableView all Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.noMemesLabel.isHidden = (memes.count > 0) ? true : false
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! MemeItemListCell
        
        cell.memeImage.image = memes[indexPath.row].getMemedImage()
        cell.memeLabel.text = memes[indexPath.row].fullTitle()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("Delete \(indexPath.row)")
        if (editingStyle == .delete) {
            let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
            appDelegate.memes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
}
