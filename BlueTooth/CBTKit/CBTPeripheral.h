//
//  CBTPeripheral.h
//  BlueTooth
//
//  Created by yryz on 2020/1/6.
//  Copyright © 2020 com.yryz.qiyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@class CBTPeripheral;
@protocol CBTPeripheralDelegate <NSObject>

- (void)peripheral:(CBTPeripheral *)peripheral didDiscoverPeripheralService:(CBService *)sevice;

@end


@interface CBTPeripheral : NSObject


// 初始化
- (id)initWithPeripheral:(CBPeripheral *)peripheral;
+ (instancetype)initWithPeripheral:(nullable CBPeripheral *)peripheral;


// 当前存储的外设
@property (strong, nonatomic) CBPeripheral *peripheral;

// 代理
@property (weak, nonatomic) id <CBTPeripheralDelegate> delegate;

// 已连接外设的所有服务
@property (strong, nonatomic) NSMutableArray <CBService *> *services;

// 特征值
@property (strong, nonatomic) CBCharacteristic *writeCharacteristic;

// 写入最大字节长度, 默认写入无响应
@property (assign, nonatomic, getter=getSupportWriteMaximumLength) NSInteger supportWriteMaximumLength;


/*!
 *  @method getMaximumWriteDataOfLengthForStatus:
 *
 *  @param withoutResponse    是否写入且无响应状态
 *
 *  @discussion     获取当前写入最大字节长度
 *
 */
- (NSInteger)getMaximumWriteDataOfLengthForStatus:(BOOL)withoutResponse;


/*!
 *  @method writeData:withoutResponse:
 *
 *  @param data    需要写入的数据
 *
 *  @param withoutResponse    是否写入且无响应状态
 *
 *  @discussion     写入自定义数据，限制长度且写入的数据会传递给当前连接的对象
 *
 */
- (void)writeData:(NSString *)data withoutResponse:(BOOL)withoutResponse;

@end

NS_ASSUME_NONNULL_END
