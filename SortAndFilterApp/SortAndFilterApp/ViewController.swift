//
//  ViewController.swift
//  SortAndFilterApp
//
//  Created by ISHAN ARUN PANT on 23/5/20.
//  Copyright © 2020 ISHAN ARUN PANT. All rights reserved.
//
import UIKit

struct jsonstruct: Codable {
    var name:String
    var capital:String
    var number: Int
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet weak var tableview: UITableView!
    
    // contains original array
    var originalArrayList = [jsonstruct]()
    
    // contain names of country and this list is displayed after sorting is performed
    var alteredArrayList: [String] = []
    var serialNumberForCountryArrayList: [String] = []
    
    var switchSegmentOptionNumber: Int!
    var filter = false
    var sorting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        switchSegmentOptionNumber = 0
        getDataFromJson()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if filter {
            return alteredArrayList.count
         } else if sorting {
            return alteredArrayList.count
         } else {
            return self.originalArrayList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        
         if filter {
                cell.lblNumber.text = "Serial Number:"+(serialNumberForCountryArrayList[indexPath.row])
                cell.lblName.text =  "Name:"+(alteredArrayList[indexPath.row])
         } else if sorting {
                cell.lblNumber.text = "Serial Number:"+(serialNumberForCountryArrayList[indexPath.row])
                cell.lblName.text =  "Name:"+(alteredArrayList[indexPath.row])
         } else {
                cell.lblNumber.text = "Serial Number:"+(String(originalArrayList[indexPath.row].number))
                cell.lblName.text =  "Name:"+(originalArrayList[indexPath.row].name)
         }
            
        return cell
        
    }
    
    @IBAction func switchSegment(_ sender: UISegmentedControl) {
        
        switchSegmentOptionNumber = sender.selectedSegmentIndex
        if(switchSegmentOptionNumber == 1) {
           sorting = true
           filter = false
            
           alteredArrayList.sort(by: {$0 < $1})
            for i in 0..<alteredArrayList.count {
                for j in 0..<alteredArrayList.count {
                    if (alteredArrayList[i] == self.originalArrayList[j].name) {
                        serialNumberForCountryArrayList.append(String(self.originalArrayList[j].number))
                    }
                }
            }

            self.tableview.reloadData()
        }
        if (switchSegmentOptionNumber == 0) {
            sorting = false
            filter = false
            self.tableview.reloadData()
        }
        
        if (switchSegmentOptionNumber == 2) {
            alteredArrayList = self.alteredArrayList.filter({$0.count < 8})
            
            for a in 0..<alteredArrayList.count {
             for b in 0..<self.originalArrayList.count {
                if (alteredArrayList[a] == self.originalArrayList[b].name) {
                serialNumberForCountryArrayList.insert(String(self.originalArrayList[b].number), at: a)
                    }
                }
            }
            filter = true
            sorting = false;
            self.tableview.reloadData()
        }
    }
    
     func getDataFromJson() {
        
            guard let fileLocation = Bundle.main.url(forResource: "userdata", withExtension: "json") else {
                print("File Not Found")
                return
            }
            
            do{
                let docDirectory = try FileManager.default.url(for:.documentDirectory, in:.userDomainMask, appropriateFor:nil, create:true)
                let newLocation = docDirectory.appendingPathComponent("userdata.json")
                loadFile(mainPath: fileLocation, subPath: newLocation)
            } catch {
                print(error)
            }
        }
        
        func loadFile(mainPath: URL, subPath: URL) {
            if FileManager.default.fileExists(atPath: subPath.path){
                loadDataInTableView(pathName: subPath)
                
                if self.originalArrayList.isEmpty{
                    loadDataInTableView(pathName: mainPath)
                }
            }else{
                loadDataInTableView(pathName: mainPath)
            }
            self.tableview.reloadData()
        }
            
            
        func loadDataInTableView(pathName: URL) {
            do{
            let jsondata = try Data(contentsOf: pathName)
                self.originalArrayList = try JSONDecoder().decode([jsonstruct].self, from: jsondata)
                
                for mainarr in self.originalArrayList {
                    alteredArrayList.append(mainarr.name)
                }
                print(self.alteredArrayList)
        } catch {
                print(error)
        }
    }
}
