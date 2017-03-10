//
//  GenearteAccessToken.m
//  EmployeeMonitoringSystem
//
//  Created by Sumit Ghosh on 08/02/16.
//  Copyright © 2016 Globussoft. All rights reserved.
//

#import "GenearteAccessToken.h"
#import <CommonCrypto/CommonCrypto.h>
#import "NSData+AES.h"
#import "AESCrypt.h"



@implementation GenearteAccessToken


-(NSString*)generateAccessTok:(NSString*)params{
    
  //  NSString *message = params;
    NSString *password = @"Globus7879";

   NSString *encryptedData = [AESCrypt encrypt:params password:password];
    return encryptedData;


}
-(NSString*)decrypt:(NSString*)params{
      NSString *password = @"Globus7879";
    NSString *decrypt=[AESCrypt decrypt:params password:password];
    return decrypt;
}


-(NSData*)encrypt:(NSString*)params{
    NSString *password = @"Globus7879";
    
    NSData (*AES128) =[[NSData alloc]init];
    
    return   [AES128 AES128EncryptedDataWithKey:password iv:params];
    
    
}

//
//- (NSData *)AES128DecryptedDataWithKey:(NSString *)key
//{
//    return [self AES128DecryptedDataWithKey:key iv:nil];
//}
//
//- (NSData *)AES128EncryptedDataWithKey:(NSString *)key iv:(NSString *)iv
//{
//    return [self AES128Operation:kCCEncrypt key:key iv:iv];
//}
//
//- (NSData *)AES128DecryptedDataWithKey:(NSString *)key iv:(NSString *)iv
//{
//    return [self AES128Operation:kCCDecrypt key:key iv:iv];
//}
//
//- (NSData *)AES128Operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv
//{
//    char keyPtr[kCCKeySizeAES128 + 1];
//    bzero(keyPtr, sizeof(keyPtr));
//    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//    
//    char ivPtr[kCCBlockSizeAES128 + 1];
//    bzero(ivPtr, sizeof(ivPtr));
//    if (iv) {
//        [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
//    }
//    
//    NSUInteger dataLength = [self length];
//    size_t bufferSize = dataLength + kCCBlockSizeAES128;
//    void *buffer = malloc(bufferSize);
//    
//    size_t numBytesEncrypted = 0;
//    CCCryptorStatus cryptStatus = CCCrypt(operation,
//                                          kCCAlgorithmAES128,
//                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
//                                          keyPtr,
//                                          kCCBlockSizeAES128,
//                                          ivPtr,
//                                          [self bytes],
//                                          dataLength,
//                                          buffer,
//                                          bufferSize,
//                                          &numBytesEncrypted);
//    if (cryptStatus == kCCSuccess) {
//        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
//    }
//    free(buffer);
//    return nil;
//}



@end
