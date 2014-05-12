//
//  EventViewController.h
//  LobbyFriend
//
//  Created by Imran on 11/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "Event.h"
@interface EventViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *eventBarButton;
@property (strong, nonatomic) IBOutlet UITableView *dataTable;
@property (retain, nonatomic) Event *events;

- (void)checkExitingDataForDisplay;
- (void)reloadTableData;
@end
