//
//  DayViewController.h
//  iPhoneXMPP
//
//  Created by Ankur Kothari on 11/16/12.
//
//

#import <UIKit/UIKit.h>

@interface DayViewController : UIViewController{
    NSMutableArray *dayDetails;
    IBOutlet UITextView *tvView;
}
@property (nonatomic,retain)  NSMutableArray *dayDetails;
@property (nonatomic,retain) IBOutlet UITextView *tvView;

@end
