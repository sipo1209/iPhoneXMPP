//
//  SettingsViewController.h
//  iPhoneXMPP
//
//  Created by Eric Chamberlain on 3/18/11.
//  Copyright 2011 RF.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StreamsViewController.h"
#import "ConfigureStreamViewController.h"
extern NSString *const kXMPPmyJID;
extern NSString *const kXMPPmyPassword;


@interface SettingsViewController : UIViewController 
{
  UITextField *jidField;
  UITextField *passwordField;
    ConfigureStreamViewController *streams;
}
@property (nonatomic,strong) ConfigureStreamViewController *streams;
@property (nonatomic,strong) IBOutlet UITextField *jidField;
@property (nonatomic,strong) IBOutlet UITextField *passwordField;

- (IBAction)done:(id)sender;
- (IBAction)hideKeyboard:(id)sender;

@end
