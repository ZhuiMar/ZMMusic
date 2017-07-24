//
//  Host.swift

//
//  Created by 魏翔 on 16/6/21.
//  Copyright © 2016年 魏翔. All rights reserved.
//

import Foundation


#if  true
    
    let BaseURL = "https://www.weilingtou.com/buddhism/"
    
#else

 // let BaseURL = "http://test.muyusay.com/buddhism/"
    let BaseURL = "http://advance.muyusay.com/buddhism/"
    
#endif

// MARK: 拼接地址
extension String {
    var completeURL: String { return BaseURL + self }
}

// MARK: 公共模块
let APP_Follow = "follow/follow"                                        //关注
let APP_cancelFollow = "follow/cancelFollow"                            //取消关注
let APP_Like = "common/like"                                            //点赞
let APP_Share = "common/share/"                                         //分享次数统计
let APP_Collection = "collection/collection"                            //收藏
let APP_CancelCollection = "collection/cancelCollection"                //取消收藏
let APP_Single_Upload = "file/fileUpload"                               //单文件上传
let APP_MulFile_Upload = "file/multiFileUpload"                         //多图片上传

// MARK: 评论
let APP_Word_Comment = "comment/commentNew"                            //文本评论
let APP_Audio_Comment = "comment/comment"                               //语音评论
let My_Comments = "question/list/commented"                             //我的评论
//let ComentList_By_Type_And_Id = "comment/getCommentByTypeAndId"         //根据类型和id查找某个对象的评论信息
let ComentList_By_Type_And_Id = "comment/getCommentByTypeAndIdNew"
let Comment_Reply = "comment/replyNew"                                     //根据类型和id查找某个对象的评论信息

// MARK:  研习模块
let Book_List = "book/type"                                             //获取经书列表
let Book_Detail = "book/detail"                                         //获取经书列表
let My_Collection = "question/list/collected"                           //我的收藏

// MARK: 佛音模块
let Music_List = "music/queryMusicListByType"

// MARK: 大师模块
let Master_Hot_List = "master/list/hot"                                 //按热度排列的大师列表
let Master_answered_List = "master/list/hot"                            //按照回答解惑数获取法师列
let Master_time_List = "master/list/time"                               //按照入驻时间获取法师列表
let Master_Temple = "master/temple/"                                    //获取法师所在寺庙详情
let Master_Info = "master/"                                             //获取大师详情

// MARK: 解惑模块
let Question_List = "question/list/all"                                 //获取所有解惑
let Question_Add = "question/add"                                       //获取所有解惑
let Hot_Question_List = "question/list/hot/20/1"                        //按热度排列的解惑列表
let Add_Question = "question/add"                                       //发布问题
let User_Question = "question/asker"                                    //获取用户问题列表
let Ignore_Question = "question/ignore"                                 //忽略问题
let Master_Answered = "question/master"                                 //获取大师已经回答问题列表(0:待回答,1:已回答,2:已忽略)
let Question_Details = "question"                                       //解惑详情

// MARK: 佛友圈
let Friend_Add = "friend/add"
let Friend_Host_List = "friend/list/hot"                                //佛友圈热门列表
let Friend_All_List = "friend/list/all"                                 //佛友圈发现列表
let Friend_Followed_List = "friend/list/followed"                       //佛友圈关注列表
let Personal_Status_List = "friend/group/list"                          //佛友圈关注列表

// 注册登录
let APP_Register = "loginInfo/register"                                 //注册
let APP_Login = "loginInfo/login"                                       //登录
let APP_Phone_Code = "loginInfo/getPhoneCode/"                          //获取短信验证码(注册)
let APP_NewPhoneCode = "common/getCode/"                                //获取短信验证码(绑定手机)
let updateWd = "loginInfo/updatePassword"                               //修改密码
let App_Phone_Check = "loginInfo/checkTel/"                             //校验手机号码是否已经注册
let APP_User_Headher = "/userInfo/upload"                               //校验手机号码是否已经注册
let Find_PassWd = "loginInfo/findPassword"                              //找回密码
let APP_GetUserInfo = "loginInfo/info"                                  //获取个人信息
let APP_UpdateUserInfo = "loginInfo/updateBaseInfo"                     //修改个人信息
let APP_ReommendToFriends = "share/extend.html"                         //推荐好友分享出去的链接
let APP_checkPhoneNO = "loginInfo/checkTel/"                            //校验手机号是否存在
let APP_ChangePhone = "loginInfo/updateTel"                             //更改手机号--也是绑定手机的接口

