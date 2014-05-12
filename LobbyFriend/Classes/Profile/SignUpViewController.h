//
//  SignUpViewController.h
//  LobbyFriend
//
//  Created by Imran on 18/03/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SignUpViewController : UIViewController <UITextFieldDelegate>

{
    int genderVal,genderChecked, checked;

}

@property (strong, nonatomic) IBOutlet UITextField *firstname;
@property (strong, nonatomic) IBOutlet UITextField *lastname;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *checkBoxButton;
@property (strong, nonatomic) IBOutlet UIButton *maleFemaleLabel;
@property (strong, nonatomic) NSArray *textfieldArray;
@property (strong,nonatomic) NSString *genderString;

@property (strong, nonatomic) IBOutlet UIButton *labelSignUp;
@property (strong, nonatomic) IBOutlet UILabel *labelTerm;
@property (strong, nonatomic) IBOutlet UISegmentedControl *labelSemgent;

@property (strong, nonatomic) NSMutableDictionary *userRegister;


- (IBAction)signUpRegister:(id)sender;
- (IBAction)checkBoxAction:(id)sender;
- (IBAction)genderAction:(id)sender;
- (void)languageChanged;
- (IBAction)maleAndFemaleSelect:(UISegmentedControl *)segment;
@property (strong, nonatomic) IBOutlet UISegmentedControl *maleSegmentLabel;
@property (strong, nonatomic) IBOutlet UIButton *buttonLabel;

- (NSInteger)validateTextFields;
- (BOOL)validateEmailWithString:(NSString *)email;

-(UIImage *) getImageOfColor:(UIColor *)_thisColor;

@end
