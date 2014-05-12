//
//  SettingsViewController.m
//  LobbyFriend
//
//  Created by Imran on 18/03/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "SettingsViewController.h"
#import "SWRevealViewController.h"
#import "GuestsViewController.h"
#import "LobbyViewController.h"
#import "GuestsViewController.h"
#import "EventViewController.h"
#import "DealViewController.h"
#import "InboxViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize dataArray,settingTable,settingTableCell;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    dataArray = [NSArray arrayWithObjects:@"Lobby", @"Guests", @"Deals",@"Events",@"Inbox", nil];
    
    _settingBarButton.tintColor  = [UIColor redColor];
    _settingBarButton.target = self.revealViewController;
    

  //self.revealViewController.rightViewRevealWidth = 100.0f;
    // self.revealViewController.rearViewRevealWidth = 100.0f;
    self.revealViewController.rearViewRevealWidth = 270.0f;
    _settingBarButton.action = @selector(revealToggle:);
    settingTable.backgroundColor = [UIColor grayColor];
    settingTableCell.backgroundColor = [UIColor grayColor];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    //self.tableView.backgroundColor = [UIColor darkGrayColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{


    return [dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *CellIdentifier = @"guestSettingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    if (cell==nil) {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    UILabel *myLabel = (UILabel *)[cell viewWithTag:98];
    UIImageView *myImage = (UIImageView *)[cell viewWithTag:100];
    UIView *myView = (UIView *)[cell viewWithTag:99];
    UIImageView *profileImage = (UIImageView *)[cell viewWithTag:101];
    

 /*   if (indexPath.row==0) {
        profileImage.image = [UIImage imageNamed:@"user_pic"];
        myImage.image = [UIImage imageNamed:@"menu-button-lobby"];
        
        myImage.hidden = YES;
        [myLabel setText:@"Profile"];
        
    }else*/
        
        if (indexPath.section==0) {
        profileImage.hidden = YES;
        myImage.image = [UIImage imageNamed:@"menu-button-lobby"];
        [myLabel setText:@"Lobby" ];
        
    }else if (indexPath.section==1){
        profileImage.hidden = YES;
        myImage.image = [UIImage imageNamed:@"menu-button-guests"];
        [myLabel setText:@"Guests" ];
    
    }else if (indexPath.section==2){
        profileImage.hidden = YES;
        myImage.image = [UIImage imageNamed:@"menu-button-deals"];
        [myLabel setText:@"Deals" ];
    
    }else if (indexPath.section==3){
        profileImage.hidden = YES;
        myImage.image = [UIImage imageNamed:@"menu-button-events"];
        [myLabel setText:@"Events" ];
    
    }else{
        profileImage.hidden = YES;
        myImage.image = [UIImage imageNamed:@"menu-button-inbox"];
        [myLabel setText:@"Inbox" ];
    
    }
    
    myView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg.png"]];
    //cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor darkGrayColor];

    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==0) {
        [self performSegueWithIdentifier:@"lobbySegue" sender:nil];
    }else if (indexPath.section==1){
        [self performSegueWithIdentifier:@"guestSegue" sender:nil];
    
    }else if (indexPath.section==2){
        [self performSegueWithIdentifier:@"dealSegue" sender:nil];
    
    }else if (indexPath.section==3){
        [self performSegueWithIdentifier:@"eventSegue" sender:nil];
    
    }else{
        [self performSegueWithIdentifier:@"inboxSegue" sender:nil];
    }
     
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 50.0f;

    return  height;
}






- (void)prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender
{
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[dataArray objectAtIndex:indexPath.row] capitalizedString];
    
    // Set the photo if it navigates to the PhotoView
    if ([segue.identifier isEqualToString:@"lobbySegue"]) {
        LobbyViewController *lobbyController = (LobbyViewController*)segue.destinationViewController;
        
        lobbyController.title = [dataArray objectAtIndex:indexPath.section];
    }else if ([segue.identifier isEqualToString:@"guestSegue"]){
        GuestsViewController *guestController = (GuestsViewController *)segue.destinationViewController;
        guestController.title = [dataArray objectAtIndex:indexPath.section];
    }else if ([segue.identifier isEqualToString:@"eventSegue"]){
        EventViewController *eventController = (EventViewController *)segue.destinationViewController;
        eventController.title = [dataArray objectAtIndex:indexPath.section];
    }else if ([segue.identifier  isEqualToString:@"dealSegue"]){
        DealViewController *dealController = (DealViewController *)segue.destinationViewController;
        dealController.title = [dataArray objectAtIndex:indexPath.section];
    }else if ([segue.identifier  isEqualToString:@"inboxSegue"]) {
        InboxViewController *inboxController = (InboxViewController *)segue.destinationViewController;
        inboxController.title = [dataArray objectAtIndex: indexPath.section];
    }
    
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }
    
}

#pragma mark - Navigation
/*
// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[sender identifier ] isEqualToString:@"GuestViewSegue"]) {
        
        GuestsViewController *lobbyStatus = segue.destinationViewController;
        [self presentViewController:lobbyStatus animated:YES completion:NULL];
    }
}
*/


@end
