/**
 http://mythosil.hatenablog.com/entry/20111017/1318873155
 http://blog.dealforest.net/2012/03/ios-android-per-aes-crypt-connection/
 */

@interface NSData (AES256)

- (NSData *)AES128EncryptedDataWithKey:(NSString *)key;
- (NSData *)AES128DecryptedDataWithKey:(NSString *)key;
- (NSData *)AES128EncryptedDataWithKey:(NSString *)key iv:(NSString *)iv;
- (NSData *)AES128DecryptedDataWithKey:(NSString *)key iv:(NSString *)iv;
- (NSData *)AES256EncryptWithKey:(NSString *)key iv:(NSString *)iv;
- (NSData *)AES128EncryptedDataWithKey:(NSString *)key body:(NSString*)body;
@end