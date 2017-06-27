




typedef NS_ENUM(NSInteger, RequestType){
    REQUEST_REFRESH = 1,    //下拉刷新请求数据
    OPERATE_LOADINGMORE = 2 //上拉加载更多请求数据
};


typedef NS_ENUM(NSUInteger, PLHaveRefreshSourceType){
    PLHaveRefreshSourceTypeAll,     // 默认显示下拉刷新和上拉加载更多
    PLHaveRefreshSourceTypeHeader,  // 只显示下拉刷新
    PLHaveRefreshSourceTypeFooter,  // 只显示上拉加载更多
    PLHaveRefreshSourceTypeNone     // 都不显示
};

//检测列表类型
typedef NS_ENUM(NSInteger, JZGDetectionListType){
    JZGDetectionListForDetecting,    //待检测
    JZGDetectionListForDetected      //已检测
};


//任务操作类型
typedef NS_ENUM(NSInteger, JZGTaskOperateType){
    JZGTaskOperateTypeConfirm,    //任务确认
    JZGTaskOperateTypeReturn      //任务退回
};


//进入检测的类型
typedef NS_ENUM(NSUInteger,JZG_FOLLOW_TYPE){
    JZG_FOLLOW_TYPE_FOLLOW,     //跟进
    JZG_FOLLOW_TYPE_PLANE,  // 安排进度
    JZG_FOLLOW_TYPE_CUSTOM,  // 客户到店
};

//客户
typedef NS_ENUM(NSUInteger,JZG_CUSTOMER_TYPE){
    JZG_CUSTOMER_TYPE_YIXIANG = 1,  //意向
    JZG_CUSTOMER_TYPE_YUDING =2,      // 预定
    JZG_CUSTOMER_TYPE_CHENGJIAO=3,    // 成交
    JZG_CUSTOMER_TYPE_ZHANBAI = 4,      //战败
};


//客户类型
typedef NS_ENUM(NSUInteger,JZGCustomerType){
    JZGCustomerTypeIntention    = 1,  // 意向客户
    JZGCustomerTypeBooking      = 2,  // 预订客户
    JZGCustomerTypeTransaction  = 3,  // 成交客户
    JZGCustomerTypeDefeat       = 4,  // 战败客户
};


//待办事项类型
typedef NS_ENUM(NSUInteger,JZGWaitDoneItemsType){
    JZGWaitDoneItemsTypeToday,  // 当天待办事项
    JZGWaitDoneItemsTypeAll,    // 全部待办事项
};


//待办事项类型
typedef NS_ENUM(NSUInteger,JZGSPBottomType){
    JZGSPBottomTypePingGuPrice,  // 本次评估价格
    JZGSPBottomTypeHistory,    // 历史记录
    JZGSPBottomTypeBigData,  //评估大数据
};


//外观
typedef NS_ENUM(NSUInteger,JZGSPWaiGuanType){
    JZGSPWaiGuanTypeOne,  // 本次评估价格
    JZGSPWaiGuanTypeTwo,    // 历史记录
    JZGSPWaiGuanTypeThree,  //评估大数据
    JZGSPWaiGuanTypeFour,
};

typedef NS_ENUM(NSUInteger,JZGSPCustomType){
    JZGSPCustomType_Customer = 1,  // 个人
    JZGSPCustomType_Company = 2,    // 公司
};

//置换用户类型
typedef NS_ENUM(NSUInteger,JZGZHCustomerType){
    JZGZHCustomerTypeOne = 1,  // 线索
    JZGZHCustomerTypeTwo,    // 客户
    JZGZHCustomerTypeThree,  //无效
};
