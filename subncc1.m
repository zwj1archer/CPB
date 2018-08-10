%*****the function to realize detecting ******%
function IIB=subncc1(II,DBLK,af)
load TB;%load R_all

IIB=im2bw(II)*0;
[w,h]=size(II);
ws=round(w/8);%set supporting block size, in CPB we set block size as 8x8
hs=round(h/8);
wo=ones(1,ws)*8;
ho=ones(1,hs)*8;
Block=8*8;% block size

DBS=zeros(ws,hs,'single');%to save the divided blocks

%****** divide each training frame into blocks******%
IIS=mat2cell(II,wo,ho);
for x=1:ws
    for y=1:hs
       DBS(x,y)=mean(mean(IIS{x,y}));
    end
end

%****detect the object*****%
for x=1:w
    for y=1:h
          count1=0;
      
      for k=1:20 % the number of supporting blocks Q is 20
             im=x;
             jm=y;
             xQ=DBLK(x,y,k,1);%the background model:u
             yQ=DBLK(x,y,k,2);%the background model:v
             mQr=DBLK(x,y,k,3);%the background model:b
             std=DBLK(x,y,k,4);%the background model:¦Ò
        
            if abs(II((8*xQ-7):8*xQ,(8*yQ-7):8*yQ)-II(x,y)-mQr)>=std*af;%determine the state of pair (p, Q)
               count1=count1+DBLK(im,jm,k,5);%compute the changing probability R

            end
      end
	  

      if(count1>TB(im,jm)*0.5)% determine the state of target pixel p, R>R_all*0.5
               IIB(im,jm)=1; %foreground              
     end   
	 
  end
 end



