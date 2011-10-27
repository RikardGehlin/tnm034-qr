clear
%inladdning av bilder
geo = im2double(imread('Bilder/Corrected1.jpg'));
%imhist(geo)

geo = geo < 0.80;
%figure(2);
imshow(geo)
%figure(3);
%imhist(geo);
%figure(4);

%sätter label på alla object och räknar sen ut koordinaterna på mitten för dessa
geo = bwlabel(geo);
centrumkoordinater = regionprops(geo,'centroid');

%gör en tabell av koordinaterna
for n = 1 : 96
    uv(n,:) = centrumkoordinater(n).Centroid;
end

%delar upp de i varsin del
v = round(uv(:,1));
u = round(uv(:,2));

for n=0:11
temp=sortrows([u(n*8+1:n*8+8),v(n*8+1:n*8+8)],1);
u(n*8+1:n*8+8)=temp(:,1);
v(n*8+1:n*8+8)=temp(:,2);
end

mn=min(u);
mx=max(u);
x=round([mn:(mx-mn)/7:mx]');
x=[x;x;x;x;x;x;x;x;x;x;x;x];
% 
rn=min(v);
rm=max(v);
yt=round([rn:(rm-rn)/11:rm]')

for i=0:11
    y(i*8+1:i*8+8)=yt(i+1);
end

y=y';

for n=1:96
V(n,1) = 1;    
V(n,2)= 1*x(n);
V(n,3)= y(n);
V(n,4)= (x(n))^2;
V(n,5)= (y(n))^2;
V(n,6)= x(n)*y(n);
V(n,7)= (x(n))^3;
V(n,8)= (y(n))^3;
V(n,9)= ((x(n))^2) * y(n);
V(n,10)= (x(n)) * (y(n))^2;
end

Vi=PINV(V);
a=Vi*u;
b=Vi*v;

geo2 = im2double(imread('Bilder/Corrected1.jpg'));

for n=1:480
    for m=1:640
geo2corr(n,m)=geo2(round(1*a(1) + n*a(2) + m*a(3) + ((n)^2)*a(4) + ((m)^2)*a(5) + (n*m)*a(6) + ((n)^3)*a(7) + ((m)^3)*a(8) + (((n)^2) * m)*a(9) + ((n) * (m)^2)*a(10)),round( 1*b(1) + n*b(2) + m*b(3) + ((n)^2)*b(4) + ((m)^2)*b(5) + (n*m)*b(6) + ((n)^3)*b(7) + ((m)^3)*b(8) + (((n)^2) * m)*b(9) + ((n) * (m)^2)*b(10)));

    end
end

imshow(geo2corr);

% for n = 1:12
%     uv(((n-1)* 8) + 1 : n*8,:) = sortrows(uv(((n-1)* 8) + 1 : n*8, :),1)
% end
% 
% deltau = ((uv(52,1)-uv(44,1)) + (uv(53,1)-uv(45,1)))/2
% deltav = ((uv(45,2)-uv(44,2)) + (uv(53,2)-uv(52,2)))/2
% 
% for n = 1:12
%     for m = 1:8
%         [x y] = (uv(52,1) - (6-n) * deltau, uv(52,2) - (4-m) * deltav);
%     end    
% end





%      x(m,n) = u(52,1) + (6-n)*deltau;
%          y(m,n) = u(52,1) + (4-m)*deltav;
% 
% xy;
% x = xy(:,1);
% y = xy(:,2);
% [x y];
%imwrite (corrected, 'Corrected.jpg', 'jpg');