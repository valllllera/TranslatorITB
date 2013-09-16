#import <UIKit/UIKit.h>

#define FtpUrl @"mlb.ftp.ukraine.com.ua/TranslatorTest"
#define FtpLogin @"mlb_ftp"
#define FtpPassword @"v16071997"

@interface PutController : NSObject 

@property (nonatomic, strong) NSString * status;

- (void)sendAction;
- (void)cancelAction;

@end
