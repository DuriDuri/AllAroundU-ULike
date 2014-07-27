//
//  VONProfileViewController.m
//  ULike
//
//  Created by Duri Abdurahman Duri on 7/10/14.
//  Copyright (c) 2014 Duri. All rights reserved.
//

#import "VONProfileViewController.h"

@interface VONProfileViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;



@end

@implementation VONProfileViewController

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
    // Do any additional setup after loading the view.
    
    PFFile *pictureFile = self.photo[kVONPhotoPictureKey];
    [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        self.profilePictureImageView.image = [UIImage imageWithData:data];
    }];
    
    PFUser *user = self.photo[kVONPhotoUserKey];
    
    self.ageLabel.text = [NSString stringWithFormat:@"%@", user[kVONUserProfileKey][kVONUserProfileAgeKey]];
   
    if (user[kVONUserProfileKey][kVONUserProfileRelationshipStatusKey] == nil) self.statusLabel.text = @"Single";
    else self.statusLabel.text = user[kVONUserProfileKey][kVONUserProfileRelationshipStatusKey];

    self.locationLabel.text = user[kVONUserProfileKey][kVONUserProfileLocation];
    
    //Update title and background
    self.title = user[kVONUserProfileKey][kVONUserProfileFirstNameKey];
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - IBActions

- (IBAction)likeButtonPressed:(UIButton *)sender {
    [self.delegate didPressLike];
}

- (IBAction)dislikeButtonPressed:(UIButton *)sender {
    [self.delegate didPressDislike];
}
@end
