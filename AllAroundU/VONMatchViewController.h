//
//  VONMatchViewController.h
//  ULike
//
//  Created by Duri Abdurahman Duri on 7/21/14.
//  Copyright (c) 2014 Duri. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VONMatchViewControllerDelegate <NSObject>

-(void)presentMatchesViewController;

@end

@interface VONMatchViewController : UIViewController

@property (strong, nonatomic) UIImage *matchedUserImage;

@property (weak, nonatomic) id<VONMatchViewControllerDelegate> delegate;

@end
