//
//  Post.h
//  LobbyFriend
//
//  Created by Imran on 13/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User,Flags;
@interface Post : NSManagedObject

@property (nonatomic, retain) NSNumber * comments;
@property (nonatomic, retain) NSNumber * commentcount;
@property (nonatomic, retain) NSNumber * likecount;
@property (nonatomic, retain) NSString * cost;
@property (nonatomic, retain) NSNumber * created;
@property (nonatomic, retain) NSNumber * created_time;
@property (nonatomic, retain) NSString * createdTime;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * attribute;
@property (nonatomic, retain) NSString * description2;
@property (nonatomic, retain) NSString *description1;
@property (nonatomic, retain) NSString * from;
@property (nonatomic, retain) NSString * guests;
@property (nonatomic, retain) NSNumber * hotelID;
@property (nonatomic, retain) NSString * iden;
@property (nonatomic, retain) NSNumber * priority;
@property (nonatomic, retain) NSString * img;
@property (nonatomic, retain) NSNumber * joined;
@property (nonatomic, retain) NSString * optext;
@property (nonatomic, retain) NSNumber * optype;
@property (nonatomic, retain) NSNumber * sticky;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * htmlTitle;
@property (nonatomic, retain) NSString * to;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * currency;
@property (nonatomic, retain) NSString * where;
@property (nonatomic, retain) NSString *timeago;
@property (nonatomic, retain) NSString * post_picture;
@property (nonatomic, retain) User *posterDetail;
@property (nonatomic, retain) Flags *flag;

@end
