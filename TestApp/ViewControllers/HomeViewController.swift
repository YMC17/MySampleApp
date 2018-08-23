//
//  HomeViewController.swift
//  TestApp
//
//  Created by MOUNICA CHOWDARY  YELISETTI on 2018-08-23.
//  Copyright © 2018 MOUNICA CHOWDARY  YELISETTI. All rights reserved.
//


import UIKit

class HomeViewController: UIViewController,UITableViewDataSource {
    
    private struct Attributes {
        static let customCellIdentifier = "CustomTableViewCell"
        static let viewTitle = NSLocalizedString("Home", comment: "View Controller Title")
        static let urlToLoad = "http://api.duckduckgo.com/?q=apple&format=json&pretty=1"
        static let maxDataToDisplay = 20
    }
    
    private var resultsArray = [String]()
    private var urlsArray = [String]()
    @IBOutlet weak var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Attributes.viewTitle
        getJsonFromUrl()
        // Do any additional setup after loading the view.
    }
    
    // MARK: private Methods
    
    private func getJsonFromUrl() {
        //creating a NSURL
        guard let url = NSURL(string: Attributes.urlToLoad) as URL? else {
            return
        }
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                //getting the RelatedTopics tag array from json and converting it to NSArray
                if let dataArray = jsonObj?.value(forKey: "RelatedTopics") as? NSArray {
                    //looping through all the elements
                    for data in dataArray{
                        //converting the element to a dictionary
                        if let dataDict = data as? NSDictionary {
                            
                            //getting the Text from the dictionary
                            if let name = (dataDict.value(forKey: "Text") as? String) {
                                //adding the Text to the resultsArrayarray
                                self.resultsArray.append(name)
                                if let iconDict = dataDict.value(forKey: "Icon") as? NSDictionary {
                                    self.addDataToUrlsArray(iconDict: iconDict)
                                }
                            } else if let topics = dataDict.value(forKey: "Topics") as? NSArray {
                                for topic in topics {
                                    if let name = (topic as AnyObject).value(forKey: "Text") as? String {
                                        //adding the Text to the array
                                        self.resultsArray.append(name )
                                        if let iconDict = (topic as AnyObject).value(forKey: "Icon") as? NSDictionary {
                                            self.addDataToUrlsArray(iconDict: iconDict)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                OperationQueue.main.addOperation({
                    //calling another function after fetching the json
                    //it will show the names to label
                    self.resultsArray = Array(self.resultsArray.prefix(Attributes.maxDataToDisplay))
                    self.urlsArray = Array(self.urlsArray.prefix(Attributes.maxDataToDisplay))
                    self.homeTableView.reloadData()
                })
            }
        }).resume()
    }
    
    private func addDataToUrlsArray(iconDict:NSDictionary) {
        if let iconUrl = iconDict.value(forKey: "URL") as? String {
            self.urlsArray.append(iconUrl)
        }
    }
    
    // MARK: TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Attributes.customCellIdentifier, for: indexPath) as? CustomTableViewCell {
            cell.titleLabel.text = resultsArray[indexPath.row]
            if let image = URL(string: urlsArray[indexPath.row]) {
                cell.myImageView?.load(url: image)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
