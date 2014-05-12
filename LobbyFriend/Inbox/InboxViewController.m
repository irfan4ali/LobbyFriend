//
//  InboxViewController.m
//  LobbyFriend
//
//  Created by Imran on 11/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "InboxViewController.h"
#import "SWRevealViewController.h"
#import "commonUsedMethod.h"
#import "LFDataModel.h"
#import "Inbox.h"
#import "InboxDataController.h"
#import "SVProgressHUD.h"
#import "UserProfileViewController.h"
#import "PrivateMessageVC.h"
#import "MessageDetailVC.h"
@interface InboxViewController ()

@end

@implementation InboxViewController
@synthesize inboxBarButton,inbox,tableData;
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

    inboxBarButton.target = self.revealViewController;
    inboxBarButton.action = @selector(revealToggle:);
    self.revealViewController.rearViewRevealWidth = 270.0f;
    inboxBarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Add pan gesture to hide the sidebar
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self checkExitingDataForDisplay];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:TRUE];
    [self reloadTableData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.inbox.messageArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"inboxCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Message *message = [self.inbox.messageArray objectAtIndex:indexPath.row];
    UIButton *imgStaff = (UIButton *)[cell viewWithTag:1];
    UIButton *imagePost = (UIButton *)[cell viewWithTag:2];
    UILabel *lblName = (UILabel *)[cell viewWithTag:3];
    UILabel *lblOccupation = (UILabel *)[cell viewWithTag:4];
    UITextView *lblTextView = (UITextView *)[cell viewWithTag:5];
    UILabel *lblTime = (UILabel *)[cell viewWithTag:6];
    UIImageView *newMessageImage = (UIImageView *)[cell viewWithTag:7];
    UIImageView *imgOnline = (UIImageView *)[cell viewWithTag:8];
    
    lblName.text= message.sender.fullname;
    lblTextView.text =message.body;
    lblOccupation.text = [commonUsedMethod getOccupationString:message.sender];
    if ([message.read_status intValue]!=0) {
        newMessageImage.hidden = FALSE;
    }else
        newMessageImage.hidden = YES;
    if ([message.sender.isonline boolValue]) {
        [imgOnline setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ON" ofType:@"png"]]];
    }else
        [imgOnline setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"OFF" ofType:@"png"]]];
    [imagePost addTarget:self action:@selector(UserProfileAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 100.0f;
    
    return  height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Message *message = [self.inbox.messageArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"MessageDetailSegue" sender:message];
    
}

- (void)reloadTableData{
    self.inbox = [[InboxDataController getInboxInstance] getDataOfInbox];
    [self.tableData reloadData];
}
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MessageDetailSegue"]) {
        MessageDetailVC *messageDetails = (MessageDetailVC *)segue.destinationViewController;
        messageDetails.messageDetail = sender;
        
    }
    
}
- (IBAction)UserProfileAction:(id)sender
{
    
    
    NSLog(@"Cell action ");
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserProfileViewController *profile  = [storyBoard instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
    //[self presentViewController:profile animated:YES completion:NULL];
    [self.navigationController pushViewController:profile animated:YES];
    
    
}



- (void)checkExitingDataForDisplay{
    Inbox *inboxControl = [[InboxDataController getInboxInstance] getDataOfInbox];
    LFDataModel *data = [[LFDataModel alloc] init];
    
    if (!inboxControl) {
        if ([commonUsedMethod getSelectedLobbyTab]==1) {
            [SVProgressHUD showWithStatus:@"Logging in" maskType:SVProgressHUDMaskTypeGradient];
            [self.view endEditing:YES];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [data getInboxData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    if(true) {
                        [self reloadTableData];
                        // UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        
                        // LoginViewController *reward = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                        //[self presentViewController:reward animated:NO completion:NULL];
                    }else{
                        // some code here
                        
                    }
                    
                    
                });
                
            });
        }

    }
    
}



@end
