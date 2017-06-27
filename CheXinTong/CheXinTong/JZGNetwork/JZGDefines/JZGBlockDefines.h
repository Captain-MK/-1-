//
//  JZGBlockDefines.h
//  JZGERP
//
//  Created by jzg on 16/6/24.
//  Copyright © 2016年 jzg. All rights reserved.
//

#ifndef JZGBlockDefines_h
#define JZGBlockDefines_h

/**
 *  进入app的block
 */
typedef void (^loginEnterApp) ();

/**
 *  自定义选项卡的Block
 *
 *  @param index index 
 */
typedef void (^segmentSelect) (int index);


typedef void (^cityDitailBlock)(NSString *cityDitail);

typedef void (^cityAndChengshiBlock)(NSDictionary *cityData,NSDictionary *chegnshiData);

typedef void (^infocityDitailBlock)(NSDictionary *cityDitail);

typedef void (^carInfoBlock)(NSDictionary *carInfo);

typedef void (^selectGuWenBlock)(void);

#endif /* JZGBlockDefines_h */
