//
//  CBTPeripheral.m
//  BlueTooth
//
//  Created by yryz on 2020/1/6.
//  Copyright © 2020 com.yryz.qiyun. All rights reserved.
//

#import "CBTPeripheral.h"

@interface CBTPeripheral () <CBPeripheralDelegate>

@end

@implementation CBTPeripheral

- (id)initWithPeripheral:(CBPeripheral *)peripheral {
    if (self = [super init]) {
        self.peripheral = peripheral;
        self.peripheral.delegate = self;
    }
    return self;
}


+ (instancetype)initWithPeripheral:(CBPeripheral *)peripheral {
    CBTPeripheral *mPeripheral = [[CBTPeripheral alloc] init];
    return mPeripheral;
}

#pragma mark    -   CBPeripheralDelegate


- (void)peripheralDidUpdateName:(CBPeripheral *)peripheral NS_AVAILABLE(10_9, 6_0) {
    NSLog(@"peripheral -->   did update");
}


- (void)peripheral:(CBPeripheral *)peripheral didModifyServices:(NSArray<CBService *> *)invalidatedServices NS_AVAILABLE(10_9, 7_0) {
    NSLog(@"peripheral -->   did modify = %@", invalidatedServices);
}



- (void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(nullable NSError *)error NS_AVAILABLE(10_13, 8_0) {
    NSLog(@"peripheral -->   did read RSSI = %@, error = %@", RSSI, error);
}


- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error {
    NSLog(@"peripheral -->   did discover services, error = %@", error);
    
    if (!error) {
        for (CBService *service in peripheral.services) {
            // 根据GATT (Generic Attribute Profile) 服务获取特征值
            [peripheral discoverCharacteristics:nil forService:service];
            
            // @example <CBService: 0x2825203c0, isPrimary = YES, UUID = 7798082B-B7B7-45A6-9933-563492EFE04E>, characteristics = (null)
            NSLog(@" -->  service = %@", service);
            if (self.delegate && [self.delegate respondsToSelector:@selector(peripheral:didDiscoverPeripheralService:)]) {
                [self.delegate peripheral:self didDiscoverPeripheralService:service];
            }
        }
    }
}


- (void)peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(nullable NSError *)error {
    NSLog(@"peripheral -->   did discover included services = %@, error = %@", service, error);
}


- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error {
    NSLog(@"peripheral -->   did discover characteristics services = %@, error = %@", service, error);
    
    if (!error) {
         for (CBCharacteristic *cha in service.characteristics) {
               if(cha.properties & CBCharacteristicPropertyWrite){
                   NSLog(@"peripheral -->   CBCharacteristicPropertyWrite");
                   NSLog(@"peripheral -->   %lu",cha.properties & CBCharacteristicPropertyWrite);

               }else if(cha.properties & CBCharacteristicPropertyWriteWithoutResponse){
                   NSLog(@"peripheral -->   CBCharacteristicPropertyWriteWithoutResponse");
               }else if(cha.properties & CBCharacteristicPropertyRead){
                   NSLog(@"peripheral -->   CBCharacteristicPropertyRead");
               }else if(cha.properties & CBCharacteristicPropertyNotify){
                   NSLog(@"peripheral -->   CBCharacteristicPropertyNotify");
               }else if(cha.properties & CBCharacteristicPropertyIndicate){
                   NSLog(@"peripheral -->   CBCharacteristicPropertyIndicate");
               }
               NSLog(@"peripheral -->   设备获取特征成功，服务名：%@，特征值名：%@，特征UUID：%@，特征数量：%lu",service,cha,cha.UUID,service.characteristics.count);
               //获取特征对应的描述 会回调didDiscoverDescriptorsForCharacteristic
               [peripheral discoverDescriptorsForCharacteristic:cha];
             
               //获取特征的值 会回调didUpdateValueForCharacteristic
               [peripheral readValueForCharacteristic:cha];
           }
    }
}


- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSString *value = [[NSString alloc] initWithData:characteristic.value encoding:NSASCIIStringEncoding];
    NSLog(@"特征名：%@，特征值：%@", characteristic, value);
}


- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    
}


- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    
}


- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    
}


- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(nullable NSError *)error {
    
}


- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(nullable NSError *)error {
    
}


- (void)peripheralIsReadyToSendWriteWithoutResponse:(CBPeripheral *)peripheral {
    
}


- (void)peripheral:(CBPeripheral *)peripheral didOpenL2CAPChannel:(nullable CBL2CAPChannel *)channel error:(nullable NSError *)error {
    
}


@end
