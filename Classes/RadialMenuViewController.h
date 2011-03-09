//
//  RadialMenuViewController.h
//  Synth
//
//  Created by Tyler Casselman on 3/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RadialMenuViewController : UIViewController {
    id menuDelegate_;
}
@property (nonatomic, assign) id menuDelegate;

- (IBAction)menuItemSelected:(UIButton *)item;
@end
