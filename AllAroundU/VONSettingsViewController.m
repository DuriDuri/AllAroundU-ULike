//
//  VONSettingsViewController.m
//  ULike
//
//  Created by Duri Abdurahman Duri on 7/10/14.
//  Copyright (c) 2014 Duri. All rights reserved.
//

#import "VONSettingsViewController.h"

@interface VONSettingsViewController ()

@property (strong, nonatomic) IBOutlet UISlider *ageSlider;
@property (strong, nonatomic) IBOutlet UISwitch *menSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *womenSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *singlesOnlySwitch;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UIButton *logoutButton;
@property (strong, nonatomic) IBOutlet UIButton *editProfileButton;


@end

@implementation VONSettingsViewController

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
    self.ageSlider.value = [[NSUserDefaults standardUserDefaults] integerForKey:kVONAgeMaxKey];
    self.menSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kVONMenEnabledKey];
    self.womenSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kVONWomenEnabledKey];
    self.singlesOnlySwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kVONSingleEnabledKey];
    
    
    [self.ageSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.menSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.womenSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.singlesOnlySwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.ageLabel.text = [NSString stringWithFormat:@"%i", (int)self.ageSlider.value];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)logoutButtonPressed:(UIButton *)sender {
    [PFUser logOut];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (IBAction)editProfileButtonPressed:(UIButton *)sender {
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

#pragma mark - Helper

-(void) valueChanged:(id)sender
{
    if (sender == self.ageSlider) {
        [[NSUserDefaults standardUserDefaults] setInteger:self.ageSlider.value forKey:kVONAgeMaxKey];
        self.ageLabel.text = [NSString stringWithFormat:@"%i", (int)self.ageSlider.value];
    }
    else if (sender == self.menSwitch){
        [[NSUserDefaults standardUserDefaults] setBool:self.menSwitch.isOn forKey:kVONMenEnabledKey];
    }
    else if (sender == self.womenSwitch){
        [[NSUserDefaults standardUserDefaults] setBool:self.womenSwitch.isOn forKey:kVONWomenEnabledKey];
    }
    else if (sender == self.singlesOnlySwitch){
        [[NSUserDefaults standardUserDefaults] setBool:self.singlesOnlySwitch.isOn forKey:kVONSingleEnabledKey];
    }
    
    [[NSUserDefaults standardUserDefaults]  synchronize];
}
@end
