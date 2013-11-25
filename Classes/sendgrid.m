//
//  sendgrid.m
//

#import "sendgrid.h"
#import "AFNetworking.h"

NSString * const sgDomain = @"https://api.sendgrid.com/";
NSString * const sgEndpoint = @"api/mail.send.json";

@interface sendgrid ()

@property (strong, nonatomic) NSString *baseURL;

@end

@implementation sendgrid

+ (instancetype)user:(NSString *)apiUser andPass:(NSString *)apiKey{
    //public method that creates the mail object and returns that object
    
    sendgrid *message = [[sendgrid alloc] initWithUser:apiUser andPass:apiKey];
    
    return message;
}


-(id)initWithUser:(NSString *)apiUser andPass:(NSString *)apiKey{
    //private method that creates the mail object
    self = [super init];
    if (self) {
        self.apiUser = apiUser;
        self.apiKey =  apiKey;
        self.headers = [NSMutableDictionary new];
        [self setInlinePhoto:false];
    }
    return self;
}

- (void) attachImage:(UIImage *)img {
    //attaches image to be posted
    self.img = img;
}


- (NSString *)headerEncode:(NSMutableDictionary *)header{
    //Converts NSDictionary of Header arguments to JSON string
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:header
                                                       options:0
                                                         error:&error];
    NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    
    if (!jsonData)
        NSLog(@"JSON error: %@", error);
    
    
    return JSONString;
    
}

- (void)addCustomHeader:(id)value withKey:(id)key{
    //Adds custom header arguments to header dictionary
    
    [self.headers setObject:value forKey:key];
}

- (void)sendWithWeb
{
    
    //Uses Web Api to send email
    [self configureHeader];
    
    //Posting Paramters to server using AFNetworking 2.0
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:self.baseURL parameters:[self parametersDictionary] constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //if image attachment exists it will post it
        if(self.img!=nil)
        {
            NSData *imageData = UIImagePNGRepresentation(self.img);
            [formData appendPartWithFileData:imageData name:@"files[image.png]" fileName:@"image.png" mimeType:@"image/png"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (void)sendWithWebUsingSuccessBlock:(void(^)(id responseObject))successBlock failureBlock:(void(^)(NSError *error))failureBlock
{
    [self configureHeader];
    
    //Posting Paramters to server using AFNetworking 2.0
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:self.baseURL parameters:[self parametersDictionary] constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //if image attachment exists it will post it
        if(self.img!=nil)
        {
            NSData *imageData = UIImagePNGRepresentation(self.img);
            [formData appendPartWithFileData:imageData name:@"files[image.png]" fileName:@"image.png" mimeType:@"image/png"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
    
}

#pragma mark - Private Methods

- (void)configureHeader
{
    //Items to add to Header and convert to json
    if(self.tolist !=nil){
        [self.headers setObject:self.tolist forKey:@"to"];
        self.to=[self.tolist objectAtIndex:0];
    }
    
    
    if(self.headers !=nil)
        self.xsmtpapi = [self headerEncode:self.headers];
}

- (NSDictionary *)parametersDictionary
{
    //Building up Parameter Dictionary
    NSMutableDictionary *parameters =[NSMutableDictionary dictionaryWithDictionary:@{@"api_user": self.apiUser,
                                                                                     @"api_key": self.apiKey, //required
                                                                                     @"subject":self.subject, //required
                                                                                     @"from":self.from,       //required
                                                                                     @"html":self.html,       //required
                                                                                     @"to":self.to,           //required
                                                                                     @"text":self.text,       //required
                                                                                     @"x-smtpapi":self.xsmtpapi
                                                                                     }];
    
    
    //optional parameters
    if(self.bcc != nil)
        [parameters setObject:self.bcc forKey:@"bcc"];
    
    if(self.toName != nil)
        [parameters setObject:self.toName forKey:@"toname"];
    
    if(self.fromName != nil)
        [parameters setObject:self.fromName forKey:@"fromname"];
    
    if(self.replyto != nil)
        [parameters setObject:self.replyto forKey:@"replyto"];
    
    if(self.date != nil)
        [parameters setObject:self.date forKey:@"date"];
    
    if(self.inlinePhoto)
        [parameters setObject:@"image.png" forKey:@"content[image.png]"];
    
    
    return parameters;
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
