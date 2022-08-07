clc;clear all; close all;
load safe_path2T.mat
xhist2T = xhist2T(:,1:end);
rng(1)
xdata = xhist2T(1,:)+0.003;
ydata = xhist2T(2,:);

xx=linspace(0,1,201);

ppx1=polyfit(xx(1:91),xhist2T(1,1:91),1);
ppx2=polyfit(xx(91:201),xhist2T(1,91:201),1);

ppy1=polyfit(xx(1:9),ydata(1:9),1);
ppy2=polyfit(xx(9:41),ydata(9:41),1);
ppy3=polyfit(xx(41:71),ydata(41:71),1);
ppy4=polyfit(xx(71:140),ydata(71:140),1);
ppy5=polyfit(xx(140:201),ydata(140:201),1);

 
% z=linspace(-1,1,1401);
% y = 1.0 ./(1 + exp(-250.*(z)));
% plot (z,y)

z1=linspace(0,1,201);
A1=[ppx1;ppx2];
A2=[ppy1;ppy2;ppy3;ppy4;ppy5];


a=200;
s0=z1(1);
s1=z1(9);
s2=z1(41);
s3=z1(71);
s4=z1(140);
s5=2;


sx=z1(91);
for i =1:length(z1)


path(2,i) = (A2(1,1)*z1(i)+A2(1,2)) .*(1.0 ./(1 + exp(-a.*(s1-z1(i))))) .* (1.0 ./(1 + exp(-a.*(z1(i)-s0)))) + ...
            (A2(2,1)*z1(i)+A2(2,2)) *(1.0 ./(1 + exp(-a.*(s2-z1(i))))) * (1.0 ./(1 + exp(-a.*(z1(i)-s1)))) + ...
            (A2(3,1)*z1(i)+A2(3,2)) *(1.0 ./(1 + exp(-a.*(s3-z1(i))))) * (1.0 ./(1 + exp(-a.*(z1(i)-s2)))) + ...
            (A2(4,1)*z1(i)+A2(4,2)) *(1.0 ./(1 + exp(-a.*(s4-z1(i))))) * (1.0 ./(1 + exp(-a.*(z1(i)-s3)))) + ...
            (A2(5,1)*z1(i)+A2(5,2)) *(1.0 ./(1 + exp(-a.*(s5-z1(i))))) * (1.0 ./(1 + exp(-a.*(z1(i)-s4))));
path(1,i) = (ppx1(1).*z1(i) + ppx1(2)) .* (1.0 ./(1 + exp(-a.*(sx-z1(i))))) .* (1.0 ./(1 + exp(-a.*(z1(i)-s0)))) + ...
            (ppx2(1).*z1(i) + ppx2(2)) .* (1.0 ./(1 + exp(-a.*(s5-z1(i))))) .* (1.0 ./(1 + exp(-a.*(z1(i)-sx))));

end
figure(1)
plot(path(1,:),path(2,:));
hold on 
plot(xhist2T(1,:),xhist2T(2,:));
hold on 
% plot(xhist(1,:),ydata);
% grid on 

figure(2)
plot(z1,path(1,:));
hold on
plot(z1,xhist2T(1,:));

figure(3)
plot(z1,path(2,:));
hold on 
plot(z1,xhist2T(2,:));


% for i =1:194
% pathx(1,i) = -140 *z1(213+i)+139.9;
% pathy(1,i) = A2(8,1)*z1(1207+i)+A2(8,2) ;end