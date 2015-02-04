//
//  InterfaceController.m
//  WatchTicTacToe WatchKit Extension
//
//  Created by Vince Yuan on 4/2/15.
//
//

#import "InterfaceController.h"
#import <stdlib.h>

@interface InterfaceController() {
    NSArray *_buttons;
    int _matrix[9];
    BOOL _shouldPcMove;
}

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.

    _buttons = @[_button0, _button1, _button2, _button3, _button4, _button5, _button6, _button7, _button8];
}

- (void)restartGame {
    for (int i = 0; i < 9; i++)
        _matrix[i] = 0;
    for (WKInterfaceButton *button in _buttons) {
        [button setTitle:@""];
    }
    _shouldPcMove = arc4random_uniform(2);
    if (_shouldPcMove) {
        [self performSelector:@selector(pcMove) withObject:nil afterDelay:0.5f];
    }
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];

    [self restartGame];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)pressButton0 {
    [self pressButton:_button0];
}
- (IBAction)pressButton1 {
    [self pressButton:_button1];
}
- (IBAction)pressButton2 {
    [self pressButton:_button2];
}
- (IBAction)pressButton3 {
    [self pressButton:_button3];
}
- (IBAction)pressButton4 {
    [self pressButton:_button4];
}
- (IBAction)pressButton5 {
    [self pressButton:_button5];
}
- (IBAction)pressButton6 {
    [self pressButton:_button6];
}
- (IBAction)pressButton7 {
    [self pressButton:_button7];
}
- (IBAction)pressButton8 {
    [self pressButton:_button8];
}

- (void)pcMove {
    NSUInteger index = 0;
    do {
        index = arc4random_uniform(9);
    } while (_matrix[index] != 0);

    _matrix[index] = 2;
    WKInterfaceButton *button = [_buttons objectAtIndex:index];
    [button setTitle:@"🐷"];

    _shouldPcMove = !_shouldPcMove;
    [self performSelector:@selector(checkGameResult) withObject:nil afterDelay:0.5f];
}

- (void)pressButton:(WKInterfaceButton *)button {
    NSUInteger index = [_buttons indexOfObject:button];
    if (_matrix[index] != 0)
        return;

    _matrix[index] = 1;
    [button setTitle:@"💩"];
    _shouldPcMove = !_shouldPcMove;
    [self performSelector:@selector(checkGameResult) withObject:nil afterDelay:0.5f];
}

- (void)checkGameResult {
    GameResult result = [self calculateGameResult];
    if (result == GameResultNotEnd) {
        if (_shouldPcMove) {
            [self pcMove];
        }
        return;
    } else if (result == GameResultWin) {
        // win
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSInteger count = [userDefaults integerForKey:KEY_SELF_WIN_COUNT];
        count++;
        [userDefaults setInteger:count forKey:KEY_SELF_WIN_COUNT];
        [userDefaults synchronize];
    } else if (result == GameResultLose) {
        // lose
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSInteger count = [userDefaults integerForKey:KEY_PC_WIN_COUNT];
        count++;
        [userDefaults setInteger:count forKey:KEY_PC_WIN_COUNT];
        [userDefaults synchronize];
    } else {
        // end
    }

    [self presentControllerWithName:@"resultController" context:@{@"result": [NSNumber numberWithInt:result]}];
}

- (GameResult)calculateGameResult {
    if ([self has3InLine:1]) {
        return GameResultWin;
    }

    if ([self has3InLine:2]) {
        return GameResultLose;
    }

    int total = 0;
    for (int i = 0; i < 9; i++) {
        if (_matrix[i] != 0)
            total++;
    }
    if (total == 9) {
        return GameResultEnd;
    }
    return GameResultNotEnd;
}

- (BOOL)has3InLine:(int)value {
    if (
        (_matrix[0] == value && _matrix[1] == value && _matrix[2] == value)
        || (_matrix[3] == value && _matrix[4] == value && _matrix[5] == value)
        || (_matrix[6] == value && _matrix[7] == value && _matrix[8] == value)
        || (_matrix[0] == value && _matrix[3] == value && _matrix[6] == value)
        || (_matrix[1] == value && _matrix[4] == value && _matrix[7] == value)
        || (_matrix[2] == value && _matrix[5] == value && _matrix[8] == value)
        || (_matrix[0] == value && _matrix[4] == value && _matrix[8] == value)
        || (_matrix[2] == value && _matrix[4] == value && _matrix[6] == value)
        )
        return YES;
    return NO;
}


@end



