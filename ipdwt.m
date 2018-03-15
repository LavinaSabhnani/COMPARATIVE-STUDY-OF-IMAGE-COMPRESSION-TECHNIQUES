
close all;
clear all;
%Read Input Image
Input_Image=imread('face.jpg');
Input_Image=rgb2gray(Input_Image);
imwrite(Input_Image,'f.bmp');
%Red Component of Colour Image
Red_Input_Image=Input_Image(:,:,1);
%Green Component of Colour Image
Green_Input_Image=Input_Image(:,:,1);
%Blue Component of Colour Image
Blue_Input_Image=Input_Image(:,:,1);

%Apply Two Dimensional Discrete Wavelet Transform
[LLr,LHr,HLr,HHr]=dwt2(Red_Input_Image,'haar');
[LLg,LHg,HLg,HHg]=dwt2(Green_Input_Image,'haar');
[LLb,LHb,HLb,HHb]=dwt2(Blue_Input_Image,'haar');

First_Level_Decomposition(:,:,1)=[LLr,LHr;HLr,HHr];
First_Level_Decomposition(:,:,2)=[LLg,LHg;HLg,HHg];
First_Level_Decomposition(:,:,3)=[LLb,LHb;HLb,HHb];
First_Level_Decomposition=uint8(First_Level_Decomposition);

LL(:,:,1)=LLr;
LL(:,:,2)=LLg;
LL(:,:,3)=LLb;
LL=uint8(LL);
LL=rgb2gray(LL);

imwrite(LL,'f1.bmp');
I=imread('f1.bmp');

%Display Image
figure;subplot(1,3,1);imshow(Input_Image);title('Input Image');
subplot(1,3,2);imshow(First_Level_Decomposition,[]);title('First Level Decomposition');
subplot(1,3,3);imshow(I);title('LL Region');

%figure, imshow(I);
%I=First_Level_Decomposition;

H = fspecial('gaussian',2,10);
Gaus = imfilter(I,H,'replicate');
imwrite(Gaus,'f2.bmp');
figure;subplot(2,3,1);imshow(Input_Image);title('Input Image');
subplot(2,3,2);imshow(I);title('DWT Image (F)');
subplot(2,3,3);imshow(Gaus);title('LPF on F');

Eorig = entropy(Input_Image)
Edwt = entropy(I)
Elpfdwt = entropy(Gaus)

Sorig = imfinfo('f.bmp');
sori = Sorig.FileSize()
Scomp= imfinfo('f1.bmp');
scom = Scomp.FileSize()
Slpf= imfinfo('f2.bmp');
slp = Slpf.FileSize()

crdwt=sori/scom
crlpf=sori/slp


x=imread('f.bmp'); % f.bmp=FOR DWT, f2.bmp = DWT+LPF , CHANGE PARAMATERS!!!
%figure, subplot(1,3,1); imshow(x);title('Original First Image (OI)');
F=dct2(x);
%subplot(1,3,2);imshow(F*0.01);title('FunctDct2 on OI (I1)');
ff= idct2(F);
%subplot(1,3,3); imshow(ff/255);title('FunctIDct2 on I1 (I2)');
[r c]=size(x);
DF= zeros(r,c);
DFF=DF;
IDF=DF;
IDFF=DF;
depth=4;
N=8;
for i=1:N:r
    for j=1:N:c
        f=x(i:i+N-1,j:j+N-1);
        df=dct2(f);
        DF(i:i+N-1,j:j+N-1)=df;% DCT of Block 
        dff=idct2(df);
        DFF(i:i+N-1,j:j+N-1)=dff; % Inverse DCT of Block
        
        df(N:-1:depth+1,:)=0;
        df(:,N:-1:depth+1)=0;
        IDF(i:i+N-1,j:j+N-1)=df;
        dff=idct2(df);
        IDFF(i:i+N-1,j:j+N-1)=dff;
    end
end
%figure , subplot(1,4,1);imshow(DF/255); title('After performing DCT (I3)');
%subplot(1,4,2); imshow(DFF);title('After performing DCT (I4)');
A=DFF/255;
%subplot(1,4,3);imshow(A);title('After performing DCT (I5)');
B=DFF/255;
%subplot(1,4,4);imshow(B);title('After performing DCT (I6)');

squared_error=0;   % Initializing %
rms=0;         % Initializing %
temp=0;         % Required for SNR %
[row col]= size(x);
ms=0;
for i=1:1:row 
    for j=1:1:col
        ms= (DF(i,j)- DFF(i,j))^2;
        squared_error= ms + squared_error;
        temp1=DF(i,j)*DFF(i,j);
        temp=temp1+temp;
    end 
end


mse=squared_error/(row*col)
rme=sqrt(mse)
snr=squared_error/temp
psnr= 10*log((256*256)/mse)
