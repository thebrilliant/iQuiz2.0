//
//  ViewController.swift
//  iQuiz
//
//  Created by Vivyan Woods on 10/29/15.
//  Copyright © 2015 Vivyan Woods. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var subjectTable: UITableView!
    private let subjects = ["Mathematics", "Marvel Super Heroes", "Science"]
    private let subjectsDescr = ["Math questions here!", "All the MSH trivia here!", "Science is so much fun!"]
    let tableID = "QuizTopics"
    private var sub : SubjectViewController!
    private var ans : AnswerViewController!
    var qNum = 0
    var subjectClicked = ""
    
    @IBAction func settingsPressed(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings go here", message: "OK", preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Okay", style: .Default, handler: nil)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(tableID) as UITableViewCell!
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: tableID)
        }
        cell.imageView?.image = UIImage(named: "200px-ALBW_Triforce")
        cell.textLabel?.text = subjects[indexPath.row]
        cell.detailTextLabel?.text = subjectsDescr[indexPath.row]
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Start" {
            if let destination = segue.destinationViewController as? SubjectViewController {
                destination.subject = subjectClicked
                destination.questionNum = 0
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        subjectClicked = subjects[indexPath.row]
        performSegueWithIdentifier("Start", sender: self)
    }
    
    private func switchViewController(from: UIViewController?, to: UIViewController?) {
        if from != nil {
            from!.willMoveToParentViewController(nil)
            from!.view.removeFromSuperview()
            from!.removeFromParentViewController()
        }
        
        if to != nil {
            self.addChildViewController(to!)
            self.view.insertSubview(to!.view, atIndex: 0)
            to!.didMoveToParentViewController(self)
        }
        subjectTable.hidden = true
    }
}

