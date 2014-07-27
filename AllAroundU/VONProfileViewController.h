//
//  VONProfileViewController.h
//  ULike
//
//  Created by Duri Abdurahman Duri on 7/10/14.
//  Copyright (c) 2014 Duri. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VONProfileViewControllerDelegate <NSObject>

-(void)didPressLike;
-(void)didPressDislike;

@end

@interface VONProfileViewController : UIViewController

@property (strong, nonatomic) PFObject *photo;

@property (weak, nonatomic) id<VONProfileViewControllerDelegate> delegate;
@end
