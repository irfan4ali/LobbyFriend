//
//  UserProfileViewController.m
//  LobbyFriend
//
//  Created by Imran on 04/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "UserProfileViewController.h"
#import "IQKeyboardManager.h"

@interface UserProfileViewController ()
{
    UIView *currentFieldView;
}

@end

@implementation UserProfileViewController
@synthesize textfieldArray,firstName,lastName,email,userName,password,country,profileTextView,position,school,degree,company,saveLabel,maleSegmentLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	textfieldArray = [[NSArray alloc] initWithObjects:firstName,lastName,email,userName,password,profileTextView,country,position,company,school,degree, nil];
    self.view.backgroundColor = [UIColor colorWithRed:243/255.f green:240/255.f blue:238/255.f alpha:255/255.f];
    for (UITextField *textField in self.textfieldArray)
    {
        [textField addPreviousNextDoneOnKeyboardWithTarget:self previousAction:@selector(previousAction:) nextAction:@selector(nextAction:) doneAction:@selector(doneAction:)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)profileSaveAction:(id)sender {
}

- (IBAction)segementSelect:(UISegmentedControl *)sender {
}

- (IBAction)addPictureAction:(UIButton *)sender {
}
-(void)previousAction:(UISegmentedControl*)segmentedControl
{
	//Getting index of current textField.
	NSInteger index = [self.textfieldArray indexOfObject:currentFieldView]-1;
	
    for (; index>-1; index--)
    {
        UITextField *textField = [self.textfieldArray objectAtIndex:index];
        
        if ([textField canBecomeFirstResponder])
        {
            [textField becomeFirstResponder];
            break;
        }
    }
}

//	Next button action.
-(void)nextAction:(UISegmentedControl*)segmentedControl
{
	//Getting index of current textField.
	NSInteger index = [self.textfieldArray indexOfObject:currentFieldView]+1;
	
    for (; index<self.textfieldArray.count; index++)
    {
        UITextField *textField = [self.textfieldArray objectAtIndex:index];
        
        if ([textField becomeFirstResponder])
        {
            break;
        }
    }
}
-(void)doneAction:(UIBarButtonItem*)barButton
{
    
    [currentFieldView resignFirstResponder];
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    return YES;
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    
    return YES;
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    currentFieldView = textField;
}


@end
