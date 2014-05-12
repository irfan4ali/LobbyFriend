//
//  Setting.h
//  LobbyFriend
//
//  Created by Imran on 10/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Iphone.h"

@interface Setting : NSManagedObject

@property (strong, nonatomic) NSDictionary *iphone;
@property (strong, nonatomic)NSString *picture;
@property (strong, nonatomic) Iphone *iphoneDic;

@end
