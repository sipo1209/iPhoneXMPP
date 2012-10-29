//
//  StreamsViewController.h
//  iPhoneXMPP
//
//  Created by Ankur Kothari on 10/27/12.
//
//

#import <UIKit/UIKit.h>
#import "XMPPPubSub.h"
#import "StreamViewController.h"
#import "ConfigureStreamViewController.h"
#import "HomeViewController.h"
@interface StreamsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,XMPPPubSubDelegate>{
       NSMutableArray *publishingOnly;
    NSMutableArray *subscribingOnly;
    NSMutableArray *pubsubBoth;
    StreamViewController *stream;
    ConfigureStreamViewController *configure;
    HomeViewController *home;
}
@property (nonatomic, retain)  HomeViewController *home;
@property (nonatomic, retain)  ConfigureStreamViewController *configure;
@property (nonatomic, retain)  StreamViewController *stream;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic,retain)NSMutableArray *subscribingOnly;

@end
