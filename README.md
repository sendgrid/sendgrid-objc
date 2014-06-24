# SendGrid-iOS

This library allows you to quickly and easily send emails through SendGrid using Objective-C.

**Important:** This library requires [AFNetworking](https://github.com/AFNetworking/AFNetworking/wiki/Getting-Started-with-AFNetworking) 2.0 or higher.


```objective-c
SendGrid *sendgrid = [SendGrid apiUser:@"username" apiKey:@"password"];   

Email *email = [[Email alloc] init];
email.to = @"foo@bar.com";
email.subject = @"subject goes here";
email.from = @"me@bar.com";
email.text = @"hello world";   
email.html = @"<h1>hello world!</h1>";
    
[sendgrid sendWithWeb:email];    
```

## Installation via CocoaPods (Recommended Method)
[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like SendGrid and its dependencies in your projects. Simply add the lines below to your existing Podfile or make a new 'Podfile' that contain the lines below. 

#### Podfile

```ruby
platform :ios, '7.0'
pod 'sendgrid', '~>  0.1.0'
```

Run the following in the command line
```
pod install
```

Be sure to open up the .xcworkspace file now instead of the .xcodeproj file. 

## Alternative installation
Install via Source

    1. Clone this repository.
    2. Copy SendGrid.h and .m, and Email.h and .m files to your project.
    3. Import both SendGrid and AFNetworking in your project

## Usage

To begin using this library, create a new SendGrid object with your SendGrid credentials.
```objective-c
SendGrid *sendgrid = [SendGrid apiUser:@"username" apiKey:@"password"];
```

Create a new Email object, and customize the parameters of your message.
```objective-c
Email *email = [[Email alloc] init];
email.to = @"foo1@bar.com";
email.subject = @"subject goes here";
email.from = @"me@bar.com";
email.text = @"hello world";   
email.html = @"<h1>hello world!</h1>";
```
For the full list of available parameters, check out the [Docs](http://sendgrid.com/docs/API_Reference/Web_API/mail.html)

### Adding To addresses

You can add a single address using the to property of the mail object

```objective-c
email.to = @"foo@bar.com";
```

Or

You can add multiple To addresses by setting the toList property

```objective-c
email.tolist = @[@"foo1@bar.com", @"foo2@bar.com"];
```
**Note:** One or the other must be set.

### Adding an image attachment
You can add an image attachment to your email message. The method accepts a UIImage. 

```objective-c
[email attachImage:self.photo];
```

**Displaying attached image inline**
```objective-c
email.inlinePhoto = true;
email.html = @"<img src =\"cid:image0.png\"><h1>hello world</h1>";
```

### Adding custom headers

You can set custom headers in your email by using the addCustomHeader:withKey method. 

**Adding Categories**
```objective-c
NSString *cat = @"billing_notifications";
[email addCustomHeader:cat withKey:@"category"];
```

**Adding Unique Arguments**
```objective-c
NSDictionary *uarg = @{@"customerAccountNumber":@"55555",
                           @"activationAttempt": @"1"};

[email addCustomHeader:uarg withKey:@"unique_args"];
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

