//
//  DealViewController.m
//  LobbyFriend
//
//  Created by Imran on 11/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "DealViewController.h"
#import "SWRevealViewController.h"
#import "Deals.h"
#import "DealDataController.h"
#import "LFDataModel.h"
#import "commonUsedMethod.h"
#import "SVProgressHUD.h"
#import "commonUsedMethod.h"
#import "Deals.h"
#import "DealDataController.h"

@interface DealViewController ()

@end

@implementation DealViewController
@synthesize dealBarButton,dataArray,dataTable,deals;
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
    dealBarButton.target = self.revealViewController;
    dealBarButton.action = @selector(revealToggle:);
    self.revealViewController.rearViewRevealWidth = 270.0f;
    dealBarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    dataArray = [NSArray arrayWithObjects:@"Deal One", @"Deal Two", @"Deal Three", nil];
    //[self checkExitingDataForDisplay];
    
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
    if (self.deals.stickyPost) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.numberOfSections==2) {
        if (section==0) {
            return 1;
            return [self.deals.dealsArray count];
        }
    }else if (tableView.numberOfSections==1)
        return [self.deals.dealsArray count];
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Deals Array %@",self.deals.dealsArray);
    Post *post;
    if (tableView.numberOfSections==2) {
        if (indexPath.section==0) {
            post = self.deals.stickyPost;
        }else
            post = [self.deals.dealsArray objectAtIndex:indexPath.row];
        
    }else
        post = [self.deals.dealsArray objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"dealCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UIButton *imgStaff = (UIButton *)[cell viewWithTag:1];
    UIButton *imgEventImage = (UIButton *)[cell viewWithTag:2];
    UILabel *lblEventName = (UILabel *)[cell viewWithTag:3];
    UILabel *lblOccupation = (UILabel *)[cell viewWithTag:4];
    UILabel *lblEventLocation = (UILabel *)[cell viewWithTag:5];
    UILabel *lblEventTime = (UILabel *)[cell viewWithTag:6];
    UILabel *lblEventPrice = (UILabel *)[cell viewWithTag:7];
    
    lblEventName.text = post.title;
    lblEventLocation.text = post.where.length>0? post.where : @"";
    lblOccupation.text = [[commonUsedMethod getOccupationString:post.posterDetail] length]>0? [commonUsedMethod getOccupationString:post.posterDetail]: @"";
    lblEventTime.text = [NSString stringWithFormat:@"%@",post.created_time];
    lblEventPrice.text = post.cost;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 100.0f;
    
    return  height;
}
- (void)reloadTableData{
    self.deals = [[DealDataController getDealInstance] getDataOfDeals];
    [self.dataTable reloadData];
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
- (void)checkExitingDataForDisplay{
    Deals *deals = [[DealDataController getDealInstance] getDataOfDeals];
    LFDataModel *data = [[LFDataModel alloc] init];
    
    if (!deals) {
        if ([commonUsedMethod getSelectedLobbyTab]==1) {
            [SVProgressHUD showWithStatus:@"Logging in" maskType:SVProgressHUDMaskTypeGradient];
            [self.view endEditing:YES];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [data getHotelDealsData];
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
                [data getHotelDealsData];
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