// MARK: 礼佛-寺庙
let APP_Buddha_Hot = "incense/temple/hot"
let APP_Buddha_All = "incense/temple/all"
let APP_Buddha_Often = "incense/temple/often"
let APP_Buddha_List = "temple/list"

// MARK: 寺庙香火列表
let APP_Buddha_Incense_List = "incense/list"

// MARK: 活动
let APP_Activity_Add = "activity/add"
let APP_Activity_AddNew = "activity/addnew1"                             //发布活动
let APP_Activity_Tag = "activity/tags"
let APP_Activity_Detail = "activity/detail"
let APP_Activity_Join = "activity/join"
let APP_Activity_Hot = "activity/list/hot"
let APP_GetActivityListAsTag = "activity/list/tag"                      //根据标签查询活动
let APP_GetJoinedActivityList = "activity/list/join"                    //报名的活动
let APP_JoinedUserList = "activity/list/joined"                         //报名的活动
let APP_GetCollectedActivityList = "activity/list/collect"              //报名的活动
let APP_GetPublishedActivityList = "activity/list/publish"              //发布的活动
let APP_ActivityList_By_Tag_And_Status = "activity/listByStatusAndTag"  //发布的活动
let APP_MyActivityByStatus = "activity/list/byStatus"                   //寺庙角色-我的活动
let APP_NewActivity = "activity/list/recommend"                         //最新的活动


// MARK: 善筹
let App_Goodraise_List = "crowdFunding/list"                            //按照寺庙id获取善筹
let App_Goodraise_Detail = "crowdFunding/detail/"                       //按照寺庙id获取善筹
let App_Goodraise_Add = "crowdFunding/save"                             //按照寺庙id获取善筹

// MARK: 禅记
let APP_Zenmind_Hot = "zenmind/list/hot"
let APP_Zenmind_All = "zenmind/list/all"
let APP_Zenmind_Activity = "zenmind/list/activity"
let APP_TempleZenmind = "zenmind/list/temple"                           //获取寺院相关禅记
let APP_Zenmind_AddNew = "zenmind/addnew"                               //发布禅记
let APP_Zenmind_Detail = "zenmind/detailnew"                            //获取禅记详情
let APP_ActivityZenmind = "zenmind/list/activity"                       //获取活动相关禅记
let APP_relatedZenmind = "zenmind/relatedZenmind/"                      //根据id查询禅记相似禅记
let APP_AppZenmind = "zenmind/list/recommend"                           //最新的禅记

// MARK: 善行
let APP_Beneficence_Hot = "beneficence/list/hot"
let APP_Beneficence_Time = "beneficence/list/time"


//let APP_Beneficence_Add = "beneficence/add"
let APP_Beneficence_AddNew = "beneficence/addnew"                       //发布善行

//MARK: 认证
let APP_Master_Certify = "id/add/master"                                //大师认证

//MARK: 语音导航
let App_DeleteGuide = "guide/delete/"                                   //POST /guide/delete/{id} 按id删除
let App_VoiceGuideList = "guide/list"                                   //按寺庙id查询列表
let APP_Guide_Detail = "guide/detail"                                   //导览详情
let APP_AddGuide = "guide/add"                                          //添加导览
let APP_Temple_Certify = "id/add/temple"                                //寺庙认证
let APP_Temple_Detail = "temple/detail/"                                //寺庙详情
let APP_TempleListByLocation = "temple/selectByJuli/"                   //根据经纬度距离查找寺庙
let APP_TempleListInfo = "temple/detailByLoginId/"                      //寺庙资料
let APP_TempleListAddress = "area/getAreasInfo"                         //寺庙资料
let APP_TempleInfoUpdate = "temple/update"                              //修改寺庙信息
let APP_TemplePrayRecords = "incense/list/record/temple"                //根据寺庙Id获取礼佛记录
let APP_GoodraiseRecords = "crowdFunding/list/record/funding"           //按照善筹id获取善筹记录
let APP_UserPrayRecords = "incense/list/record/user"                    //根据用户Id获取礼佛记录
let APP_UserGoodraiseRecords = "crowdFunding/list/record/user"          //根据用户Id获取礼佛记录
let APP_TempleGoodraiseRecords = "crowdFunding/list/record/temple"      //按照寺庙id获取善筹记录
let APP_Reveal_List = "home/inspiration/list"                           //开示
let APP_Reveal_By_MasetId = "home/inspiration/list/master"              //根据大师id获取开示列表
let APP_MyFollowListByMaster = "follow/followList/role"                 //我关注の列表(按关注的类型分)
let APP_MyFollowListByTemple = "follow/followList/role"
let APP_MyFollowListByUser = "follow/followList/role"
let APP_MasterListForTemple = "master/from"                             //获取寺庙内法师列表


