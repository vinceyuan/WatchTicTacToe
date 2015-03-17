//
//  ResultController.swift
//  WatchTicTacToeSwift
//
//  Created by Vince Yuan on 16/3/15.
//
//

import Foundation
import WatchKit

//import InterfaceController

class ResultController : WKInterfaceController {
    @IBOutlet weak var labelResult : WKInterfaceLabel!;
    @IBOutlet weak var labelStat : WKInterfaceLabel!;

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

        // Configure interface objects here.
        let dict = context as Dictionary<String, Int>
        let result = GameResult(rawValue: dict["result"]!);
        if result == GameResult.Win {
            labelResult!.setText("YOU WIN!")
        } else if result == GameResult.Lose {
            labelResult!.setText("YOU LOSE!")
        } else {
            labelResult!.setText("THE END")
        }
    }


    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        let userDefaults = NSUserDefaults.standardUserDefaults();
        let win = userDefaults.integerForKey(KEY_SELF_WIN_COUNT);
        let lose = userDefaults.integerForKey(KEY_PC_WIN_COUNT);
        labelStat?.setText("💩 \(win)  :  \(lose) 🐷")
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func pressButtonRestart() {
        self.dismissController()
    }

    @IBAction func pressButtonReset() {
        let userDefaults = NSUserDefaults.standardUserDefaults();
        userDefaults.setInteger(0, forKey: KEY_SELF_WIN_COUNT)
        userDefaults.setInteger(0, forKey: KEY_PC_WIN_COUNT)
        userDefaults.synchronize()
        labelStat!.setText("💩 0  :  0 🐷")
    }

}
