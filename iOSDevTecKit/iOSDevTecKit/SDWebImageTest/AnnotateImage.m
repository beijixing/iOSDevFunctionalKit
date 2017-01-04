//
//  AnnotateImage.m
//  iOSDevTecKit
//
//  Created by horse on 2016/12/30.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "AnnotateImage.h"
#import "UIImageExt.h"
#import "UIFactory.h"
#import "AnnoteTextView.h"
#import <Photos/Photos.h>
#import "MBProgressHUD.h"

@interface AnnotateImage ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) NSMutableArray *textFieldArr;
@property (nonatomic) BOOL expand;
@property (nonatomic) BOOL move;
@property (nonatomic) CGPoint touchBegin;
@property (nonatomic) CGRect annoteInitFrame;
@property (nonatomic, strong) AnnoteTextView *annoteView;
@end

@implementation AnnotateImage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.expand = false;
    self.imageView.image = [UIImage imageNamed:@"c.png"];
    self.navigationController.navigationBar.hidden = YES;
    
}

- (IBAction)saveDisposedImage:(id)sender {
    [self saveImage:screenshot(self.containerView)];
}

UIImage * screenshot(UIView *view){
//    if(UIGraphicsBeginImageContextWithOptions != NULL)
//    {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
//    } else {
//        UIGraphicsBeginImageContext(view.frame.size);
//    }
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
//- (UIImage * )screenshot{
//    UIView * view = [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:YES];
//    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
//    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//}

- (IBAction)selectImageFromLibrary:(id)sender {
    //构建一个选择菜单列表 选择照相机还是 相册
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择照片方式" message:nil
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *alertActionOne = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self openPhotoLibrary];
        }];
        [alertController addAction:alertActionOne];
        
        UIAlertAction *alertActionTwo = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self openCamera];
        }];
        [alertController addAction:alertActionTwo];
        
        UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAlertAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
        sheet.delegate = self;
        [sheet showInView:self.view];
    }
}

