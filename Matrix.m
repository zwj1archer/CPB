clear all
clc
close all
%*******for training*******% 
trainPath ='C:/Foreground_Detection/trainraw3/';
filename = dir('C:/Foreground_Detection/trainraw3/*.jpg'); % load the training frames

baseTrainNum=300;%set the number of training frames

img_w=240;% soure image width
img_h=320;% soure image height

refnum=20;%set the supporting blocks num 

DBr=zeros(img_w,img_h,fpernum1,'single');
DBLKr=zeros(img_w/8,img_h/8,refnum,5,'single');% to save the training reuslts

DBg=zeros(img_w,img_h,fpernum1,'single');%
DBLKg=zeros(img_w/8,img_h/8,refnum,5,'single');% to save the training reuslts


DBb=zeros(img_w,img_h,fpernum1,'single');%
DBLKb=zeros(img_w/8,img_h/8,refnum,4,'single');% to save the training reuslts

idx=baseTrainNum;

 for t=1:idx % training the framse
         img=imread([trainPath,filename(t).name]);
         II=imresize(img,[img_w img_h]);
		 
         IIr=II(:,:,1);
         DBr(:,:,t)=IIr;%three-channel segmentation
        
         
         IIg=II(:,:,2);
         DBg(:,:,t)=IIg;
 
         IIb=II(:,:,3);
         DBb(:,:,t)=IIb;
                   
   end
   
    tic
     DBLKr=trainncc2(DBr,refnum);
    toc;
 	 DBLKg=trainncc2(DBg,refnum);
	 DBLKb=trainncc2(DBb,refnum);%the background model
   
    save DBLKr DBLKr
    save DBLKg DBLKg
    save DBLKb DBLKb
    
  
 