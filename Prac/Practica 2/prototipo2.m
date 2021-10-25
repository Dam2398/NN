W1= importdata('pesos.txt')
[n,m] = size(W1)

e=0.5;
q=0;
t=2;

for i=1:n
    b(i,1)=m;
end

for h=1:m
    disp(['p (',num2str(h),',1)'])
    P(h,1)=input('');
end

a1= (W1*P)+b;


E= ones(n);
for i=1:n
    for j=1:n
        if i~=j
        E(i,j) = -E(i,j)*e;
        end
    end
end

a2(:,:,1)=a1;
plot(1,a2(:,:,1),'o');
title('Evolución del vector a2');
xlabel('Iteraciones');
ylabel('Valores');
while t<=50
    o=0;
    a2(:,1,t)=E*a2(:,1,t-1);
    for x=1:n
        if a2(x,1,t)>=0
             a2(x,1,t)= a2(x,1,t);
             x2=a2(x,1,t);
             if a2(x,1,t)>0
                q=x;
                o=+1;
             end  
        end
        
        if a2(x,1,t)<0
            a2(x,1,t)=0;
            x2=a2(x,1,t);
        end
        hold on
        plot(t,a2(x,1,t),'o'); 
        hold on
    end
  
   if q~=0
       if o==1
    if a2(x,1,t)==a2(x,1,t-1)
        fprintf('Converge\n');
        fprintf('Es el vector prototipo: %d \n',q);
a2(:,1,t)
        t=50;
    end
       end
   end
    t=t+1;
end


        
