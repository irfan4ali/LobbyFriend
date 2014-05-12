//
//  GuestsViewController.m
//  LobbyFriend
//
//  Created by Imran on 07/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "GuestsViewController.h"
#import "SWRevealViewController.h"
#import  "GuestDataController.h"
#import "Guest.h"
#import "SVProgressHUD.h"
#import "LFDataModel.h"
#import "commonUsedMethod.h"
#import "headerfiles.h"
#import "PrivateMessageVC.h"

@interface GuestsViewController ()

@end

@implementation GuestsViewController
@synthesize dataArray,userDictionary;
@synthesize barButtonItem,dataTable;

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
    [self checkExitingDataForDisplay];
    dataArray = [NSArray arrayWithObjects:@"one",@"Two",@"Three", nil];
    barButtonItem.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    userDictionary = [[NSMutableDictionary alloc] init];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    barButtonItem.target = self.revealViewController;
    barButtonItem.action = @selector(revealToggle:);
   self.revealViewController.rearViewRevealWidth = 270.0f;
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    //[self sortUserDataForDisplay];
   // [self reloadTableData];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:TRUE];
    //[self checkExitingDataForDisplay];
    //[self sortUserDataForDisplay];
    //[self newGuestListReceived];
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newGuestListReceived:) name:@"REFRESH_GUESTS" object:nil];
    //[self checkExitingDataForDisplay];
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
    return [userDictionary count];
    //return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    NSArray *keyArray = [userDictionary allKeys];
    NSInteger value =  [[userDictionary valueForKey:[keyArray objectAtIndex:section]] count];
    return  value;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *keyArray = [userDictionary allKeys];
    NSMutableArray *muteArray = [userDictionary valueForKey:[keyArray objectAtIndex:indexPath.section]];
    User *user = [muteArray objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"guestCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UIButton *imgStaff = (UIButton *)[cell viewWithTag:1];
    UIImageView *imgPost  = (UIImageView *)[cell viewWithTag:2];
    UILabel *lblName  = (UILabel *)[cell viewWithTag:3];
    UILabel *lblOccupation  = (UILabel *)[cell viewWithTag:4];
    UILabel *lblTime = (UILabel *)[cell viewWithTag:5];
    UIImageView *imgStatus = (UIImageView *)[cell viewWithTag:6];
    
    lblName.text = user.fullname;
    lblTime.text = user.checkedinago.length>0? user.checkedinago: @"";
    lblOccupation.text = [commonUsedMethod getOccupationString:user];
    [commonUsedMethod addRadiusToView:imgPost];
    
    //[imgPost setImage:[NSURL URLWithString:[commonUsedMethod attachPreImageURL:user.profile_url]] placeholderImage:[commonUsedMethod getPlaceHolderUser:user]];
    if (user.role.userType!=0) {
        //[commonUsedMethod ];
    }
    if ([user.isonline boolValue]) {
        [imgStatus setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ON" ofType:@"png"]]];
    }else
        [imgStatus setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"OFF" ofType:@"png"]]];
    
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *keyArray = [userDictionary allKeys];
    NSMutableArray *muteArray = [userDictionary valueForKey:[keyArray objectAtIndex:indexPath.section]];
    User *user = [muteArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"guestPrivateMessageSegue" sender:user];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 100.0f;
    
    return  height;
}




#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    PrivateMessageVC *privateMessage = (PrivateMessageVC *)segue.destinationViewController;
    privateMessage.userObject = sender;

}

// fetchResultController
- (void)sortUserDataForDisplay{
    
    NSMutableDictionary *newDic = [[NSMutableDictionary alloc] init];
    Guest *guest = [[GuestDataController getGuestInstance] getDataOfGuest];
    NSLog(@"Array %lu",(unsigned long)[guest.guestArray count]);
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"role.userType = %d",AUTHENTICATED_USER];
    NSArray *filtered  = [[NSArray alloc] initWithArray:[guest.guestArray filteredArrayUsingPredicate:predicate]];
    if(filtered && [filtered count]>0)
    {
        [newDic setValue:filtered forKeyPath:[NSString stringWithFormat:@"0"]];
    }

    predicate =[NSPredicate predicateWithFormat:@"role.userType = %d",LOBBYFRIEND_HOTEL];
    NSArray *filtered1  = [[NSArray alloc] initWithArray:[guest.guestArray filteredArrayUsingPredicate:predicate]];
    if(filtered1 && [filtered1 count]>0)
    {
        [newDic setValue:filtered1 forKeyPath:[NSString stringWithFormat:@"%d",LOBBYFRIEND_HOTEL]];
    }

    predicate =[NSPredicate predicateWithFormat:@"role.userType = %d",LOBBYFRIEND_HOTEL_STAFF];
    NSArray *filtered2  = [[NSArray alloc] initWithArray:[guest.guestArray filteredArrayUsingPredicate:predicate]];
    if(filtered2 && [filtered2 count]>0)
    {
        [newDic setValue:filtered2 forKeyPath:[NSString stringWithFormat:@"%d",LOBBYFRIEND_HOTEL_STAFF]];
    }

    self.userDictionary = newDic;
    NSLog(@"Dic:%@",self.userDictionary);
    [self.dataTable reloadData];
    

}
- (void)newGuestListReceived: (NSNotification *)notification{
    
    @try {
        if ([[[notification userInfo] valueForKey:@"lobbyResponse"] boolValue]) {
            [self reloadTableData];
            [self performSelectorOnMainThread:@selector(reloadTableData) withObject:nil waitUntilDone:YES];
        }
    }
    @catch (NSException *exception) {
        //
    }
    @finally {
        [self performSelectorOnMainThread:@selector(removeWaitView) withObject:nil waitUntilDone:YES];
    }
    



}
- (void)reloadTableData{
    [self sortUserDataForDisplay];
    [self.dataTable reloadData];

}

- (void)checkExitingDataForDisplay{
    Guest *guest = [[GuestDataController getGuestInstance] getDataOfGuest];
    LFDataModel *data = [[LFDataModel alloc] init];

    if (!guest) {
        if ([commonUsedMethod getSelectedLobbyTab]==1) {
            
            [SVProgressHUD showWithStatus:@"Logging in" maskType:SVProgressHUDMaskTypeGradient];
            [self.view endEditing:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [data getHotelGuestData];
            //[self sortUserDataForDisplay];
            //[data getCityGuestData];
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
        else{
            [SVProgressHUD showWithStatus:@"Logging in" maskType:SVProgressHUDMaskTypeGradient];
            [self.view endEditing:YES];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [data getCityGuestData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    if(true) {
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
