//
//  DealDataController.m
//  LobbyFriend
//
//  Created by Imran on 21/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "DealDataController.h"

@implementation DealDataController
@synthesize cityDeals,hotelDeals;
static DealDataController *_sharedInstance;

+ (DealDataController *)getDealInstance;{
    @synchronized([DealDataController class]){
        if (!_sharedInstance) {
            [[self alloc] init];
            return _sharedInstance;
        }
    }
    return _sharedInstance;
    
}
+ (id)alloc{
    @synchronized([DealDataController class]){
        _sharedInstance = [super alloc];
        return  _sharedInstance;
    }
    return nil;
}




- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (Deals *)getDataOfDeals{
    if (true) {
        return cityDeals;
    }else
        return hotelDeals;
}
- (void)addDataOfDeals:(Deals *)_deals{
    if (true) {
        cityDeals = _deals;
    }else{
        hotelDeals = _deals;
    }
}
@end
