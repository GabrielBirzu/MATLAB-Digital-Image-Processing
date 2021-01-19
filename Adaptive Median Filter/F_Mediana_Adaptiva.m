
%Zmin = valoarea minima a nivelului gri in Sxy
%Zmax = valoarea maxima a nivelului gri in Sxy
%Zmed = media nivelurilor gri in Sxy
%Zxy = nivelul gri la coordonatele (x, y)

%Exemplu de apel: F_Mediana_Adaptiva('Andreea.jpg', 1, 5)
%Exemplu de apel: F_Mediana_Adaptiva('Andreea.jpg', 1, 10)

function F_Mediana_Adaptiva(imageName, ns, nsMax)
  %Incarcare imagine
  I = imread(imageName);
  
  I = rgb2gray(I);
  
  I = imnoise (I,'salt & pepper',0.25);
 
  
  I = im2double(I);

  %Obtinerea dimensiunii imaginii
  [m, n] = size(I);
  
  %Imagine noua
  newI = I;
  for i=1:m
    for j=1:n
      newI(i,j) = adaptiveMedianPerPixel(I, i, j, ns, nsMax);
    end
  end

  subplot(1,2,1); imshow(I);
  title('Imaginea initiala');
    
  subplot(1,2,2); imshow(newI);
  title('Filtrarea mediana adaptiva');
  
end


%ns = neighbour size - size of Sxy
%nsMax
% i, j = linie, coloana
function [grayLevel] = adaptiveMedianPerPixel(I, i, j, ns, nsMax)
  [m, n] = size(I);
  if (i - ns < 1 || i + ns >= m || j - ns < 1 || j + ns >= n)
    grayLevel = I(i,j);
    return;
  end
  
  Sxy = I(i-ns:i+ns,j-ns:j+ns);
  Sxy = Sxy(:);
  Zmin = min(Sxy);
  Zmax = max(Sxy);
  Zmed = median(Sxy);
  A1 = Zmed - Zmin;
  A2 = Zmed - Zmax;
  if (A1 > 0 && A2 < 0)
    B1 = I(i,j) - Zmin;
    B2 = I(i,j) - Zmax;
    if (B1 > 0 && B2 < 0)
      grayLevel = I(i,j);
    else
      grayLevel = Zmed;
    end
    return;
  else
    ns = ns + 1;
  end
  
  if (ns < nsMax)
    grayLevel = adaptiveMedianPerPixel(I, i, j, ns, nsMax);
  else
    grayLevel = I(i,j);
  end
  
  
  
end



