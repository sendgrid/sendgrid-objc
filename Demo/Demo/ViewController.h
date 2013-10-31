//
//  ViewController.h
//  Demo
//
//  Created by Kunal Batra on 10/31/13.
//  Copyright (c) 2013 SendGrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) UIImage *img;
@property (weak, nonatomic) IBOutlet UIImageView *preview;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

- (IBAction)attachPhoto:(id)sender;
- (IBAction)sendMsg:(id)sender;

@end
