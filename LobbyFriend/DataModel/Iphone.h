//
//  Iphone.h
//  LobbyFriend
//
//  Created by Imran on 10/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Iphone : NSManagedObject

@property (nonatomic, retain) NSString * hotel_post_info;
@property (nonatomic, retain) NSString * likes_my_post;
@property (nonatomic, retain) NSString * show_offline;

@end
