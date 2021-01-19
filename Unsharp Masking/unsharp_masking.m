function [R] = unsharp_masking(nume,fisfiltru)

%% exemple de apel
%R=unsharp_masking('Andreea.jpg','m3.txt')
%R=unsharp_masking('Andreea.jpg','m5.txt')
%R=unsharp_masking('Andreea.jpg','m9.txt')

%% corpul functiei
%citirea imaginii
I=imread(nume);
I=rgb2gray(I);
[m,n,p]=size(I);
figure
imshow(I);
title('Imaginea initiala');
%preluarea din fisier a mastii de filtrare
w=load(fisfiltru);
[m1,n1]=size(w);
suma=sum(sum(w));
w=w/suma;
%R - rezultatul filtrarii
R=zeros(m,n,p);
%pentru fiecare plan al imaginii
for i=1:p
    J=double(I(:,:,i));
    % filtreaza cu masca w1 
    % implementare completa
    R(:,:,i)=filtru(J,m,n,w,m1,n1);
    % utilizarea functiei MATLAB filter2 - corelatie
    % sau Conv2 - convolutie
    % R(:,:,i)=filter2(w,J); 
end
R=uint8(R);
figure
imshow(R);
title('Imaginea filtrata cu un filtru medie');

M = (I-R);
figure
imshow(M);
title('Mask');

UM = M + I;
figure
imshow(UM);
title('Unsharp masking')

imwrite(uint8(UM), 'rezultat.bmp');

end