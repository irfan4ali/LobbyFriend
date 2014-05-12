//
//  SettingsViewController.h
//  LobbyFriend
//
//  Created by Imran on 18/03/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *settingBarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *rightButton;

@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) IBOutlet UITableView *settingTable;
@property (strong, nonatomic) IBOutlet UITableViewCell *settingTableCell;

@end