let APP_Letter_List = "msg/letter"                                      //用户私信
let APP_Letter_Top_List = "msg/topList"                                 //私信一级页面
let APP_Letter_Second_List = "msg/secondList"                           //私信二级页面
let APP_Letter_Add = "msg/letter/add"                                   //私信二级页面
let APP_ThirdPartyLogin = "loginInfo/thirdPartyLogin"                   //第三方登录
let APP_PrayReply = "incense/record/reply"                              //反馈
let APP_AnswerQuestions = "question/reply"                              //回答解惑
let APP_Ingore_Question = "question/ignore"                             //忽略解惑
let APP_UpdateHeader = "loginInfo/changeHeadImageNew"                   //修改用户头像
let APP_SignCheck = "loginInfo/cansign/"                                //可否签到
let APP_UserSign = "loginInfo/sign/"                                    //签到
let APP_AddReveal = "home/addnew"                                       //发布开示
let APP_HotQuestions = "question/list/hot"                              //按热度排列的解惑列表
let APP_HomeReveal = "home/inspiration/home"                            //获取首页开示
let APP_Banner = "home/banner"                                          //获取首页开示
let APP_HotActivity = "activity/list/hot"                               //最热的活动
let APP_Version = "versionRecord/listAll/"                              //查询版本信息
let APP_UserFeedback = "reply/add"                                      //添加反馈内容
let APP_CircleDelete = "friend/cancel/"                                 //取消发布(只有发布人才能取消)
let APP_ZenmindDelete = "zenmind/cancel/"                               //取消发布(只有发布人才能取消)
let APP_VideoListByGroup = "chant/selectByGroupNew/"                       //按分组查询视频
let APP_RelatedVideoList = "chant/selectByTitleNew/"                       //按类别和名称模糊查询视频
let APP_VideoDetail = "chant/detail/"                                   //视频详情
let APP_RelatedVideoNewList = "chant/listBySpecial/"                    //根据专辑id获取视频列表


// MARK: 分享展示页面地址
//禅记   http://advance.muyusay.com/buddhism/share/chanji.html?id=96
let Share_chanji = "share/chanji.html?id="
//佛友圈  http://advance.muyusay.com/buddhism/share/foyouquan.html?id=100
let Share_foyouquan = "share/foyouquan.html?id="
//视频
//let Share_songjing = "share/songjing.html?id="
//敏感词检查http://www.hoapi.com/index.php/Home/Api/check
let checkForSensitive = "http://www.hoapi.com/index.php/Home/Api/check"


let Share_shanxing = "share/shanxing.html?id="                          //善行
let Share_jiehuo = "share/jiehuo.html?id="                              //解惑
let Share_huodong = "share/huodong.html?id="                            //活动
let Share_kaishi = "share/kaishi.html?id="                              //开示
let Share_foyin = "share/foyin.html?id="                                //佛音
let Share_longdujiehuo = "share/longdujiehuo.html"                      //隆度解惑
let Share_shipin = "share/songjing.html?id="  //视频

// MARK : 随机数
let arc = arc4random()%100

let getQiNiuToken = "common/getQiNiuToken"                              //获取七牛云文件上传token
let Friend_AddNew = "friend/addnew"                                     //发表动态(新)
let APP_SearchActivity = "activity/listBySearch/"                       //根据内容查询活动
let APP_getAppreciateList = "rejoice/queryRejoiceRecord/"               //查询随喜记录

