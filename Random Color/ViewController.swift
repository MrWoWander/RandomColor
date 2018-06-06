//
//  ViewController.swift
//  Random Color
//
//  Created by Михаил Иванов on 06/06/2018.
//  Copyright © 2018 Reality_Shift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var score : Int = 0
    @IBOutlet weak var ButtonColor1: UIButton!
    @IBOutlet weak var ButtonColor2: UIButton!
    @IBOutlet weak var ButtonColor3: UIButton!
    
    @IBOutlet weak var ScoreLabel: UILabel!
    
    @IBOutlet weak var ColorFild: UIButton!
   
    @IBOutlet weak var StartLable: UILabel!
    
    @IBAction func ButtonOne(_ sender: Any) {
        changeScore(button: ButtonColor1)
        ifScore()
    }
    
    @IBAction func ButtonTwo(_ sender: Any) {
        changeScore(button: ButtonColor2)
        ifScore()
    }
    
    @IBAction func ButtonThree(_ sender: Any) {
        changeScore(button: ButtonColor3)
        ifScore()
    }
    
    @IBAction func FirstButton(_ sender: Any) {
        activeButton(bool: false)
        ColorFild.setTitle("", for: .normal)
        score = 0
        ScoreLabel.text = "\(score)"
        changeColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ColorFild.backgroundColor = generateRandomColor()
        ButtonColor1.isEnabled = false
        ButtonColor2.isEnabled = false
        ButtonColor3.isEnabled = false
    }
    
    func changeColor() {
        ColorFild.backgroundColor = generateRandomColor()
        let randomButton = arc4random_uniform(3)
        switch randomButton {
        case 0:
            ButtonColor1.backgroundColor = ColorFild.backgroundColor
            ButtonColor2.backgroundColor = generateRandomColor()
            ButtonColor3.backgroundColor = generateRandomColor()
        case 1:
            ButtonColor2.backgroundColor = ColorFild.backgroundColor
            ButtonColor1.backgroundColor = generateRandomColor()
            ButtonColor3.backgroundColor = generateRandomColor()
        case 2:
            ButtonColor3.backgroundColor = ColorFild.backgroundColor
            ButtonColor1.backgroundColor = generateRandomColor()
            ButtonColor2.backgroundColor = generateRandomColor()
        default:
            ButtonColor2.backgroundColor = ColorFild.backgroundColor
            ButtonColor1.backgroundColor = generateRandomColor()
            ButtonColor3.backgroundColor = generateRandomColor()
        }
    }

    
    func generateRandomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }

    func ifScore () {
        if (score <= -15) {
            activeButton(bool: true)
            ColorFild.setTitle("YOU LOSE", for: .normal)
        } else if (score >= 15) {
                activeButton(bool: true)
                ColorFild.setTitle("YOU WIN", for: .normal)
        } else {
            changeColor()
        }
    }
    func activeButton (bool: Bool) {
        if (bool) {
        ColorFild.isEnabled = true
        StartLable.isHidden = false
        ButtonColor1.backgroundColor = UIColor.clear
        ButtonColor2.backgroundColor = UIColor.clear
        ButtonColor3.backgroundColor = UIColor.clear
        ButtonColor1.isEnabled = false
        ButtonColor2.isEnabled = false
        ButtonColor3.isEnabled = false
        } else {
            ColorFild.isEnabled = false
            StartLable.isHidden = true
            ButtonColor1.isEnabled = true
            ButtonColor2.isEnabled = true
            ButtonColor3.isEnabled = true
        }
    }
    
    func changeScore (button: UIButton!) {
        if (button.backgroundColor == ColorFild.backgroundColor) {
            score += 1
        } else {
            score -= 1
        }
        ScoreLabel.text = "\(score)"
    }
}

