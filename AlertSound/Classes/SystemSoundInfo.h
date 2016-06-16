//
//  SystemSoundInfo.h
//  AlertSound
//
//  Created by LV on 16/6/16.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemSoundInfo : NSObject
@property (nonatomic, assign) UInt32   soundID;
@property (nonatomic, strong) NSURL    * soundUrl;
@property (nonatomic, strong) NSString * soundName;
@end