- (IBAction)addAnAnnotation:(id)sender {
    AnnoteTextView *tf = [[AnnoteTextView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    tf.center = self.view.center;
//    tf.backgroundColor = [UIColor clearColor];
    [self.containerView addSubview:tf];
    
    [tf.textView becomeFirstResponder];
    [self.textFieldArr addObject:tf];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (self.textFieldArr.count > 0 ) {
        
        typeof(self) __weak wself = self;
        [self.textFieldArr enumerateObjectsUsingBlock:^(AnnoteTextView *anoteView, NSUInteger idx, BOOL * _Nonnull stop) {
            wself.touchBegin = [touch locationInView:anoteView];
            NSLog(@"beginPoint(%f, %f)", wself.touchBegin.x, wself.touchBegin.y);
            wself.annoteInitFrame = anoteView.frame;
            wself.annoteView = anoteView;
            if ( CGRectContainsPoint(anoteView.leftTopView.frame, wself.touchBegin)) {
                NSLog(@"放大输入框");
                wself.expand = YES;
            }else {
                wself.expand = NO;
            }
            
            if (CGRectContainsPoint(anoteView.rightTopView.frame, self.touchBegin)){
                wself.move =YES;
            }else {
                wself.move = NO;
            }
            
            if (wself.expand || wself.move) {
                *stop = YES;
            }
        }];
        
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
     UITouch *touch = [touches anyObject];
//     AnnoteTextView *anoteView = [self.textFieldArr objectAtIndex:0];
     CGPoint point = [touch locationInView:self.annoteView];
     NSLog(@"movepoint(%f, %f)", point.x, point.y);
    
    if (self.expand) {
        float distx = point.x - self.annoteInitFrame.size.width;
        float disty = point.y - 0;
        
        float newWidth = self.annoteInitFrame.size.width + distx;
        float newHeight = self.annoteInitFrame.size.height - disty;
        
        if (newWidth < 70) {
            newWidth = 70;
        }
        if (newHeight < 70) {
            newHeight = 70;
        }
        
        CGRect newframe = CGRectMake(self.annoteInitFrame.origin.x, self.annoteInitFrame.origin.y + disty/2, newWidth, newHeight);
        self.annoteView.frame = newframe;
    }else if(self.move) {
        NSLog(@"点击点在textview中");
        float distx = point.x - 0;
        float disty = point.y - 0;
        NSLog(@"distxy(%f, %f)", distx, disty);
        
        
        CGRect newframe = CGRectMake(self.annoteInitFrame.origin.x + distx/2, self.annoteInitFrame.origin.y + disty/2, self.annoteInitFrame.size.width, self.annoteInitFrame.size.height);
        self.annoteView.frame = newframe;
        self.annoteInitFrame = newframe;
    }
    
    
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.expand = false;
    self.move = false;
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}

#pragma mark -- UIActionSheet代理方法实现
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        // 打开相册
        [self openPhotoLibrary];
    } else if (buttonIndex == 1) {
        // 打开拍照
        [self openCamera];
    }
    
}

//打开相册
-(void)openPhotoLibrary {
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = YES;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

//打开相机
-(void)openCamera {
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    self. imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = YES;
    self.imagePicker.sourceType = sourceType;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

#pragma mark -相册相关的代理方法的实现
//取消选择
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image;
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) { //如果打开相册
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
        //压缩图片
        image = [image imageByScalingAndCroppingForSize:CGSizeMake(320, 320)];
    }
    else {//如果打开的是照相机
        [picker dismissViewControllerAnimated:YES completion:nil];
        //image = [info objectForKey:UIImagePickerControllerEditedImage]; //得到编辑后的照片
        image = [info objectForKey:UIImagePickerControllerOriginalImage]; //获取原始的照片
        //压缩图片
        image = [image imageByScalingAndCroppingForSize:CGSizeMake(320, 320)];
    }
    
    
    //处理图片 压缩、裁剪或上传
}


//保存图片到沙盒中
- ( NSString *) saveImage:(UIImage*)image WithName:(NSString*)imageName {
    
    //将图片保存到沙盒
    //保存文件到沙盒
    //获取沙盒中Documents目录路径
    //        DLog(@"%@",documents);
    
    //拼接文件绝对路径
    DLog(@"str imageName = %@", imageName);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // 获得图片的全路径
    NSString *fullpath = [documentsDirectory stringByAppendingPathComponent: imageName];
    NSData* imageData = UIImagePNGRepresentation(image);
    
    //保存
    [imageData writeToFile:fullpath atomically:NO];
    
    return fullpath;
}

- (NSMutableArray *)textFieldArr {
    if (_textFieldArr) {
        return _textFieldArr;
    }
    _textFieldArr = [[NSMutableArray alloc] init];
    return _textFieldArr;
}

- (void)saveImage:(UIImage *)image
{
//    NSMutableArray *imageIds = [NSMutableArray array];
    typeof (self) __weak wself = self;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        //写入图片到相册
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        //记录本地标识，等待完成后取到相册中的图片对象
//        [imageIds addObject:req.placeholderForCreatedAsset.localIdentifier];
        
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        NSLog(@"success = %d, error = %@", success, error);
        
        if (success)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:wself.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"保存成功";
                hud.removeFromSuperViewOnHide = YES;
                //            hud.completionBlock = block;
                [hud hide:YES afterDelay:1];
            });

            //成功后取相册中的图片对象
//            __block PHAsset *imageAsset = nil;
//            PHFetchResult *result = [PHAsset fetchAssetsWithLocalIdentifiers:imageIds options:nil];
//            [result enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                
//                imageAsset = obj;
//                *stop = YES;
//                
//            }];
            
//            if (imageAsset)
//            {
//                //加载图片数据
//                [[PHImageManager defaultManager] requestImageDataForAsset:imageAsset
//                                                                  options:nil
//                                                            resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
//                                                                
//                                                                NSLog("imageData = %@", imageData);
//                                                                
//                                                            }];
//            }
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
