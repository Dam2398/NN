clear;
clc;

p = double(dataset('File', 'entrada3.txt'));
t = double(dataset('File' , 'targets3.txt'));
[x,y] = size(p);
[x2,y2] = size(t);

fprintf('¿Qué modo desea, regresión o clasificación?\n');
fprintf('1.Regresión \n2.Clasificación\n')
D=input('');
clc;

if D==1
    fprintf('Ingrese el número máximo de épocas a realizar (epochmax):\n');
    emax = input('');
    fprintf('Ingrese el valor al cuál se desea que llegue la señal de error (eepoch):\n');
    epoch = input('');
    fprintf('Ingrese el factor de aprendizaje:\n');
    alfa = input('');
    
    W=2*rand(1,y)-1;
    j=1;
   
    for Epoca=1:emax
        sumaerror=0;
       for i=1:x
           a=purelin(W*p(i,:)');
           e(i)=t(i)-a;
           W=W+2*alfa*e(i)*p(i,:);
           
     plot(j,W(1),'b*','LineWidth',5)
     title('Evolución del RNA');
     ylabel('Pesos');
     xlabel('Iteraciones');
     hold on
     plot(j,W(2),'r*','LineWidth',5)
     hold on
     plot(j,W(3),'k*','LineWidth',5)
     
     
     j=j+1;
       end
       sumaerror=sum(e,2);
       Error(Epoca)=sumaerror/x;
       
  if (Error(Epoca)<epoch || Error(Epoca)==0)
      break;
  end
       
    end
  
fid = fopen('parametros_finales.txt','w');
fprintf(fid, 'Parametros finales\n W=[ ');
fprintf(fid, '\n%.4f  \n', W.');
fprintf(fid,']');
fclose(fid);    
   
end


    clases=0;  
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
 
 
if D==2
    fprintf('Ingrese el número máximo de épocas a realizar (epochmax):\n');
    emax = input('');
    fprintf('Ingrese el valor al cuál se desea que llegue la señal de error (eepoch):\n');
    epoch = input('');
    fprintf('Ingrese el factor de aprendizaje:\n');
    alfa = input('');
    

   j=1;
   
   if x2==1
   W=-rand(1,x);
   b=-rand(1);
 
for Epoca= 1:emax
sumaerror=0;
    for i=1:y
        a(i)=purelin(W*p(:,i)+b);
        e(i)=t(i)-a(i);
        W=W+2*alfa*e(i)*p(:,i)';
        b=b+2*alfa*e(i);      
              
        
    subplot(3,1,2)
     plot(j,W(1),'b*','LineWidth',5)
     title('Evolución del RNA');
     ylabel('Pesos');
     xlabel('Iteraciones');
     hold on
     plot(j,W(2),'r*','LineWidth',5)
     
     subplot(3,1,3)
     hold on
     plot(j,b,'b*','LineWidth',5)
     title('Evolución del bias');
     xlabel('Iteraciones');
     
     j=j+1;
    end
         sumaerror=sum(e);
         Error(Epoca)=sumaerror/S;
   
  if (Error(Epoca)<epoch || Error(Epoca)==0)
      break;
  end
    
end

for r = 1:y
    if t(r)==1
        subplot(3,1,1)
        plot(p(1,r),p(2,r),'go','LineWidth',5)
        title('Frontera de decisión');
        hold on
    end
    if t(r)==0
        subplot(3,1,1)
         plot(p(1,r),p(2,r),'ks','LineWidth',5)
         hold on
    end
end

P1=[0 -b/W(1)];
P2=[-b/W(2) 0];
subplot(3,1,1)
line(P1,P2, 'LineWidth',5)
hold on
plot(P1,P2,'ro','LineWidth',5)
   
   end
   
   
if x2~=1
    W=-rand(x);
    b=-rand(x,1);

for Epoca= 1:emax
    for i=1:y
        a(:,i)=purelin(W*p(:,i)+b);
        e(:,i)=t(:,i)-a(:,i);
        
        W=W+2*alfa*e(:,i)*p(:,i)';
        b=b+2*alfa*e(:,i);
        
     subplot(3,1,2)
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
 
     
     subplot(3,1,3)
     plot(j,b(1,1),'b*','LineWidth',5)
     title('Evolución del bias');
     xlabel('Iteraciones');
     hold on
     plot(j,b(2,1),'r*','LineWidth',5)
     j=j+1;
       
    end
sumaerror=sum(sum(e),2);

Error(Epoca)=sumaerror/S;
if (Error(Epoca)<epoch || Error(Epoca)==0)
      break;
end

end



W2=inv(W);

for linea=1:S
    P1=[0 (-b(linea)*W2(2,:))];
    P2=[(-b(linea)*W2(1,:)) 0];
    
    subplot(3,1,1)
    line(P1(1:2),P2(2:3), 'LineWidth',5)
    hold on
    plot(P1(1:2),P2(2:3),'r.','LineWidth',5)
end 

for punto=1:y
    subplot(3,1,1)
    plot(p(1,punto),p(2,punto),'o','LineWidth',5)
    hold on
end
end
   
fid = fopen('parametros_finales.txt','w');
fprintf(fid, 'Parametros finales\n W= ');
fprintf(fid, '\n[%.4f  %.4f] \n', W.');
fclose(fid);    
end

fprintf('Se realizaron %d epocas\n',Epoca);





