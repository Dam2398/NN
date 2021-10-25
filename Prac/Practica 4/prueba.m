clear
clc

p = double(dataset('File', 'entrada2.txt'));
t = double(dataset('File' , 'targets2.txt'));
[x,y] = size(p);
[x2,y2] = size(t);

fprintf('Ingrese el número máximo de épocas a realizar (epochmax):\n');
emax = input('');
fprintf('Ingrese el valor al cuál se desea que llegue la señal de error (eepoch):\n');
epoch = input('');
fprintf('Ingrese el factor de aprendizaje:\n');
alfa = input('');

W=-rand(x)
b=-rand(x,1)
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

for Epoca= 1:emax
    for i=1:y
        a(:,i)=purelin(W*p(:,i)+b);
        e(:,i)=t(:,i)-a(:,i);
        
        W=W+2*alfa*e(:,i)*p(:,i)';
        b=b+2*alfa*e(:,i);
       
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
    
    line(P1(1:2),P2(2:3), 'LineWidth',5)
    hold on
    plot(P1(1:2),P2(2:3),'r.','LineWidth',5)
end 

for punto=1:y

    plot(p(1,punto),p(2,punto),'o','LineWidth',5)
    hold on
end

fid = fopen('parametros_finales.txt','w');
fprintf(fid, 'Parametros finales\n W= ');
fprintf(fid, '\n[%.4f , %.4f] \n', W.');
fclose(fid);
    
    
    
    
        