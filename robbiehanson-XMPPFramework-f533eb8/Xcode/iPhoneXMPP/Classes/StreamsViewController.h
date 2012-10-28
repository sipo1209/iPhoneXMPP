//
//  StreamsViewController.h
//  iPhoneXMPP
//
//  Created by Ankur Kothari on 10/27/12.
//
//

#import <UIKit/UIKit.h>
#import "XMPPPubSub.h"
@interface StreamsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,XMPPPubSubDelegate>{
    IBOutlet UITableView *tableView;
    NSMutableArray *publishingOnly;
    NSMutableArray *subscribingOnly;
    NSMutableArray *pubsubBoth;
}

@property (nonatomic,retain)NSMutableArray *subscribingOnly;

@end
