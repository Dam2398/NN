clear;
clc;
p = double(dataset('File', 'entrada.txt'));
t = double(dataset('File' , 'targets.txt'));
[x,y] = size(p);
[x2,y2] = size(t);


fprintf('Ingrese el número máximo de épocas a realizar (epochmax):\n');
emax = input('');
fprintf('Ingrese el valor al cuál se desea que llegue la señal de error (eepoch):\n');
epoch = input('');
fprintf('Ingrese el factor de aprendizaje:\n');
alfa = input('');

   clases=0;
   cortar=0;
   j=1;
  
W=-rand(1,x)
b=-rand(1)


    
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
  
for Epoca= 1:emax
sumaerror=0;
    for i=1:y
        a(i)=purelin(W*p(:,i)+b);
        e(i)=t(i)-a(i);
        W=W+2*alfa*e(i)*p(:,i)';
        b=b+2*alfa*e(i);      
              
        
    subplot(2,1,2)
     plot(j,W(1),'b*','LineWidth',5)
     title('Evolución del RNA');
     ylabel('Pesos');
     xlabel('Iteraciones');
     hold on
     plot(j,W(2),'r*','LineWidth',5)
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

fid = fopen('parametros_finales.txt','w');
fprintf(fid, 'Parametros finales');
fprintf(fid, 'W= [%.4f , %.4f] \n', W.');
fclose(fid);

        