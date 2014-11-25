//
//  SendGrid.m
//

#import "SendGrid.h"

NSString * const sgDomain = @"https://api.sendgrid.com/";
NSString * const sgEndpoint = @"api/mail.send.json";

@interface SendGrid ()

@property (strong, nonatomic) NSString *baseURL;

@end

@implementation SendGrid

+ (instancetype)apiUser:(NSString *)apiUser apiKey:(NSString *)apiKey
{
    SendGrid *message = [[SendGrid alloc] initWithApiUser:apiUser apiKey:apiKey];
    
    return message;
}

- (id)initWithApiUser:(NSString *)apiUser apiKey:(NSString *)apiKey
{
    self = [super init];
    if (self)
    {
        self.apiUser = apiUser;
        self.apiKey =  apiKey;
    }
    return self;
}

- (void)sendWithWeb:(SendGridEmail *)email
{
    [self sendWithWeb:email
         successBlock:^(id responseObject)
     {
         NSLog(@"Success: %@", responseObject);
     }
         failureBlock:^(NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}

- (void)sendAttachmentWithWeb:(SendGridEmail *)email
{
    [self sendAttachmentWithWeb:email
         successBlock:^(id responseObject)
     {
         NSLog(@"Success: %@", responseObject);
     }
         failureBlock:^(NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}

- (void)sendWithWeb:(SendGridEmail *)email successBlock:(void(^)(id responseObject))successBlock failureBlock:(void(^)(NSError *error))failureBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager POST:self.baseURL parameters:[email parametersDictionary:self.apiUser apiKey:self.apiKey] constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        for (int i = 0; i < email.imgs.count; i++)
        {
            UIImage *img = [email.imgs objectAtIndex:i];
            NSString *filename = [NSString stringWithFormat:@"image%d.png", i];
            NSString *name = [NSString stringWithFormat:@"files[image%d.png]", i];
            NSLog(@"name: %@, Filename: %@", name, filename);
            NSData *imageData = UIImagePNGRepresentation(img);
            [formData appendPartWithFileData:imageData name:name fileName:filename mimeType:@"image/png"];
        }
    }
          success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        successBlock(responseObject);
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        failureBlock(error);
    }];

}

- (void)sendAttachmentWithWeb:(SendGridEmail *)email successBlock:(void(^)(id responseObject))successBlock failureBlock:(void(^)(NSError *error))failureBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:self.baseURL parameters:[email parametersDictionary:self.apiUser apiKey:self.apiKey] constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         for (int i = 0; i < email.attachments.count; i++)
         {
             SendGridEmailAttachment *attachment = [email.attachments objectAtIndex:i];
             NSData *attachmentData = attachment.attachmentData;
             NSString *mimetype = attachment.mimeType;
             NSString *filename = [NSString stringWithFormat:@"%@.%@", attachment.fileName, attachment.extension];
             NSString *name = [NSString stringWithFormat:@"files[%@]", filename];
             [formData appendPartWithFileData:attachmentData name:name fileName:filename mimeType:mimetype];
         }
     }
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         successBlock(responseObject);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failureBlock(error);
     }];
    
}

#pragma mark - Setter / Getter Overrides

- (NSString *)baseURL
{
    if (!_baseURL)
    {
        self.baseURL = [NSString stringWithFormat: @"%@%@",sgDomain, sgEndpoint];
    }
    
    return _baseURL;
}

@end
