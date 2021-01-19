function [R]=filtru(J,m,n,w,m1,n1)
%% extinderea imaginii cu cate m1-1 linii deasupra/sub imagine si cate n1-1 coloane la stanga/dreapta imaginii 
l=m+2*m1-2;
c=n+2*n1-2;
f=zeros(l,c);
f(m1:m+m1-1,n1:n+n1-1)=J;
%% calculul matricei rezultat al corelatiei/convolutie
g=zeros(l,c);
a=(m1-1)/2;b=(n1-1)/2;
%filtrare cu masca w
for x=m1:m+m1-1
    for y=n1:n+n1-1
        for s=1:m1
            for t=1:n1
                %pentru corelatie
                %g(x,y)=g(x,y)+w(s,t)*f(x+s-a-1,y+t-b-1);
                %pentru convolutie
                g(x,y)=g(x,y)+w(s,t)*f(x-s+a+1,y-t+b+1);
            end
        end
    end
end
R=g(m1:m+m1-1,n1:n+n1-1);
end

