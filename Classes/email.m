//
//  email.m
//  sendgrid-ios-demo
//
//  Created by Heitor Sergent on 6/23/14.
//  Copyright (c) 2014 heitortsergent. All rights reserved.
//

#import "Email.h"

@implementation Email

- (id)init
{
    self = [super init];
    if (self)
    {
        [self setInlinePhoto:false];
    }
    return self;
}

- (void)attachImage:(UIImage *)img
{
    if (self.imgs == NULL)
        self.imgs = [[NSMutableArray alloc] init];
    [self.imgs addObject:img];
}

- (NSDictionary *)parametersDictionary:(NSString *)apiUser apiKey:(NSString *)apiKey
{
    NSMutableDictionary *parameters =[NSMutableDictionary dictionaryWithDictionary:@{@"api_user": apiUser, @"api_key": apiKey, @"subject":self.subject, @"from":self.from, @"html":self.html,@"to":self.to, @"text":self.text, @"x-smtpapi":self.xsmtpapi}];
    
    
    //optional parameters
    if (self.bcc != nil)
        [parameters setObject:self.bcc forKey:@"bcc"];
    
    if (self.toName != nil)
        [parameters setObject:self.toName forKey:@"toname"];
    
    if (self.fromName != nil)
        [parameters setObject:self.fromName forKey:@"fromname"];
    
    if (self.replyTo != nil)
        [parameters setObject:self.replyTo forKey:@"replyto"];

    if (self.date != nil)
        [parameters setObject:self.date forKey:@"date"];
    
    if (self.inlinePhoto)
    {
        for(int i = 0; i < self.imgs.count; i++)
        {
            
            NSString *filename = [NSString stringWithFormat:@"image%d.png", i];
            NSString *key = [NSString stringWithFormat:@"content[image%d.png]", i];
            NSLog(@"name: %@, Filename: %@", key, filename);
            [parameters setObject:filename forKey:key];
            
        }
    }
    
    return parameters;
}

@end
