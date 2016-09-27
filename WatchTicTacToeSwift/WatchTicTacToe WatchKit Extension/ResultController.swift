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

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        // Configure interface objects here.
        let dict = context as! Dictionary<String, Int>
        let result = GameResult(rawValue: dict["result"]!);
        if result == GameResult.win {
            labelResult!.setText("YOU WIN!")
        } else if result == GameResult.lose {
            labelResult!.setText("YOU LOSE!")
        } else {
            labelResult!.setText("THE END")
        }
    }


    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        let userDefaults = UserDefaults.standard;
        let win = userDefaults.integer(forKey: KEY_SELF_WIN_COUNT);
        let lose = userDefaults.integer(forKey: KEY_PC_WIN_COUNT);
        labelStat?.setText("💩 \(win)  :  \(lose) 🐷")
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func pressButtonRestart() {
        self.dismiss()
    }

    @IBAction func pressButtonReset() {
        let userDefaults = UserDefaults.standard;
        userDefaults.set(0, forKey: KEY_SELF_WIN_COUNT)
        userDefaults.set(0, forKey: KEY_PC_WIN_COUNT)
        userDefaults.synchronize()
        labelStat!.setText("💩 0  :  0 🐷")
    }

}
