%% Inicio del programa
function MLP()

    clear,clc,close all

%% Carga del archivo de prototipos y targets
    
p = importdata('02_Polinomio_Entrada.txt');
ta = importdata('02_Polinomio_Target.txt');
data = horzcat(p,ta);


    
     %% Asignación de los conjuntos de datos
    opcion=input('Tomando en cuenta que [aprendiaje validacion pruebas] \n 1.[70% 15% 15%] \n 2.[80% 10% 10%] \nElija la opcion de distribución deseada: ');
    %%%%%%%%%%%%%%%%%%%%%%%eleccion del dataset
    [filas,~]=size(data);
    entrada=data(:,1);
    target=data(:,2);

    x_CE=0;
    x_CV=0;
    x_CP=0;
    switch opcion
        case 1

            separador=1;
            idiE=fopen('iCE.txt','w');
            idiV=fopen('iCV.txt','w');
            idiP=fopen('iCP.txt','w');
            idtE=fopen('tCE.txt','w');
            idtV=fopen('tCV.txt','w');
            idtP=fopen('tCP.txt','w');

            contador=1;
            while contador<=filas
                p0=entrada(contador,1);
                gdp=target(contador,1);
                switch separador
                    case 4
                        fprintf(idiV,'%f\r\n',p0);
                        fprintf(idtV,'%f\r\n',gdp);
                        x_CV=x_CV+1;
                    case 7
                        fprintf(idiP,'%f\r\n',p0);
                        fprintf(idtP,'%f\r\n',gdp);
                        x_CP=x_CP+1;
                    case 10
                        fprintf(idiE,'%f\r\n',p0);
                        fprintf(idtE,'%f\r\n',gdp);
                        separador=0;
                        x_CE=x_CE+1;
                    otherwise
                        fprintf(idiE,'%f\r\n',p0);
                        fprintf(idtE,'%f\r\n',gdp);
                        x_CE=x_CE+1;
                end
                contador=contador+1;
                separador=separador+1;
            end
            %
            fclose(idiE);
            fclose(idiV);
            fclose(idiP);
            fclose(idtE);
            fclose(idtV);
            fclose(idtP);
        case 2
            %
            separador=1;
            idiE=fopen('iCE.txt','w');
            idiV=fopen('iCV.txt','w');
            idiP=fopen('iCP.txt','w');
            idtE=fopen('tCE.txt','w');
            idtV=fopen('tCV.txt','w');
            idtP=fopen('tCP.txt','w');
            contador=1;
            while contador<=filas
                p0=entrada(contador,1);
                gdp=target(contador,1);
                switch separador
                    case {3,9,15}
                        fprintf(idiV,'%f\r\n',p0);
                        fprintf(idtV,'%f\r\n',gdp);
                        x_CV=x_CV+1;
                    case {6,12,18}
                        fprintf(idiP,'%f\r\n',p0);
                        fprintf(idtP,'%f\r\n',gdp);
                        x_CP=x_CP+1;
                    case 20
                        fprintf(idiE,'%f\r\n',p0);
                        fprintf(idtE,'%f\r\n',gdp);
                        separador=0;
                        x_CE=x_CE+1;
                    otherwise
                        fprintf(idiE,'%f\t',p0);
                        fprintf(idtE,'%f\r\n',gdp);

                end

                contador=contador+1;
                separador=separador+1;
            end
            %
            fclose(idiE);
            fclose(idiV);
            fclose(idiP);
            fclose(idtE);
            fclose(idtV);
            fclose(idtP);
        otherwise
            fprintf('Opción incorrecta');
end

    
%% Ingreso de Vector de arquitectura
v1=input('Ingrese el vector de la arquitectura: \n');
fprintf('\nTomando en cuenta que:\n 1. purelin(n) \n 2. logsig(n) \n 3. tansig(n)\n');
v2=input('Ingrese el vector de funciones de activación: \n');

p0=zeros(v1(1,1),1);
[x,y]=size(v1);
[x2,y2]=size(v2);
red=cell(1,y-1);
bias=cell(1,y-1);


for i=1:y-1
	red{i}=2*rand(v1(i+1),v1(i))-1;
	bias{i}=2*rand(v1(i+1),1)-1;
end
disp(red);
disp(bias);

