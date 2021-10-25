p = double(dataset('File', 'matriz.txt'))
t = double(dataset('File' , 'targets.txt'))
[x,y] = size(p)
a=zeros(1,y);
clc;

W=2*rand(1,x)-1;
b=2*rand(1)-1;

for j = 1:10
for i=1:y
    a(i)=hardlim(W*p(:,i)+b);
        if a(i)~=t(i)
            W=2*rand(1,x)-1;
            b=2*rand(1)-1;
            break
        end
end
    if a(:)==t(:)
        break
    end
end



for r = 1:y
    if t(r)==1
        
        plot(p(1,r),p(2,r),'o','LineWidth',5)
        hold on
    end
    if t(r)==0
         plot(p(1,r),p(2,r),'s','LineWidth',5)
         hold on
    end
end

P1=[0 -b/W(1)];
P2=[-b/W(2) 0];
line(P1,P2, 'LineWidth',5)
hold on
plot(P1,P2,'ro','LineWidth',5)



