//
//  DealDataController.h
//  LobbyFriend
//
//  Created by Imran on 21/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deals.h"
@interface DealDataController : NSObject

@property (nonatomic,retain) Deals *cityDeals, *hotelDeals;
+ (DealDataController *)getDealInstance;

- (void)addDataOfDeals: (Deals *)_deals;
- (Deals *)getDataOfDeals;

@end