%% Datos de la red
% obtenemos el tamaño de nuetra red
tamRi=size(red);
tamR=tamRi(1,1);
%Valor de error aceptable para considerar aprendizaje exitoso
error_epoch_train=input('Dame el valor aceptable del error(error_epoch_train): ');
%valor del factor de aprendizaje
alfa=input('valor del factor de aprendizaje: ');
%Número máximo de épocas
epochmax=input('Número máximo de épocas: ');
%Cada cuantas iteraciones se llevará a cabo una época de validación
epoch_val=input('Épocas de validación: ');
%Número máximo de incrementos consecutivos del error_epoch_validation
num_val=input('Número máximo de incrementos consecutivos del error_epoch_validation: ');

%% Conjunto de entrenamiento
fileIDce = fopen('iCE.txt','r');
formatSpecce='%f';
size1=[x_CE,1];
ce=fscanf(fileIDce,formatSpecce,size1);
fclose(fileIDce);
fileIDte = fopen('tCE.txt','r');
formatSpecce='%f';
size1=[x_CE,1];
te=fscanf(fileIDte,formatSpecce,size1);
fclose(fileIDce);

%% Conjunto de validacion
fileIDcv = fopen('iCV.txt','r');
formatSpecce='%f';
size1=[x_CV,1];
cv=fscanf(fileIDcv,formatSpecce,size1);
fclose(fileIDcv);
fileIDtv = fopen('tCV.txt','r');
formatSpecce='%f';
size1=[x_CV,1];
tv=fscanf(fileIDce,formatSpecce,size1);
fclose(fileIDce);

%% while para el aprendizaje
contadorEpoch=1;
n_v=0;
e_v=0;
errorDeValidacion=1;
esElprimero=true;
%Creamos .txt para guardar el error
idiError=fopen('historialError.txt','w');
%Creamos .txt para contadorEpoch
idiContador=fopen('historialContador.txt','w');

while contadorEpoch<=epochmax && n_v<num_val && errorDeValidacion>error_epoch_train
    
    modulito=mod(contadorEpoch,epoch_val);
    if modulito==0
        fprintf('Esta es una época de validación\n');
        errorDeValidacion=0;
        for iv=1:x_CV
            pdv=cv(iv,1);
            a=pdv;
            for c=1:tamR   
                a=Funcion(v2(1,c),red{c,1},a,bias{c,1});
            end
            errorU=tv(iv,1)-a;
            errorDeValidacion=errorDeValidacion+abs(errorU);
        end 
        errorDeValidacion=errorDeValidacion/x_CV;
       if esElprimero
           errorAnterior=errorDeValidacion;
           esElprimero=false;
       else
        if errorDeValidacion>errorAnterior
                n_v=n_v+1;
        else
                n_v=0;
        end
            errorAnterior=errorDeValidacion;
       end
       fprintf(idiError,'%f\r\n',errorDeValidacion);
        if n_v==num_val
           fprintf('Se alcanzo el numval maximo por early stopping: %d \n',num_val); 
        end    
    else
        errorDeEntrenamiento=0;
for ie=1:x_CE
    an=cell(1,tamR);
  
    a=ce(ie,1);
    for c=1:tamR
        a=Funcion(v2(1,c),red{c,1},a,bias{c,1});
        an{1,c}=a;
    end
t=te(ie,1);


%aprendizaje
                         %Sensitividades
 S{tamR}=Funcion2(v2(tamR),0,0,a,t);
        j=tamR-1;
        while j>0
            S{j}=Funcion2(v2(j),red{j+1},S{j+1},an{1,j},t);
            j=j-1;
        end

 %                          Ajuste de pesos y bias

     red{1,1} = red{1,1}-alfa*S{1,1}*p0;
     bias{1,1} = bias{1,1}-alfa*S{1,1};
          for j=2:tamR
                red{j,1} = red{j,1}-alfa*S{j,1}*transpose(an{1,j-1});
                bias{j,1} = bias{j,1}-alfa*S{j,1};      
          end
            
errorU=t-a;
errorDeEntrenamiento=errorDeEntrenamiento+abs(errorU);
end 
errorDeEntrenamiento=(errorDeEntrenamiento/x_CE);
fprintf(idiError,'%f\r\n',errorDeEntrenamiento);
    end
    contadorEpoch=contadorEpoch+1;
    errorDeValidacion=errorDeEntrenamiento;
    if errorDeEntrenamiento <= error_epoch_train
    disp("Aprendizaje Exitoso en la epoca: "+contadorEpoch+" con error de Entrenamiento= "+errorDeEntrenamiento);
    fprintf(idiContador,'%f\r\n',contadorEpoch);
    else
    disp("Epoca actual>> "+contadorEpoch+" Error de Entrenamiento>> "+errorDeEntrenamiento);
    fprintf(idiContador,'%f\r\n',contadorEpoch);
    end
    disp(bias(:,1))

