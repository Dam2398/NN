p = double(dataset('File', 'matriz.txt'));
t = double(dataset('File' , 'targets.txt'));
[x,y] = size(p);
[x2,y2] = size(t);
j=1;
q=1;

clc;


if x2==1
W=2*rand(1,x)-1;
b=2*rand(1)-1;
end
if x2==2
    W=2*rand(x)-1;
    b=2*rand(x,1)-1;
end


for Epocas=1:50
for i=1:y
    if x2==2
         e(:,i)=t(:,i)-hardlim(W*p(:,i)+b);
          b=b+e(:,i);
    end
    if x2==1
        a(i)=hardlim(W*p(:,i)+b);
        e(i)=t(i)-a(i);
         b=b+e(i);
    end

    W=W+e(i)*p(:,i)';
    
   
     subplot(2,1,2)
     plot(j,W(1),'b*','LineWidth',5)
     hold on
     plot(j,W(2),'r*','LineWidth',5)
     j=j+1;
    
end

    if e(:,:)==0
        break
    end
end

for r = 1:y
    if t(:,r)==1
        subplot(2,1,1)
        plot(p(1,r),p(2,r),'o','LineWidth',5)
        hold on
    end
    if t(r)==0
        subplot(2,1,1)
         plot(p(1,r),p(2,r),'s','LineWidth',5)
         hold on
    end
end

P1=[0 -b/W(1)];
P2=[-b/W(2) 0];

line(P1,P2, 'LineWidth',5)
hold on
plot(P1,P2,'ro','LineWidth',5)



