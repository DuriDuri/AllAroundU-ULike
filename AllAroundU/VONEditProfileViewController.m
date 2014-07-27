//
//  VONEditProfileViewController.m
//  ULike
//
//  Created by Duri Abdurahman Duri on 7/10/14.
//  Copyright (c) 2014 Duri. All rights reserved.
//

#import "VONEditProfileViewController.h"

@interface VONEditProfileViewController ()

@property (strong, nonatomic) IBOutlet UITextView *taglineTextView;

@property (strong, nonatomic) IBOutlet UIImageView *profilePictureImageView;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveButton;



@end

@implementation VONEditProfileViewController

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
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    // Do any additional setup after loading the view.
    PFQuery *query = [PFQuery queryWithClassName:kVONPhotoClassKey];
    [query whereKey:kVONPhotoUserKey equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] > 0 ) {
            PFObject *photo = objects[0];
            PFFile *pictureFile = photo[kVONPhotoPictureKey];
            [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                self.profilePictureImageView.image = [UIImage imageWithData:data];
            }];
        }
    }];
    self.taglineTextView.text = [[PFUser currentUser] objectForKey:kVONUserTagLineKey];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBActions
- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
    
    [[PFUser currentUser] setObject:self.taglineTextView.text forKey:kVONUserTagLineKey];
    [[PFUser currentUser] saveInBackground];
    [self.navigationController popViewControllerAnimated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
