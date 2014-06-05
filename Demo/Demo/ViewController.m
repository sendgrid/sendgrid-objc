//
//  ViewController.m
//  Demo
//
//  Created by Kunal Batra on 10/31/13.
//  Copyright (c) 2013 SendGrid. All rights reserved.
//

#import "ViewController.h"

#import "sendgrid.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    	// Do any additional setup after loading the view, typically from a nib.
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)attachPhoto:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)sendMsg:(id)sender {
    //create Email Object
    sendgrid *msg = [sendgrid user:@"username" andPass:@"password"];
    
    //set parameters
    msg.subject = @"testing format";
    msg.to = @"foo@bar.com";
    
    msg.from = @"bar@foo.com";
    msg.text = @"hello world";
    msg.html = @"<h1>hello world</h1>";
    
    //**html message to use when setting inline photos as true**
    //msg.inlinePhoto = true;
    //msg.html = @"<img src =\"cid:image.png\"><h1>hello world</h1>";
    
    //adding unique arguments
    NSDictionary *uarg = @{@"customerAccountNumber":@"55555",
                           @"activationAttempt": @"1"};
    
    //adding categories
    NSString *replyto = @"billing_notifications";
    
    [msg addCustomHeader:uarg withKey:@"unique_args"];
    [msg addCustomHeader:replyto withKey:@"category"];
    
    //Image attachment
    if (self.imgs != NULL) {
        for (UIImage *img in self.imgs){
            [msg attachImage:img];
        }
    }

    //Send email through Web API Transport
    [msg sendWithWeb];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    NSLog(@"Image Name: %@",info[UIImagePickerControllerMediaURL]);
    if (self.imgs == NULL)
        self.imgs = [[NSMutableArray alloc] init];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self.imgs addObject:chosenImage];
    self.preview.image = chosenImage;

    
}
@end
