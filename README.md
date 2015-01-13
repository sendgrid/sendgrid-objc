# SendGrid-Objc
* We will be dropping support for this lib due possible security concerns of applications being decompiled. Please only use in backend code. 

This library allows you to quickly and easily send emails through SendGrid using Objective-C.

**Important:** This library requires [AFNetworking](https://github.com/AFNetworking/AFNetworking/wiki/Getting-Started-with-AFNetworking) 2.0 or higher.


```objective-c
SendGrid *sendgrid = [SendGrid apiUser:@"username" apiKey:@"password"];   

SendGridEmail *email = [[SendGridEmail alloc] init];
email.to = @"example@example.com";
email.from = @"other@example.com";
email.subject = @"Hello World";   
email.html = @"<h1>My first email through SendGrid</h1>";
email.text = @"My first email through SendGrid";

[sendgrid sendWithWeb:email];
```


## Installation

Choose your installation method - CocoaPods (recommended) or source.

### Installation via CocoaPods (Recommended Method)
[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like SendGrid and its dependencies in your projects. Simply add the lines below to your existing Podfile or make a new 'Podfile' that contain the lines below. 

#### Podfile

```ruby
platform :ios, '7.0'
pod 'SendGrid', '~>  0.2.6'
```

Run the following in the command line:

```
pod install
```

Be sure to open up the .xcworkspace file now instead of the .xcodeproj file. 

Then import the library - in the file appropriate to your project.

```objective-c
import <SendGrid/SendGrid.h>
```

### Alternative installation
Install via Source

    1. Clone this repository.
    2. Copy SendGrid.h and .m files to your project.
    3. Clone the [SMTPAPI repository](https://github.com/heitortsergent/smtpapi-ios).
    4. Copy SMTPAPI.h and .m files to your project.
    5. Import SendGrid.h in the file appropriate to your project, and AFNetworking in your project.

## Demo App

There's a demo app on the [Github repository](https://github.com/sendgrid/sendgrid-objc), inside the folder "Demo". It's a simple application that lets you send an email, with an Image Picker if you want to send a picture attachment with it.

To run the demo, clone the repository (it's not available when you install via CocoaPods), open the terminal and go to the demo folder. Then do:

```
pod install
open Demo.xcworkspace
```

## Usage

To begin using this library, import the library into your project.

```objective-c
#import <SendGrid/SendGrid.h>
#import <SendGrid/SendGridEmail.h>
```

Create a new SendGrid object with your SendGrid credentials.

```objective-c
SendGrid *sendgrid = [SendGrid apiUser:@"username" apiKey:@"password"];
```

Create a new SendGridEmail object, and customize the parameters of your message.

```objective-c
SendGridEmail *email = [[SendGridEmail alloc] init];
email.to = @"example@example.com";
email.from = @"other@example.com";
email.subject = @"Hello World";   
email.html = @"<h1>My first email through SendGrid</h1>";
email.text = @"My first email through SendGrid";
```

Send it.

```objective-c
[sendgrid sendWithWeb:email];
```
#### Swift
```swift
let sendgrid:SendGrid = SendGrid(apiUser: "username", apiKey: "password")
let email:SendGridEmail = SendGridEmail()
email.to = "example@example.com";
email.from = "other@example.com";
email.subject = "Hello World";
email.html = "<h1>My first email through SendGrid</h1>";
email.text = "My first email through SendGrid";
            
sendgrid.sendWithWeb(email)
```

#### addTo

You can add one or multiple TO addresses using `addTo`.

```objective-c
[email addTo:@"foo@example.com"];
[email addTo:@"bar@example.com"];
```

#### setTos

```objective-c
[email setTos:@[@"foo@example.com", @"bar@example.com"]];
```

#### addBcc

```objective-c
[email addBcc:@"foo@example.com"];
```

#### setFrom

```objective-c
[email setFrom:@"other@example.com"];
```

#### setFromName

```objective-c
[email setFromName:@"Other Dude"];
```

#### setReplyTo

```objective-c
[email setReplyTo:@"no-reply@nowhere.com"];
```

#### setSubject

```objective-c
[email setSubject:@"Hello World"];
```

#### setText

```objective-c
[email setText:@"This is some text of the email."];
```

#### setHtml

```objective-c
[email setHtml:@"<h1>My first email through SendGrid"];
```

#### addSubstitution

```objective-c
[email addSubstitution:@"key" val:@"value"];
```

#### addUniqueArg

```objective-c
[email addUniqueArg:@"key" val:@"value"];
```

#### addCategory

```objective-c
[email addCategory:@"category"];
```

#### addSection

```objective-c
[email addSection:@"key" val:@"value"];
```

#### addFilter

```objective-c
[email addFilter:@"filter" setting:@"setting" val:@"value"];
[email addFilter:@"filter" settings:@"setting" val:1];
```

### Adding an image attachment

#### attachImage

You can add an image attachment to your email message. The method accepts a UIImage. 

```objective-c
[email attachImage:self.photo];
```

**Displaying attached image inline**
```objective-c
email.inlinePhoto = true;
email.html = @"<img src =\"cid:image0.png\"><h1>hello world</h1>";
```

#### attachFile

```objective-c
UIImage *sendgridLogo = [UIImage imageNamed:@"sendgrid_logo.png"];

SendGridEmailAttachment* someImageAttachment = [[SendGridEmailAttachment alloc] init];
someImageAttachment.attachmentData = UIImagePNGRepresentation(sendgridLogo);
someImageAttachment.mimeType = @"image/png";
someImageAttachment.fileName = @"sendgrid_logo";
someImageAttachment.extension = @"png";

[email attachFile:someImageAttachment];
```

## [X-SMTPAPI](http://sendgrid.com/docs/API_Reference/SMTP_API/index.html)

This library uses the SMTPAPI object which is found in [SMTPAPI-iOS](https://github.com/heitortsergent/smtpapi-ios).

### [Substitutions](http://sendgrid.com/docs/API_Reference/SMTP_API/substitution_tags.html)

#### addSubstitution

```objective-c
[header addSubstitution:@"key" val:@"value"];

NSMutableDictionary *subs = [header getSubstitutions];
```

### [Unique Arguments](http://sendgrid.com/docs/API_Reference/SMTP_API/unique_arguments.html)

#### addUniqueArg

```objective-c
[header addUniqueArg:@"key" val:@"value"];
[header addUniqueArg:@"key2" val:@"value2"];

NSMutableDictionary *args = [header getUniqueArgs];
```

#### setUniqueArgs

```objective-c
NSMutableDictionary *uniqueArgs = [[NSMutableDictionary alloc] init];
[uniqueArgs setObject:@"value" forKey:@"unique"];
[header setUniqueArgs:uniqueArgs];

NSMutableDictionary *args = [header getUniqueArgs];
```

### [Categories](http://sendgrid.com/docs/API_Reference/SMTP_API/categories.html)

#### addCategory

```objective-c
[header addCategory:@"category1"];
[header addCategory:@"category2"];

NSMutableArray *cats = [header getCategories];
```

#### addCategories

```objective-c
[header addCategories:@[@"category1", @"category2"]];

NSMutableArray *cats = [header getCategories];
```

#### setCategories

```objective-c
[header setCategories:@[@"category1", @"category2"]];

NSMutableArray *cats = [header getCategories];
```

### [Sections](http://sendgrid.com/docs/API_Reference/SMTP_API/section_tags.html)

#### addSection

```objective-c
[header addSection:@"key" val:@"section"];

NSMutableDictionary *sections = [header getSections];
```

#### setSections

```objective-c
NSMutableDictionary *newSec = [[NSMutableDictionary alloc] init];
[newSec setObject:@"value" forKey:@"-section-"];
[header setSections:newSec];

NSMutableDictionary *sections = [header getSections];
```

### [Filters](http://sendgrid.com/docs/API_Reference/SMTP_API/apps.html)

#### addFilter

```objective-c
[header addFilter:@"filter" setting:@"setting" val:@"value"];
[header addFilter:@"filter" settings:@"setting" val:1];

NSMutableDictionary *filters = [header getFilters];
```

### Get Headers

```objective-c
[header configureHeader];
NSString *headers = header.encodedHeader;
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Licensed under the MIT License.
