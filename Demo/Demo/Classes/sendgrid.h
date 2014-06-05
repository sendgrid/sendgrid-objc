//
//  sendgrid.h


#import <Foundation/Foundation.h>

@interface sendgrid : NSObject

@property (nonatomic, strong) NSString *apiUser;
@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSString *to;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *html;
@property (nonatomic, strong) NSString *xsmtpapi;
@property (nonatomic, strong) NSString *bcc;
@property (nonatomic, strong) NSMutableArray *imgs;
@property (nonatomic, strong) NSArray *tolist;
@property (nonatomic, strong) NSString *toName;
@property (nonatomic, strong) NSString *fromName;
@property (nonatomic, strong) NSString *replyto;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) BOOL inlinePhoto;
@property (nonatomic, strong) NSMutableDictionary *headers;


+ (instancetype)user:(NSString *)apiUser andPass:(NSString *)apiKey;
-(id)initWithUser:(NSString *)apiUser andPass:(NSString *)apiKey;
- (void)addCustomHeader:(id)value withKey:(id)key;
- (void)attachImage:(UIImage *)img;
- (NSString *)headerEncode:(NSDictionary *)header;
- (void)sendWithWeb;
- (void)sendWithWebUsingSuccessBlock:(void(^)(id responseObject))successBlock failureBlock:(void(^)(NSError *error))failureBlock;

@end
