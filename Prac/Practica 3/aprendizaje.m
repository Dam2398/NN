p = double(dataset('File', 'matriz.txt'));
t = double(dataset('File' , 'targets.txt'));
[x,y] = size(p);
[x2,y2] = size(t);
j=1;
q=1;
clases=0;
clc;



if x2~=1
    
    
    
    
 for i2 = 1:y2
        if i2+1>y2
             break;
         end
     if t(:,i2)==t(:,i2+1)
         clases=clases+1;
         if i2>y2
             break;
         end
     end
 end
 S=log2(clases);
     
     
    W=2*rand(x)-1;
    b=2*rand(x,1)-1;
for Epocas=1:100
for i=1:y
     e(:,i)=t(:,i)-hardlim(W*p(:,i)+b);
      W=W+e(:,i)*p(:,i)';
        b=b+e(:,i);
        
     subplot(2,1,2)
     plot(j,W(1,:),'b*','LineWidth',5)
     hold on
     plot(j,W(2,:),'r*','LineWidth',5)
     j=j+1;
end

if e(:,:)==0
    break;
end

end

W2=inv(W);

for linea=1:S
    P1=[0 (-b(linea)*W2(2,:))];
    P2=[(-b(linea)*W2(1,:)) 0];
    
    subplot(2,1,1)
    line(P1(1:2),P2(2:3), 'LineWidth',5)
    hold on
    plot(P1(1:2),P2(2:3),'r.','LineWidth',5)
end 

for punto=1:y
    subplot(2,1,1)
    plot(p(1,punto),p(2,punto),'o','LineWidth',5)
    hold on
end

end

     
     
     
     
     
