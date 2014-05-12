//
//  PrivateMessageVC.m
//  LobbyFriend
//
//  Created by Imran on 23/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "PrivateMessageVC.h"
#import "LFDataModel.h"
#import "SVProgressHUD.h"
#import "IQKeyboardManager.h"


@interface PrivateMessageVC ()
{
    UIView *currentFieldView;
}
@end

@implementation PrivateMessageVC
@synthesize lblName,workButton,eduButton,locButton,imgOnline,imgStaff,imgUser;
@synthesize msgTextView, sendButton,subTextField,userObject,privateMessageRegister;
@synthesize textfieldArray;

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
    textfieldArray = [NSArray arrayWithObjects:subTextField,msgTextView, nil];
    for (UITextField *textField in self.textfieldArray)
    {
        [textField addPreviousNextDoneOnKeyboardWithTarget:self previousAction:@selector(previousAction:) nextAction:@selector(nextAction:) doneAction:@selector(doneAction:)];
    }
	NSLog(@"User %@",userObject);
    privateMessageRegister = [[NSMutableDictionary alloc] init];
    lblName.text = userObject.fullname;
    if ([userObject.isonline boolValue])
        [imgOnline setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ON" ofType:@"png"]]];
    else
        [imgOnline setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"OFF" ofType:@"png"]]];
    if (userObject.location.country.length >0)
        [locButton setTitle:[NSString stringWithFormat:@" %@",userObject.location.country] forState:UIControlStateNormal];
    else
        locButton.hidden = YES;
    if (userObject.occupation.length>0)
        [workButton setTitle:[NSString stringWithFormat:@" %@",userObject.occupation] forState:UIControlStateNormal];
    else
        workButton.hidden = YES;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [msgTextView resignFirstResponder];
}


- (IBAction)sendMessage:(id)sender {
    
    [privateMessageRegister setObject:[NSString stringWithFormat:@"%@",userObject.iden] forKey:@"to"];
    [privateMessageRegister setObject:[NSString stringWithFormat:@"%@",subTextField.text] forKey:@"subject"];
    [privateMessageRegister setObject:[NSString stringWithFormat:@"%@",msgTextView.text] forKey:@"body"];
    LFDataModel *data = [[LFDataModel alloc] init];
    [SVProgressHUD showWithStatus:@"Logging in" maskType:SVProgressHUDMaskTypeGradient];
    [self.view endEditing:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [data PrivateMessageSend:privateMessageRegister];
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            if(true) {
                [self.navigationController popViewControllerAnimated:TRUE];
                // UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                
                // LoginViewController *reward = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                //[self presentViewController:reward animated:NO completion:NULL];
            }else{
                // some code here
                
            }
            
            
        });
        
    });
}
@end
