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

+ (instancetype)user:(NSString *)apiUser andPass:(NSString *)apiKey{
    //public method that creates the mail object and returns that object
    
    SendGrid *message = [[SendGrid alloc] initWithUser:apiUser andPass:apiKey];
    
    return message;
}


-(id)initWithUser:(NSString *)apiUser andPass:(NSString *)apiKey{
    //private method that creates the mail object
    self = [super init];
    if (self) {
        self.apiUser = apiUser;
        self.apiKey =  apiKey;
    }
    return self;
}

- (void)sendWithWeb:(Email *)email
{
    //Uses Web Api to send email
    [email configureHeader];
    
    //Posting Paramters to server using AFNetworking 2.0
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:self.baseURL parameters:[email parametersDictionary:self.apiUser apiKey:self.apiKey] constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //if image attachment exists it will post it
        for (int i = 0; i < email.imgs.count; i++)
        {
            UIImage *img = [email.imgs objectAtIndex:i];
            NSString *filename = [NSString stringWithFormat:@"image%d.png", i];
            NSString *name = [NSString stringWithFormat:@"files[image%d.png]", i];
            NSLog(@"name: %@, Filename: %@", name, filename);
            NSData *imageData = UIImagePNGRepresentation(img);
            [formData appendPartWithFileData:imageData name:name fileName:filename mimeType:@"image/png"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (void)sendWithWebUsingSuccessBlock:(Email *) email successBlock:(void(^)(id responseObject))successBlock failureBlock:(void(^)(NSError *error))failureBlock
{
    [email configureHeader];
    
    //Posting Paramters to server using AFNetworking 2.0
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:self.baseURL parameters:[email parametersDictionary:self.apiUser apiKey:self.apiKey] constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //if image attachment exists it will post it
        for (int i = 0; i < email.imgs.count; i++)
        {
            UIImage *img = [email.imgs objectAtIndex:i];
            NSString *filename = [NSString stringWithFormat:@"image%d.png", i];
            NSString *name = [NSString stringWithFormat:@"files[image%d.png]", i];
            NSLog(@"name: %@, Filename: %@", name, filename);
            NSData *imageData = UIImagePNGRepresentation(img);
            [formData appendPartWithFileData:imageData name:name fileName:filename mimeType:@"image/png"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
    
}

#pragma mark - Setter / Getter Overrides

- (NSString *)baseURL
{
    if (!_baseURL) {
        self.baseURL = [NSString stringWithFormat: @"%@%@",sgDomain, sgEndpoint];
    }
    
    return _baseURL;
}

@end
