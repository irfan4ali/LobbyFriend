//
//  UserProfileViewController.h
//  LobbyFriend
//
//  Created by Imran on 04/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextView *profileTextView;
@property (strong, nonatomic) IBOutlet UITextField *country;
@property (strong, nonatomic) IBOutlet UITextField *position;
@property (strong, nonatomic) IBOutlet UITextField *company;
@property (strong, nonatomic) IBOutlet UITextField *degree;

@property (strong, nonatomic) IBOutlet UITextField *school;
@property (strong, nonatomic) IBOutlet UIButton *saveLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *maleSegmentLabel;


- (IBAction)profileSaveAction:(id)sender;
- (IBAction)segementSelect:(UISegmentedControl *)sender;
- (IBAction)addPictureAction:(UIButton *)sender;

@property (strong, nonatomic) NSArray *textfieldArray;

@end
