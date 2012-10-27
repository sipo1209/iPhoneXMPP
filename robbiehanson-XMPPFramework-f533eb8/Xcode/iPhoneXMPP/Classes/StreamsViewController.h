//
//  StreamsViewController.h
//  iPhoneXMPP
//
//  Created by Ankur Kothari on 10/27/12.
//
//

#import <UIKit/UIKit.h>

@interface StreamsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *tableView;
    NSMutableArray *publishingOnly;
    NSMutableArray *subscribingOnly;
    NSMutableArray *pubsubBoth;
}

@end
