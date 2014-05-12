//
//  LobbyViewController.m
//  LobbyFriend
//
//  Created by Imran on 18/03/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "LobbyViewController.h"
#import "SWRevealViewController.h"
#import "headerfiles.h"
#import "LanguageChanged.h"
#import "LobbyCustomPhotoCell.h"
#import "LobbyStatusViewController.h"
#import "UserProfileViewController.h"
#import "LanguageChanged.h"
#import "CustomLobby.h"
#import "LobbyDataController.h"
#import "Post.h"

@interface LobbyViewController ()

@end

@implementation LobbyViewController
@synthesize dataArray,content;
@synthesize lobby;
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

    dataArray = [NSArray arrayWithObjects:@"One",@"Two",@"Three",@"Four",@"Five",@"Six", nil];
    lobby = [[LobbyDataController getLobbyInstance] getDataOfLobby];
   _lobbyBarButton.tintColor = [UIColor redColor];
    _lobbyBarButton.target = self.revealViewController;
    _lobbyBarButton.action = @selector(revealToggle:);
    self.revealViewController.rearViewRevealWidth = 270.0f;
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
   /* _lobbyBarButton.tintColor  = [UIColor colorWithWhite:0.96f alpha:0.2f];
    _lobbyBarButton.target = self.revealViewController;
    self.revealViewController.rearViewRevealWidth = 270.0f;
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    _lobbyBarButton.action = @selector(revealToggle:);*/
    [self.content setBackgroundColor:[[LanguageChanged languageInstance] getTableBG]];
    //self.navigationController.navigationBar.translucent = NO;

    self.tableView.backgroundColor = [UIColor colorWithRed:243/255.f green:240/255.f blue:238/255.f alpha:255/255.f];
    //self.navigationController.navigationBar.tintColor = TOP_NAV_COLOR;
    UIColor *thisColor = [[CustomLobby customLobbyInstance] getTopLobbyColor];
    [self.navigationController.navigationBar setBackgroundImage:[[CustomLobby customLobbyInstance]getImageOfColor:thisColor ] forBarMetrics:UIBarMetricsDefault];
    
    
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    UIColor *thisColor = [[CustomLobby customLobbyInstance] getTopLobbyColor];
    [self.navigationController.navigationBar setBackgroundImage:[[CustomLobby customLobbyInstance]getImageOfColor:thisColor ] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return [self.lobby totalSection];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.numberOfSections==2)
        if (section==0)
            return 1;
    return [self.lobby.postArray count];
    
    //return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Post *post;
    if (tableView.numberOfSections==2) {
        if (indexPath.section==0) {
            post = self.lobby.stickyPost;
        }else
            post = [self.lobby.postArray objectAtIndex:indexPath.row];
    }else{
        post = [lobby.postArray objectAtIndex:indexPath.row];
    }
    static NSString *CellIdentifier = @"NewLobbyCell";
    LobbyCustomPhotoCell *cell = (LobbyCustomPhotoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell== nil) {
        //cell = [[LobbyCustomPhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [self.tableView registerNib:[UINib nibWithNibName:@"LobbyCustomPhotoCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
        cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    }
    
    [cell.labelUserProfile addTarget:self action:@selector(UserProfileAction:) forControlEvents:UIControlEventTouchUpInside];
    //cell.labelMont.text = [dataArray objectAtIndex:indexPath.row];
    [cell configureCell:post atIndex:indexPath];
   
    [cell addSubview:cell.labelUserProfile];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 270.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        [self performSegueWithIdentifier:@"LobbyStatusSegue" sender:nil];
}

- (void)UserProfileAction
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserProfileViewController *profile  = [storyBoard instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
    [self presentViewController:profile animated:YES completion:NULL];
}
- (IBAction)UserProfileAction:(id)sender
{
    
    
    NSLog(@"Cell action ");
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserProfileViewController *profile  = [storyBoard instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
    //[self presentViewController:profile animated:YES completion:NULL];
    [self.navigationController pushViewController:profile animated:YES];
    

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)getProfileID:(UserProfileViewController *)profileName
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserProfileViewController *profile  = [storyBoard instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
   // [self.navigationController];
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[sender identifier ] isEqualToString:@"LobbyStatusSegue"]) {
        
        LobbyStatusViewController *lobbyStatus = segue.destinationViewController;
        [self presentViewController:lobbyStatus animated:YES completion:NULL];
    }

}



@end
