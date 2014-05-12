//
//  GuestsViewController.h
//  LobbyFriend
//
//  Created by Imran on 07/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "Deals.h"
@interface GuestsViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barButtonItem;

@property (strong,nonatomic) NSMutableDictionary *userDictionary;
@property (strong, nonatomic) IBOutlet UITableView *dataTable;



- (void)checkExitingDataForDisplay;
- (void)sortUserDataForDisplay;
- (void)newGuestListReceived: (NSNotification *)notification;
- (void)reloadTableData;

@end
