//
//  ViewController.m
//  PhontoUploadDemo
//
//  Created by apple on 15/8/26.
//  Copyright (c) 2015年 jacky. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *showImg;

@property (nonatomic ,strong)UIActionSheet *sheet;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)uploadPicAction:(id)sender {
    //判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        _sheet = [[UIActionSheet alloc]initWithTitle:@"选择图片" delegate:self cancelButtonTitle: @"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍照" ,nil];
    }
    else {
        _sheet = [[UIActionSheet alloc]initWithTitle:@"选择图片" delegate:self cancelButtonTitle: @"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",nil];
    }
    
    
    [_sheet showInView:self.view];
}

#pragma mark -actionsheet 代理
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    
    if (buttonIndex!=actionSheet.cancelButtonIndex) {
        //判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            switch (buttonIndex) {
                case 0://相册选择
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                    
                case 1://拍照
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
            }
            
            UIImagePickerController *imagePickerController  = [[UIImagePickerController alloc]init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            imagePickerController.sourceType = sourceType;
            
            [self presentViewController:imagePickerController animated:YES completion:nil];
            
        }else{
            
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            UIImagePickerController *imagePickerController  = [[UIImagePickerController alloc]init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            imagePickerController.sourceType = sourceType;
            
            [self presentViewController:imagePickerController animated:YES completion:nil];   
            
        }
    }
    
}

#pragma mark -添加照片空间的代理方芳
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    /**
     *  此处参数区别于其他的
     UIKIT_EXTERN NSString *const UIImagePickerControllerMediaType;      // an NSString (UTI, i.e. kUTTypeImage)
     UIKIT_EXTERN NSString *const UIImagePickerControllerOriginalImage;  // a UIImage
     UIKIT_EXTERN NSString *const UIImagePickerControllerEditedImage;    // a UIImage
     UIKIT_EXTERN NSString *const UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     UIKIT_EXTERN NSString *const UIImagePickerControllerMediaURL;       // an NSURL
     UIKIT_EXTERN NSString *const UIImagePickerControllerReferenceURL        NS_AVAILABLE_IOS(4_1);  // an NSURL that references an
     */
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.showImg.image = image;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