end

%cerramos .txt para error
fclose(idiError);
%cerramos .txt para contadorEpoch
fclose(idiContador);
%validación de resultados

%% Conjunto de pruebas
fileIDcp = fopen('iCP.txt','r');
formatSpecce='%f';
size1=[x_CP,1];
cp=fscanf(fileIDcp,formatSpecce,size1);
fclose(fileIDcp);
%%%
fileIDtp = fopen('tCP.txt','r');
formatSpecce='%f';
size1=[x_CP,1];
tp=fscanf(fileIDtp,formatSpecce,size1);
fclose(fileIDce);

%propago hacia adelante
    errorDePrueba=0;
    idRes=fopen('resultados.txt','w');
    for iv=1:x_CP
            pdc=cp(iv,1);
            a=pdc;
            %%%
            for c=1:tamR
      
               a=Funcion(v2(1,c),red{c,1},a,bias{c,1});
                
            end
            fprintf(idRes,'%f\r\n',a);
            errorU=tv(iv,1)-a;
            errorDePrueba=errorDePrueba+abs(errorU);
    end
    fclose(idRes);
    fileIDRes = fopen('resultados.txt','r');
    formatSpecce='%f';
    size1=[x_CP,1];
    resultados=fscanf(fileIDRes,formatSpecce,size1);
    fclose(fileIDRes);
    figure
    target = data(:,2);
    signal= data(:,1);
    hold on;
    plot(signal,target,'g:', cp,tp,'o b', cp,resultados,'+ r');
    legend('Señal Real', 'Targets', 'Valores obtenidos');   
    title('Resultados')
    
    
    %Guardar los pesos y bias en un txt
    fileIDPyBF = fopen('pesosybias.txt','w');
    %%disp(red);
    %%disp(bias);
    
    fprintf(fileIDPyBF,'-pesos\r\n');
     for i=1:tamR
         
         tamipp=size(red{i,1});
         
         fprintf(fileIDPyBF,'capa');
         fprintf(fileIDPyBF,'%d\r\n',i);
         for x=1:tamipp(1,1)
             for y=1:tamipp(1,2)
         fprintf(fileIDPyBF,'%f\t',red{i,1}(x,y));
             end
             fprintf(fileIDPyBF,'\r\n');
         end
         tamipb=size(bias{i,1});
         fprintf(fileIDPyBF,'bias');
         fprintf(fileIDPyBF,'%d\r\n',i);
         for x=1:tamipb(1,1)
             for y=1:tamipb(1,2)
         fprintf(fileIDPyBF,'%f\t',bias{i,1}(x,y));
             end
             fprintf(fileIDPyBF,'\r\n');
         end
     end
    %fprintf(idtP,'%f\r\n',gdp);
    fclose(fileIDRes);
    %grafica de error de época y validacion
    idE= fopen('historialError.txt','r');
    formatSpecce='%f';
    size1=[contadorEpoch-1,1];
    e=fscanf(idE,formatSpecce,size1);
    fclose(idE);
    idC= fopen('historialContador.txt','r');
    formatSpecce='%f';
    size1=[contadorEpoch-1,1];
    c=fscanf(idC,formatSpecce,size1);
    fclose(idC);
    figure
    plot(c,e,'o');
    
end

%% Conjunto de datos
function [Mvalidacion, Maprendizaje, Mprueba]=ConjuntoDat(mux, data)
    if(mux==1)
        mac = .7;
        mvc = .15;
        mpc = .15;
    else
        mac = .8;
        mvc = .1;
        mpc = .1;
    end
    fprintf('>> Conjunto de datos elegido [%i %i %i]\n', mac*100, mvc*100, mpc*100);

    %%matrizAUX=data;
    [filas, ~]=size(data);
    Mvalidacion = [];
    Maprendizaje = [];
    Mprueba = [];
    aux1=1;
    aux2=1;
    aux3=1;
    for i = 1:floor(filas/(mvc*100)):filas
        if aux1<=ceil(filas*mvc)
            Mvalidacion = [Mvalidacion; data(i,:)];
            aux1=aux1+1;
        else
            %ya no haces nada
        end
    end
    for i = 1:ceil(filas/(mac*100)):filas
            Maprendizaje = [Maprendizaje; data(i,:)];

    end
    
    for i = 2:ceil(filas/(mpc*100)):filas
        if aux3<=ceil(filas*mpc)
            Mprueba = [Mprueba; data(i,:)];
            aux3=aux3+1;
        else
            %nada
        end
    end
end