let APP_WXPrePay = "weixinPay/suixi"                                    //微信支付
let APP_WXPrePay_Text = "weixinPay/suixiTest"                           //微信支付测试
let APP_WXOrderQuery = "weixinPay/orderQuery/"
let APP_DoRejoice = "/rejoice/doRejoice"
let APP_SysTime = "common/getSystemTime"                                //获取系统时间
let APP_AreasInfo = "area/getAreasInfo"                                 //获取系统时间
let APP_TempleAuthApply = "templeIdentify/apply"                        //寺庙认证申请

let APP_TempleAuthInfo = "templeIdentify/selectByLoginId/"
let APP_TempleAuthUpdate = "templeIdentify/update"                      //POST /templeIdentify/update 修改寺庙认证材料
let APP_MasterAuth = "masterIdentify/apply"                             //POST /masterIdentify/apply 大师申请入驻
let APP_MasterAuthInfo = "masterIdentify/get"                           //POST /masterIdentify/get 根据loginId查询认证信息
let APP_MasterAuthUpdate = "masterIdentify/upate"                       //POST /masterIdentify/upate 修改大师认证信息
let APP_TempleDetailByLoginId = "temple/detailByLoginId/"               //POST /masterIdentify/upate 修改大师认证信息
let APP_ReviewMaster = "masterIdentify/review"                          //POST /masterIdentify/review 审核大师资料

// MARK : 侧抽
let APP_drawerMyCilcle = "friend/group/listnew"                         //我的佛友圈
let APP_drawerMyCilcleCollect = "friend/list/collected"                 //我的佛友圈收藏
let APP_drawerMyBuddha = "zenmind/list/ByPublisher"                     //我的禅记
let APP_drawerMyBuddhaCollect = "zenmind/list/collection"               //我的禅记的收藏
let APP_Report = "common/report/"                                       //POST /common/report/{relatedType}/{relatedId}/{loginId} 举报

// MARK : 登录
let APP_quickLogin = "loginController/quickLogin/"                      //快速登录
let APP_passwordLogin = "loginController/login/"                        //密码登录
let APP_checkUpdateCode = "loginController/checkUpdateCode/"            //预修改密码
let APP_updatePassword = "loginController/updatePassword"               //更改密码
let APP_checkBindWX = "loginController/checkHasBindWx"                  //判断是否绑定了微信

// MARK : 我的
let APP_mainIntegral = "integral/getIntegralInfo/"                      //积分和功德值
let APP_mainMoneyInfo = "userInfo/queryUserAccountInfo/"                //资金信息
let APP_mainRejoice = "rejoice/queryUserTotalRejoiceInfo/"              //总的随喜
let APP_mainRejoiceRecord = "rejoice/queryRejoiceRecordByLogin/"        //随喜记录


// //MARK:- 标签
let APP_getTypeLabels = "label/getLabelsByContentType/"

//MARK:- 经书
let APP_getBookBanner = "buddhistBook/getBuddhistBookBanner"            //获取经书banner
let APP_getBookByTypeRandomly = "buddhistBook/getRandomTagBuddhistBook/"  //按类型随机获取经书
let APP_getBookItemListByType = "buddhistBook/getTopTagBuddhistBook/"   //根据类型获取菜单栏列表

let APP_getBookDetail = "buddhistBook/getBuddhistBookDetail/"       //根据专辑id获取专辑拥有的类型
let APP_getItemsListInBook = "buddhistBook/getBuddhistBookItemByBookId/"  //获取专辑里某一类型的经书

// MARK: 新版的佛音
let Music_banner = "buddhistMusic/getBuddhistMusicBanner"               // 新版音乐的banner
let Music_recommend = "buddhistMusic/getRecommendBuddhistMusic"         // 获取推荐的音乐:0:佛教音乐 3: 佛教故事 5: 高僧开示
let Music_detailHeader = "buddhistMusic/getBuddhistMusicDetail"         // 音乐详情头部
let Music_detailList = "buddhistMusic/getBuddhistMusicItemByMusicId"    // 音乐详情/{musicId}/{page}/{row}下面的列表
let Music_list = "buddhistMusic/getBuddhistMusicList"                   // {musicType}/{page}/{row}音乐的列表页
let Music_random = "buddhistMusic/getRandomBuddhistMusic"               // {musicType}
let Music_search = "buddhist/query"
let Music_search_general = "buddhist/queryCount"                        // /buddhist/queryCount/{search}







