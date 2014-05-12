//
//  LobbyCustomPhotoCell.h
//  LobbyFriend
//
//  Created by Imran on 04/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
//@class Post;
@interface LobbyCustomPhotoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblOccupation;
@property (strong, nonatomic) IBOutlet UILabel *lblTime;
@property (strong, nonatomic) IBOutlet UIButton *btnLike;
@property (strong, nonatomic) IBOutlet UILabel *lblLikeCount;
@property (strong, nonatomic) IBOutlet UIButton *imgPost;
@property (strong, nonatomic) IBOutlet UILabel *lblCommentCount;





- (id)init;
+ (NSString *)reuseIdentifier;
@property (strong, nonatomic) IBOutlet UILabel *labelMont;
@property (strong, nonatomic) IBOutlet UIView *content;
@property (nonatomic, retain) Post *thisPost;
@property (strong, nonatomic) NSIndexPath *index;

- (void)initialCongfig;
- (IBAction)UserProfileAction:(id)sender;


@property (strong,nonatomic)IBOutlet LobbyCustomPhotoCell *customCell;
@property (strong, nonatomic) IBOutlet UIButton *labelUserProfile;
- (void)UserProfile;

- (void)configureCell: (Post *)_post atIndex:(NSIndexPath *)thisIndex;



@end
