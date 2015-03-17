//
//  InterfaceController.swift
//  WatchTicTacToeSwift
//
//  Created by Vince Yuan on 16/3/15.
//
//

import WatchKit
import Foundation

let KEY_SELF_WIN_COUNT = "Self win count"
let KEY_PC_WIN_COUNT = "PC win count"

enum GameResult : Int {
    case NotEnd, Win, Lose, End
}

class InterfaceController: WKInterfaceController {
    var _buttons : Array<WKInterfaceButton!> = []
    var _matrix : Array<Int> = [Int](count: 9, repeatedValue: 0)
    var _shouldPcMove : Bool = false

    @IBOutlet weak var _button0 : WKInterfaceButton!
    @IBOutlet weak var _button1 : WKInterfaceButton!
    @IBOutlet weak var _button2 : WKInterfaceButton!
    @IBOutlet weak var _button3 : WKInterfaceButton!
    @IBOutlet weak var _button4 : WKInterfaceButton!
    @IBOutlet weak var _button5 : WKInterfaceButton!
    @IBOutlet weak var _button6 : WKInterfaceButton!
    @IBOutlet weak var _button7 : WKInterfaceButton!
    @IBOutlet weak var _button8 : WKInterfaceButton!

    override init() {
        super.init()
    }

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

        // Configure interface objects here.

        _buttons = [_button0, _button1, _button2, _button3, _button4, _button5, _button6, _button7, _button8]
    }

    func restartGame() {
        for i in 0 ..< 9 {
            _matrix[i] = 0
        }
        for button in _buttons {
            button!.setTitle("")
        }
        _shouldPcMove = (arc4random_uniform(2) != 0)
        if _shouldPcMove {
            NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("pcMove"), userInfo: nil, repeats: false)
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        self.restartGame()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func pressButton0() {
        self.pressButton(_button0)
    }
    @IBAction func pressButton1() {
        self.pressButton(_button1)
    }
    @IBAction func pressButton2() {
        self.pressButton(_button2)
    }
    @IBAction func pressButton3() {
        self.pressButton(_button3)
    }
    @IBAction func pressButton4() {
        self.pressButton(_button4)
    }
    @IBAction func pressButton5() {
        self.pressButton(_button5)
    }
    @IBAction func pressButton6() {
        self.pressButton(_button6)
    }
    @IBAction func pressButton7() {
        self.pressButton(_button7)
    }
    @IBAction func pressButton8() {
        self.pressButton(_button8)
    }

    func pcMove() {
        var index = 0
        // Try to win
        index = self.nextIndexToWin()
        // Try to block
        if index < 0 {
            index = self.nextIndexToBlock()
        }
        // Random location
        if index < 0 {
            do {
                index = Int(arc4random_uniform(9))
            } while _matrix[index] != 0
        }

        _matrix[index] = 2
        if let button = _buttons[index] {
            button.setTitle("🐷")
        }

        _shouldPcMove = !_shouldPcMove
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("checkGameResult"), userInfo: nil, repeats: false)
    }

    func pressButton(button : WKInterfaceButton?) {
        //let index = find(_buttons, button)
        var index = 0
        for (i, value) in enumerate(_buttons) {
            if value!.isEqual(button!) {
                index = i
                break
            }
        }
        if _matrix[index] != 0 {
            return
        }

        _matrix[index] = 1
        button!.setTitle("💩")
        _shouldPcMove = !_shouldPcMove
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("checkGameResult"), userInfo: nil, repeats: false)
    }

    func checkGameResult() {
        let result: GameResult = self.calculateGameResult()
        if result == GameResult.NotEnd {
            if _shouldPcMove {
                self.pcMove()
            }
            return
        } else if result == GameResult.Win {
            // win
            let userDefaults = NSUserDefaults.standardUserDefaults()
            var count = userDefaults.integerForKey(KEY_SELF_WIN_COUNT)
            count++
            userDefaults.setInteger(count, forKey: KEY_SELF_WIN_COUNT)
            userDefaults.synchronize()
        } else if result == GameResult.Lose {
            // lose
            let userDefaults = NSUserDefaults.standardUserDefaults()
            var count = userDefaults.integerForKey(KEY_PC_WIN_COUNT)
            count++
            userDefaults.setInteger(count, forKey: KEY_PC_WIN_COUNT)
            userDefaults.synchronize()
        } else {
            // end
        }

        let dict = ["result": result.rawValue]
        self.presentControllerWithName("resultController", context: dict)
    }

    func calculateGameResult() -> GameResult {
        if self.has3InLineInMatrix(1, matrix: _matrix) {
            return GameResult.Win
        }

        if self.has3InLineInMatrix(2, matrix: _matrix) {
            return GameResult.Lose
        }

        var total = 0
        for i in 0 ..< 9 {
            if _matrix[i] != 0 {
                total++
            }
        }
        if total == 9 {
            return GameResult.End
        }
        return GameResult.NotEnd
    }

    func has3InLineInMatrix(value: Int, matrix: [Int]) -> Bool {
        var condition =
            (matrix[0] == value && matrix[1] == value && matrix[2] == value)
                || (matrix[3] == value && matrix[4] == value && matrix[5] == value)
        condition =
            condition
                || (matrix[6] == value && matrix[7] == value && matrix[8] == value)
                || (matrix[0] == value && matrix[3] == value && matrix[6] == value)
        condition =
            condition
            || (matrix[1] == value && matrix[4] == value && matrix[7] == value)
            || (matrix[2] == value && matrix[5] == value && matrix[8] == value)
        condition =
            condition
            || (matrix[0] == value && matrix[4] == value && matrix[8] == value)
            || (matrix[2] == value && matrix[4] == value && matrix[6] == value)
        if condition {
                return true
        }
        return false
    }

    func nextIndexToWin() -> Int {
        return nextIndexToHave3InLine(2)
    }

    func nextIndexToBlock() -> Int {
        return nextIndexToHave3InLine(1)
    }

    func nextIndexToHave3InLine(value : Int) -> Int {
        var matrix = [Int](count: 9, repeatedValue: 0)
        for i in 0 ..< 9 {
            for i in 0 ..< 9 {
                matrix[i] = _matrix[i]
            }
            if matrix[i] == 0 {
                matrix[i] = value
                if has3InLineInMatrix(value, matrix: matrix) {
                    return i
                }
            }
        }
        return -1
    }

}