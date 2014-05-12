//
//  LobbyCustomPhotoCell.m
//  LobbyFriend
//
//  Created by Imran on 04/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "LobbyCustomPhotoCell.h"
#import "headerfiles.h"
#import "UserProfileViewController.h"
#include "headerfiles.h"
#import "EventFinderDelegate.h"
#import "commonUsedMethod.h"
#import "LobbyViewController.h"
@implementation LobbyCustomPhotoCell

@synthesize content,labelUserProfile;
@synthesize thisPost,index;
@synthesize lblCommentCount,lblLikeCount,lblName,lblOccupation,lblTime,btnLike,imgPost;

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}
+(NSString *)nibName{
    return [self reuseIdentifier];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSString *nibName = [[self class] nibName];
        if (nibName) {
            [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
            [self.contentView addSubview:self.content];
            [self initialCongfig];
        }
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)initialCongfig
{
    self.content.backgroundColor = TABLE_BG;
     
}



- (void)UserProfile{
    NSLog(@"Profile");
}

- (void)configureCell:(Post *)_post atIndex:(NSIndexPath *)thisIndex{

    self.thisPost = _post;
    self.index = thisIndex;
    NSLog(@"Post%@",_post.posterDetail);
    lblName.text = _post.posterDetail.fullname;
    lblTime.text = [NSString stringWithFormat:@"%@",_post.created_time];
    lblOccupation.text = [commonUsedMethod getOccupationString:_post.posterDetail];

}

@end
