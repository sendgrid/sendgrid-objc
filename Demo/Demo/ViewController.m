//
//  ViewController.m
//  Demo
//
//  Created by Kunal Batra on 10/31/13.
//  Copyright (c) 2013 SendGrid. All rights reserved.
//

#import "ViewController.h"
#import <SendGrid/SendGrid.h>
#import <SendGrid/SendGridEmail.h>

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

- (IBAction)attachPhoto:(id)sender
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)sendEmail:(id)sender
{
#warning Don't forget to change the apiUser and apiKey values
    SendGrid *sendgrid = [SendGrid apiUser:@"YOUR_USERNAME" apiKey:@"YOUR_PASSWORD"];
    
    SendGridEmail *email = [[SendGridEmail alloc] init];
    email.to = @"foo@bar.com";
    email.from = @"bar@foo.com";
    email.subject = @"testing format";
    email.html = @"<h1>hello world</h1>";
    email.text = @"hello world";
    
    //Uncomment this part to send an email with an inline image, category,
    //unique argument and substitution
    
    /*
    UIImage *sendgridLogo = [UIImage imageNamed:@"sendgrid_logo.png"];
    [email attachImage:sendgridLogo];
    
    email.inlinePhoto = true;
    email.html = @"<h1>hello world</h1><img src=\"cid:image0.png\">";
    
    [email.smtpapi addSubstitution:@"-name-" val:@"Awesome Person"];
    
    [email.smtpapi addUniqueArg:@"uid" val:@"12345"];
    [email.smtpapi addCategory:@"welcome_email"];
    
    //Image attachment
    if (self.imgs != NULL) {
        for (UIImage *img in self.imgs){
            [email attachImage:img];
        }
    }
    */

    //this is an example of sending an image as a general attachment
    //you can send other types of files as well
    /*
    UIImage *sendgridLogo = [UIImage imageNamed:@"sendgrid_logo.png"];

    SendGridEmailAttachment* someImageAttachment = [[SendGridEmailAttachment alloc] init];
    someImageAttachment.attachmentData = UIImagePNGRepresentation(sendgridLogo);
    someImageAttachment.mimeType = @"image/png";
    someImageAttachment.fileName = @"sendgrid_logo";
    someImageAttachment.extension = @"png";
    
    [email attachFile:someImageAttachment];

    [sendgrid sendAttachmentWithWeb:email];
    */
    
    [sendgrid sendWithWeb:email];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    NSLog(@"Image Name: %@",info[UIImagePickerControllerMediaURL]);
    if (self.imgs == NULL)
        self.imgs = [[NSMutableArray alloc] init];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self.imgs addObject:chosenImage];
    self.preview.image = chosenImage;
}
@end
