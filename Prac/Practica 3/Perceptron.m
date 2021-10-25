clear;
clc;
p = double(dataset('File', 'matriz.txt'));
t = double(dataset('File' , 'targets.txt'));
[x,y] = size(p);
[x2,y2] = size(t);


fprintf('¿Cómo desea resolver, método grafico o aprendizaje?\n');
fprintf('1.Método grafico \n2.Aprendizaje\n')
D=input('');

if x2==1
if D==1
 a=zeros(1,y);
 
W=2*rand(1,x)-1;
b=2*rand(1)-1;

for intentos = 1:10
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
        
        plot(p(1,r),p(2,r),'go','LineWidth',5)
title('Frontera de decisión');
        hold on
    end
    if t(r)==0
         plot(p(1,r),p(2,r),'ks','LineWidth',5)
         hold on
    end
end

P1=[0 -b/W(1)];
P2=[-b/W(2) 0];
line(P1,P2, 'LineWidth',5)
hold on
plot(P1,P2,'ro','LineWidth',5)

end

if D==2
    j=1;
    q=1;
    e(1)=1;
    
W=2*rand(1,x)-1;
b=2*rand(1)-1;

for Epocas=1:50
for i=1:y
    a(i)=hardlim(W*p(:,i)+b);
    e(i)=t(i)-a(i);
    W=W+e(i)*p(:,i)';
    
   
     subplot(2,1,2)
     plot(j,W(1),'b*','LineWidth',5)
     title('Evolución del RNA');
     ylabel('Pesos');
     xlabel('Iteraciones');
     hold on
     plot(j,W(2),'r*','LineWidth',5)
     j=j+1;
     
    b=b+e(i);
end

    if e(:)==0
        break
    end
end

for r = 1:y
    if t(r)==1
        subplot(2,1,1)
        plot(p(1,r),p(2,r),'go','LineWidth',5)
        title('Frontera de decisión');
        hold on
    end
    if t(r)==0
        subplot(2,1,1)
         plot(p(1,r),p(2,r),'ks','LineWidth',5)
         hold on
    end
end

P1=[0 -b/W(1)];
P2=[-b/W(2) 0];
line(P1,P2, 'LineWidth',5)
hold on
plot(P1,P2,'ro','LineWidth',5)


end
end


if x2~=1
    
    if D==1
        
clases=0;
    W=2*rand(x)-1;
    b=2*rand(x,1)-1;

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
for Epocas = 1:10
for i=1:y

    a(:,i)=hardlim(W*p(:,i)+b);
    if dot(W(1,:),W(2,:))~=0
    W=2*rand(x)-1;
    b=2*rand(x,1)-1;
    end
    if dot(W(1,:),W(2,:))==0
break;
    end
end
end


W2=inv(W);
for linea=1:S
    P1=[0 (-b(linea)*W2(2,:))];
    P2=[(-b(linea)*W2(1,:)) 0];
    
    line(P1(1:2),P2(2:3), 'LineWidth',5)
    hold on
    plot(P1(1:2),P2(2:3),'r.','LineWidth',5)
    hold on
end 
for punto=1:y
   
    plot(p(1,punto),p(2,punto),'o','LineWidth',5)
    title('Frontera de decisión');
    hold on
end
    end
  
    
    
    if D==2
    clases=0;
    j=1;
    q=1;
    
    
    
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
     plot(j,W(1,1),'b*','LineWidth',5)
     title('Evolución del RNA');
     ylabel('Pesos');
     xlabel('Iteraciones');
     hold on
     plot(j,W(1,2),'r*','LineWidth',5)
     hold on
     plot(j,W(2,1),'m*','LineWidth',5)
     hold on
     plot(j,W(2,2),'k*','LineWidth',5)
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
if e(:,:)==0
fprintf('Es posible que no se aprecie gráficamente las fronteras de decisión, así que se muestra la matriz en la que se guardó los valores del error durante el proceso');
fprintf('\ne: [') ;
fprintf(' %d ', e) ;
fprintf(']\n') ;
end
    end

end


    
    