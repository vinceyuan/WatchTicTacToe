//
//  ResultController.h
//  WatchTicTacToe
//
//  Created by Vince Yuan on 4/2/15.
//
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface ResultController : WKInterfaceController

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *labelResult;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *labelStat;

@end
