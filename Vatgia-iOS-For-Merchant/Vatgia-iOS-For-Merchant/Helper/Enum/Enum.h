//
//  Enum.h
//  vatgia
//
//  Created by Pham Duc Giam on 03/08/15.
//  Copyright (c) 2015 maGicuD. All rights reserved.
//

#ifndef vatgia_Enum_h
#define vatgia_Enum_h

typedef NS_ENUM(NSInteger, MenuType) {
    kMenuNone,
    kMenuHome,
    kMenuOrder,
    kMenuHistory,
    kMenuSupport,
    kMenuHelp,
    kMenuCategories,
    kMenuEvent,
    kMenuTermOfUse,
    kMenuIntroduce,
    kMenuVersion,
    kMenuRatingApp,
    kMenuLogout,
    kMenuHistoryChat,
    kMenuMyOrders,
    kMenuBuyerOrders,
    kMenuNotification,
    kMenuLikedProducts,
    kMenuLikedEstores
};

typedef NS_ENUM(NSInteger, ProductType) {
    kProductNone,
    kHotProduct,
    kNewProduct,
    kPremiumProduct,
    kFashionProduct,
    kPromotionProduct,
    kSSGRelatedProduct,
    kViewedProduct,
    kSameEstoreProduct,
    kAccessoriesProduct,
    kLikedProducts,
    kDealProduct,
    kCategoryEventProduct,
    kCategoryTopNewProduct,
    kCategoryBestSellerProduct,
    kSuggestForOutOfStockProduct,
    kSearchRelatedProduct,
    kEstoreLocationProduct,
    kLocationProductTop,
    kTopTechnologyProduct,
    kTopFashionProduct,
    kTopWeekFashionProduct,
    kTopMonthFashionProduct,
    kTodayPromotionFashionProduct,
    kPromotionFashionProduct,
    kCategoryGroupProduct,
    kTopFollowProduct,
    kBestSellerProduct,
    kSuggestForYou,
    kRecommentedProductsForProduct,
    kSSGSimilarProduct,
    kHomeTopSaleOffProduct,
    kHomeTopSellProduct,
    kHomeTopSellerProduct,
    kHomeTopPremiumProduct,
    kDealHotProducts,
    kDealNewProducts,
    KNewProductUp
};

typedef NS_ENUM(NSInteger, SearchSortType) {
    kSearchSortNone,
    kSearchSortPriceAsc = 3,
    kSearchSortPriceDesc = 4,
    kSearchSortHot = 5
};

typedef NS_ENUM(NSInteger, LoginType) {
    kLoginNone,
    kLoginCredential,
    kLoginFacebook,
    kLoginGoogle
};

typedef NS_ENUM(NSInteger, AutocompleteType) {
    kAutocompleteNone,
    kAutocompleteHistory,
    kAutocompleteSuggest,
    kAutocompleteCategories,
    kAutocompleteDeal
};

typedef NS_ENUM(NSInteger, NotFoundType) {
    kNotFoundNone = 0,
    kNotFoundProduct = 0x10000000,
    kNotFoundCategory = kNotFoundProduct | 0x1,
    kNotFoundSearch = kNotFoundProduct | 0x10,
    kNotFoundProductViewed = kNotFoundProduct | 0x100,
    kNotFoundNotification = 0x1000000,
    kNotFoundOrderNotification = kNotFoundNotification | 0x1000,
    kNotFoundChat = kNotFoundNotification | 0x10000,
    kNotFoundNotificationRequirementLogin = 0x10,
    kNotFoundChatRequirementLogin = 111
};

typedef NS_ENUM(NSInteger, GuideSwipeType) {
    kGuideSwipeImage = 0,
    kGuideSwipeDismissController = 1
};

typedef NS_ENUM(NSInteger, NotificationType) {
    kNotificationNone,
    kNotificationPromotion,
    kNotificationSellerOrder,
    kNotificationBuyerOrder,
    kNotificationFavourite,
    kNotificationOrder
};

typedef NS_ENUM(NSInteger, ProductStockStatus) {
    kProductStockNone,
    kProductOutOfStock,
    kProductInStock
};

//typedef NS_ENUM(NSInteger, ActionType) {
//    kActionNone,
//    kActionChat,
//    kActionViewedProduct,
//    kActionLikedProduct,
//    kActionCreateProduct
//};

typedef NS_ENUM(NSInteger, PolicyType) {
    kPolicyNone,
    kPolicyReturnProduct,
    kPolicyReturnMoney,
    kPolicyUpdateOrder,
    kPolicyPayment,
    kPolicyShakeToReport
};

typedef NS_ENUM(NSInteger, ProductDisplayType) {
    kProductDisplayNone = 0,
    kProductDisplay1Column = 1,
    kProductDisplay2Columns = 2,
    kProductDisplay3Columns = 4
};

typedef NS_ENUM(NSInteger, ProductsDisplayType) {
    kProductsDisplaySingle,
    kProductsDisplayCollection,
    kProductsDisplayCustom,
};

typedef NS_ENUM(NSInteger, OrderType) {
    kOrderNone,
    kOrderMine,
    kOrderBuyer
};

typedef NS_ENUM(NSInteger, OrderAction) {
    kOrderActionNone,
    kOrderOpenDetail,
    kOrderCancel
};

typedef NS_ENUM(NSInteger, HelpType) {
    kHelpMain,
    kHelpPolicy
};

typedef NS_ENUM(NSInteger, CategoryFilterType) {
    kCategoryFilterNone,
    kCategoryNormalFilter,
    kCategoryPromotionFilter,
    kCategoryHomeFilter
};

typedef NS_ENUM(NSInteger, ReportType) {
    kReportNone,
    kReportWrongPrice,
    kReportOutOfStock
};

typedef NS_ENUM(NSInteger, CommentOrderType) {
    kCommentOrderNone,
    kCommentOrderAll,
    kCommentOrderGood,
    kCommentOrderNormal,
    kCommentOrderBad
};

typedef NS_ENUM(NSInteger, ProductEstoresType) {
    kProductEstoresNone,
    kProductEstoresAll,
    kProductEstoresNew,
    kProductEstoresOld,
};

typedef NS_ENUM(NSInteger, ButtonBarType) {
    kButtonBarNone,
    kButtonBarOrderComment,
    kButtonBarProductEstores,
    kButtonBarProductCategory,
    kButtonBarProductNoti,
    kButtonBarHybridProduct,
    
};

typedef NS_ENUM(NSInteger, FilterType) {
    kFilterNone,
    kFilterForSearch,
    kFilterForCategory,
    kFilterForEstore
};

typedef NS_ENUM(NSInteger, ManageProductType) {
    kOutOfDate = 1,
    kExpireDate = 2,
    kWaitApprove = 3,
    kWarningQuantity = 4,
    kDisapprove = 5,
    kWarningPrice = 6,
    kAvailable = 7,
    kOutOfStock = 8,
    kPromotion = 9,
    kAll = 10,
};

typedef NS_ENUM(NSInteger, ManageProductInformationCellType) {
    kCellTypeName = 1,
    kCellTypePrice = 2,
    kCellTypeSizeColor= 3,
    kCellTypeQualify = 4,
    kCellTypeWarranty = 5,
    kCellTypeOrigin = 6,
    kCellTypeWeight = 7,
    kCellTypePromotion = 8,
};

typedef NS_ENUM(NSInteger, CategoryDisplayType) {
    kTypeNewProducts = 1,
    kTypeBestSeller = 2,
    kTypeSaleUp= 3,
    kTypeNearBy = 4,

};
#endif
