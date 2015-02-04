//
//  InterfaceController.h
//  WatchTicTacToe WatchKit Extension
//
//  Created by Vince Yuan on 4/2/15.
//
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

#define KEY_SELF_WIN_COUNT @"Self win count"
#define KEY_PC_WIN_COUNT @"PC win count"

typedef enum {
    GameResultNotEnd = 0,
    GameResultWin,
    GameResultLose,
    GameResultEnd,
} GameResult;

@interface InterfaceController : WKInterfaceController

@property (weak, nonatomic) IBOutlet WKInterfaceButton *button0;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button1;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button2;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button3;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button4;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button5;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button6;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button7;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button8;

- (void)restartGame;
@end
