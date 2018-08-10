clear all
clc
clear all

%*******for detecting*******% 
load DBLKr;%load the background model
load DBLKg;
load DBLKb;

img_w=240;% soure image width
img_h=320;% soure image height

af=2.5;%threshold (C)for Gaussian model

TestPath='C:/Foreground_Detection/trainraw4/';
TestFileName = dir('C:/Foreground_Detection/trainraw4/*.jpg');%load the testing frames

    test_t=29;%testing frame

    imgt=imread([TestPath,TestFileName(test_t).name]);
     IItest=imresize(imgt,[img_w img_h]);
   
     IIr=double(IItest(:,:,1)); % three-channel segmentation
     IIg=double(IItest(:,:,2)); 
     IIb=double(IItest(:,:,3)); 
    
    
    tic
      IIBr=subncc1(IIr,DBLKr,af);
    toc
	
      IIBg=subncc1(IIg,DBLKg,af);
      IIBb=subncc1(IIb,DBLKb,af);
      IIB=IIBr+IIBg+IIBb;% the result
   
    s=strcat('./subpre/',TestFileName(test_t).name,'.bmp');% save the result
    imwrite(IIB,s);
 end