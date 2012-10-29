//
//  RegsiterViewController.h
//  iPhoneXMPP
//
//  Created by Ankur Kothari on 10/26/12.
//
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
extern NSString *const kXMPPmyJID;
extern NSString *const kXMPPmyPassword;

@interface RegisterViewController : UIViewController{
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    HomeViewController *home;
}
@property(nonatomic,retain)   HomeViewController *home;
@end
