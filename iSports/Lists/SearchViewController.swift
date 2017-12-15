//
//  searchViewController.swift
//  iSports
//
//  Created by Susu Liang on 2017/12/15.
//  Copyright © 2017年 Susu Liang. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var typeTF: UITextField!
    @IBOutlet weak var levelTF: UITextField!
    @IBOutlet weak var timeTF: UITextField!
    @IBOutlet weak var placeTF: UITextField!

    @IBAction func sureButton(_ sender: Any) {
        let listsController = ListsController()
        listsController.selectedPreference = Preference(id: "", type: Sportstype(rawValue: typeTF.text!)!, level: Level(rawValue: levelTF.text!)!, place: placeTF.text!, time: timeTF.text!)
        self.view.removeFromSuperview()

    }
    
    var level: [Level] = [.A, .B, .C, .D]
    var type: [Sportstype] = [  .basketball,
                                .volleyball,
                                .baseball,
                                .football,
                                .badminton,
                                .tennis,
                                .bowling]
    var place: [String] = ["信義區", "大安區", "松山區", "中正區", "中山區"]
    var time = ["星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"]
    
    var selectedType: String?
    var selectedLevel: String?
    var selectedPlace: String?
    var selectedTime: String?
    
    var typePicker = UIPickerView()
    var levelPicker = UIPickerView()
    var timePicker = UIPickerView()
    var placePicker = UIPickerView()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerDelegate()
//        UINib.load(nibName: "SearchView")
        
        
        typeTF.inputView = typePicker
        levelTF.inputView = levelPicker
        timeTF.inputView = timePicker
        placeTF.inputView = placePicker

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView {
        case typePicker: return type.count
        case levelPicker : return level.count
        case timePicker: return time.count
        case placePicker: return place.count
        default: return 1
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case typePicker: return type[row].rawValue
        case levelPicker : return level[row].rawValue
        case timePicker: return time[row]
        case placePicker: return place[row]
        default: return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case typePicker:
            typeTF.text = type[row].rawValue
            self.selectedType = type[row].rawValue
        case levelPicker :
            levelTF.text = level[row].rawValue
            self.selectedLevel = level[row].rawValue
        case timePicker:
            timeTF.text = time[row]
            self.selectedTime = time[row]
        case placePicker:
            placeTF.text = place[row]
            self.selectedPlace = place[row]
        default: break
        }
    }

}

extension SearchViewController {
    
    func pickerDelegate() {

        typePicker.delegate = self
        typePicker.dataSource = self
        levelPicker.delegate = self
        levelPicker.dataSource = self
        placePicker.delegate = self
        placePicker.dataSource = self
        timePicker.delegate = self
        timePicker.dataSource = self
        
    }
    
    
}

