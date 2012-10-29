//
//  StreamViewController.h
//  iPhoneXMPP
//
//  Created by Ankur Kothari on 10/27/12.
//
//

#import <UIKit/UIKit.h>
#import "XMPPPubSub.h"
@interface StreamViewController : UIViewController{
    NSXMLElement *items;
    IBOutlet UITextView *tvView;
    NSString *stream;
    
    IBOutlet UITextField *textField;
}

-(void)setItems:(NSXMLElement *)items forStream:(NSString *)stream;
@end

