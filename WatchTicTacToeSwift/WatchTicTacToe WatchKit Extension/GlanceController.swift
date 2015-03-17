//
//  GlanceController.swift
//  WatchTicTacToeSwift
//
//  Created by Vince Yuan on 16/3/15.
//
//

import WatchKit
import Foundation

//import InterfaceController

class GlanceController: WKInterfaceController {
    @IBOutlet weak var labelStat: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        let userDefaults = NSUserDefaults.standardUserDefaults();
        let win = userDefaults.integerForKey(KEY_SELF_WIN_COUNT);
        let lose = userDefaults.integerForKey(KEY_PC_WIN_COUNT);
        labelStat!.setText("💩 \(win)  :  \(lose) 🐷")
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
