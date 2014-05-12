//
//  PrivateMessageVC.h
//  LobbyFriend
//
//  Created by Imran on 23/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface PrivateMessageVC : UIViewController<UITextFieldDelegate, UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imgUser;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UIButton *workButton;
@property (strong, nonatomic) IBOutlet UIButton *eduButton;
@property (strong, nonatomic) IBOutlet UIButton *locButton;
@property (strong, nonatomic) IBOutlet UITextField *subTextField;
@property (strong, nonatomic) IBOutlet UITextView *msgTextView;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;
- (IBAction)sendMessage:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *imgStaff;
@property (strong, nonatomic) IBOutlet UIImageView *imgOnline;

@property (nonatomic, retain) User *userObject;
@property (strong, nonatomic) NSMutableDictionary *privateMessageRegister;
@property (strong, nonatomic) NSArray *textfieldArray;

@end
