%% Inicio del programa
function ProgramaPara01()
%% Limpia consola
    clear,clc,close all
fprintf('El famosisimo MLP 3000\n\n');
%% Carga del archivo de prototipos y targets
    disp('Usaras un unico archivo de entradas y targets o usaras un archivo para entradas y targets?\n');
    opcion=input('1.Un archivo / 2.Dos Archivos : ');
    if opcion==1
     [archivo,ruta]=uigetfile('*.txt','Seleccione el archivo de entradas y targets');
        if archivo==0
         return;
        else
         txt=strcat(ruta,archivo);
        end
    data=load(txt);
    else
    [archivo,ruta]=uigetfile('*.txt','Seleccione el archivo de Entradas');
        if archivo==0
         return;
        else
         txt=strcat(ruta,archivo);
        end  
     [archivo2,ruta2]=uigetfile('*.txt','Seleccione el archivo de targets');
        if archivo2==0
         return;
        else
         txt2=strcat(ruta2,archivo2);
        end
    valores=load(txt);
    targets=load(txt2);
    data = horzcat(valores,targets);
    end

    fprintf('>> El archivo "%s" se cargó correctamente \n\n', txt);
    fprintf('Archivo ingresado: %s\n', txt);
    plot(data(:,2));
    
     %% Asignación de los conjuntos de datos
    TdD=input('Tomando en cuenta que [aprendiaje validacion pruebas] \n 1.[70% 15% 15%] \n 2.[80% 10% 10%] \nElija la opcion de distribución deseada: ');
    %%%%%%%%%%%%%%%%%%%%%%%eleccion del dataset
    [tam,~]=size(data);
    eo=data(:,1);
    to=data(:,2);

    tamCE=0;
    tamCV=0;
    tamCP=0;
    switch TdD
        case 1

            separador=1;
            idiE=fopen('iCE.txt','w');
            idiV=fopen('iCV.txt','w');
            idiP=fopen('iCP.txt','w');
            idtE=fopen('tCE.txt','w');
            idtV=fopen('tCV.txt','w');
            idtP=fopen('tCP.txt','w');

            contador=1;
            while contador<=tam
                p=eo(contador,1);
                gdp=to(contador,1);
                switch separador
                    case 4
                        fprintf(idiV,'%f\r\n',p);
                        fprintf(idtV,'%f\r\n',gdp);
                        tamCV=tamCV+1;
                    case 7
                        fprintf(idiP,'%f\r\n',p);
                        fprintf(idtP,'%f\r\n',gdp);
                        tamCP=tamCP+1;
                    case 10
                        fprintf(idiE,'%f\r\n',p);
                        fprintf(idtE,'%f\r\n',gdp);
                        separador=0;
                        tamCE=tamCE+1;
                    otherwise
                        fprintf(idiE,'%f\r\n',p);
                        fprintf(idtE,'%f\r\n',gdp);
                        tamCE=tamCE+1;
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
            while contador<=tam
                p=eo(contador,1);
                gdp=to(contador,1);
                switch separador
                    case {3,9,15}
                        fprintf(idiV,'%f\r\n',p);
                        fprintf(idtV,'%f\r\n',gdp);
                        tamCV=tamCV+1;
                    case {6,12,18}
                        fprintf(idiP,'%f\r\n',p);
                        fprintf(idtP,'%f\r\n',gdp);
                        tamCP=tamCP+1;
                    case 20
                        fprintf(idiE,'%f\r\n',p);
                        fprintf(idtE,'%f\r\n',gdp);
                        separador=0;
                        tamCE=tamCE+1;
                    otherwise
                        fprintf(idiE,'%f\t',p);
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

p=zeros(v1(1,1),1);
cC=size(v1);
cC=cC(1,2);

switch cC
    case 2
        capa1=zeros(v1(1,1),v1(1,2));
        b1=zeros(v1(1,2),1);
        red=cell(1,1);
        red{1}=capa1;
        bias=cell(1,1);
        bias{1}=b1;
    case 3
        capa1=zeros(v1(1,1),v1(1,2));
        b1=zeros(v1(1,2),1);
        capa2=zeros(v1(1,2),v1(1,3));
        b2=zeros(v1(1,3),1);
        red=cell(2,1);
        red{1}=capa1;
        red{2}=capa2;
        bias=cell(2,1);
        bias{1}=b1;
        bias{2}=b2;
    case 4
        capa1=zeros(v1(1,1),v1(1,2));
        b1=zeros(v1(1,2),1);
        capa2=zeros(v1(1,2),v1(1,3));
        b2=zeros(v1(1,3),1);
        capa3=zeros(v1(1,3),v1(1,4));
        b3=zeros(v1(1,4),1);
        red=cell(3,1);
        red{1}=capa1;
        red{2}=capa2;
        red{3}=capa3;
        bias=cell(3,1);
        bias{1}=b1;
        bias{2}=b2;
        bias{3}=b3;
    case 5
        capa1=zeros(v1(1,1),v1(1,2));
        b1=zeros(v1(1,2),1);
        capa2=zeros(v1(1,2),v1(1,3));
        b2=zeros(v1(1,3),1);
        capa3=zeros(v1(1,3),v1(1,4));
        b3=zeros(v1(1,4),1);
        capa4=zeros(v1(1,4),v1(1,5));
        b4=zeros(v1(1,5),1);
        red=cell(4,1);
        red{1}=capa1;
        red{2}=capa2;
        red{3}=capa3;
        red{4}=capa4;
        bias=cell(4,1);
        bias{1}=b1;
        bias{2}=b2;
        bias{3}=b3;
        bias{4}=b4;
    otherwise
        fprintf('No soportado');
end

%% Datos de la red
% obtenemos el tamaño de nuetra red
tamRi=size(red);
tamR=tamRi(1,1);
%Valor de error aceptable para considerar aprendizaje exitoso
error_epoch_train=input('Dame el valor aceptable del error(error_epoch_train): ');
%valor del factor de aprendizaje
fa=input('valor del factor de aprendizaje: ');
%Número máximo de épocas
epochMax=input('Número máximo de épocas: ');
%Cada cuantas iteraciones se llevará a cabo una época de validación
epoch_val=input('Épocas de validación: ');
%Número máximo de incrementos consecutivos del error_epoch_validation
num_val=input('Número máximo de incrementos consecutivos del error_epoch_validation: ');



%% Se inicializan los valores de los parámetros entre -1 y 1 forma aleatoria
%para los pesos
for vap=1:tamR
%cada uno de las capas de la red
    capAux=red{vap,1};
    tmanio=size(capAux);
    for i=1:tmanio(1,1)
        for j=1:tmanio(1,2)
            capAux(i,j)=2.*rand()-1;
        end
    end
    red{vap,1}=capAux;
end
%para los bias
for vap=1:tamR
%cada uno de las capas de la red
    capAux=bias{vap,1};
    tmanio=size(capAux);
    for i=1:tmanio(1,1)
        for j=1:tmanio(1,2)
            capAux(i,j)=2.*rand()-1;
        end
    end
    bias{vap,1}=capAux;
end
disp(red);
disp(bias);

%% Conjunto de entrenamiento
fileIDce = fopen('iCE.txt','r');
formatSpecce='%f';
size1=[tamCE,1];
ce=fscanf(fileIDce,formatSpecce,size1);
fclose(fileIDce);
fileIDte = fopen('tCE.txt','r');
formatSpecce='%f';
size1=[tamCE,1];
te=fscanf(fileIDte,formatSpecce,size1);
fclose(fileIDce);

%% Conjunto de validacion
fileIDcv = fopen('iCV.txt','r');
formatSpecce='%f';
size1=[tamCV,1];
cv=fscanf(fileIDcv,formatSpecce,size1);
fclose(fileIDcv);
fileIDtv = fopen('tCV.txt','r');
formatSpecce='%f';
size1=[tamCV,1];
tv=fscanf(fileIDce,formatSpecce,size1);
fclose(fileIDce);

%%%% while para el aprendizaje
contadorEpoch=1;
n_v=0;
e_v=0;
errorDeValidacion=1;
esElprimero=true;
%Creamos .txt para guardar el error
idiError=fopen('historialError.txt','w');
%Creamos .txt para contadorEpoch
idiContador=fopen('historialContador.txt','w');
while contadorEpoch<=epochMax && n_v<num_val && errorDeValidacion>error_epoch_train
    modulito=mod(contadorEpoch,epoch_val);
    if modulito==0
        fprintf('Esta es una época de validación\n');
        errorDeValidacion=0;
        for iv=1:tamCV
            pdv=cv(iv,1);
            vectorAPropagar=pdv;
            for c=1:tamR      
               switch v2(1,c)
                    case 1
                        vectorAPropagar=purelin(vectorAPropagar*red{c,1}+transpose(bias{c,1}));
                    case 2       
                        vectorAPropagar=logsig(vectorAPropagar*red{c,1}+transpose(bias{c,1}));
                    case 3
                        vectorAPropagar=tansig(vectorAPropagar*red{c,1}+transpose(bias{c,1}));
                end
                
            end
            errorU=tv(iv,1)-vectorAPropagar;
            errorDeValidacion=errorDeValidacion+abs(errorU);
        end 
        errorDeValidacion=errorDeValidacion/tamCV;
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
for ie=1:tamCE
    an=cell(1,tamR);
    p=ce(ie,1);
    vectorAPropagar=p;
    for c=1:tamR
        switch v2(1,c)
            case 1
                vectorAPropagar=purelin(vectorAPropagar*red{c,1}+transpose(bias{c,1}));
            case 2       
                vectorAPropagar=logsig(vectorAPropagar*red{c,1}+transpose(bias{c,1}));
            case 3
                vectorAPropagar=tansig(vectorAPropagar*red{c,1}+transpose(bias{c,1}));
        end
        
        an{1,c}=vectorAPropagar;
    end
tamni=size(an);

a=vectorAPropagar;
t=te(ie,1);


%aprendizaje
%calcular F[N]s

 fNS=cell(tamR,1);
 contador=1;
 for c=tamR:-1:1
     switch v2(1,c)
         case 1
             FMnM=1;
         case 2
             FMnM=zeros(v1(1,c+1),v1(1,c+1));
             for i=1:v1(1,c+1)
                 for j=1:v1(1,c+1)
                     if i==j
                         aux=an{1,c};
                        FMnM(i,j)=aux(1,i)*(1-aux(1,i));
                     end
                 end    
             end
         case 3
             FMnM=zeros(v1(1,c+1),v1(1,c+1));
             for i=1:v1(1,c+1)
                 for j=1:v1(1,c+1)
                     if i==j
                         aux=an{1,c};
                         FMnM(i,j)=1-aux(1,i).^2;
                     end
                 end    
             end
         otherwise
             fprintf('Algo malo esta pasando');
     end
     fNS{c,1}=FMnM;
 end
 %                          Calculando sensitividades
 sensitividades=cell(tamR,1);
 for sen=tamR:-1:1
     if sen==tamR
         sensitividades{sen,1}=-2*fNS{sen,1}*(t-a);
     else
         sensitividades{sen,1}=fNS{sen,1}*red{sen+1,1}*sensitividades{sen+1,1};
    end
 end
 %                          Ajuste de pesos y bias
 for ap=tamR:-1:1
     
     if ap==1
         ra=transpose(fa*sensitividades{ap,1}*p);
        tam=size(red{ap,1});
        for i=1:tam(1,1)
            for j=1:tam(1,2)
                red{ap,1}(i,j)=red{ap,1}(i,j)-ra(i,j);
            end
        end
        rb=transpose(fa*sensitividades{ap,1});
        tam=size(bias{ap,1});
        for i=1:tam(1,1)
            for j=1:tam(1,2)
                bias{ap,1}(i,j)=bias{ap,1}(i,j)-rb(j,i);
            end
        end
     else
         ra=transpose(fa*sensitividades{ap,1}*an{1,ap-1});
         tam=size(red{ap,1});
        for i=1:tam(1,1)
            for j=1:tam(1,2)
            red{ap,1}(i,j)=red{ap,1}(i,j)-ra(i,j);
            end
        end
        rb=transpose(fa*sensitividades{ap,1});
        tam=size(bias{ap,1});
         for i=1:tam(1,1)
            for j=1:tam(1,2)
                bias{ap,1}(i,j)=bias{ap,1}(i,j)-rb(j,i);
            end
         end
     end 
 end

errorU=te(ie,1)-vectorAPropagar;
errorDeEntrenamiento=errorDeEntrenamiento+abs(errorU);
end 
errorDeEntrenamiento=(errorDeEntrenamiento/tamCE);
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
size1=[tamCP,1];
cp=fscanf(fileIDcp,formatSpecce,size1);
fclose(fileIDcp);
%%%
fileIDtp = fopen('tCP.txt','r');
formatSpecce='%f';
size1=[tamCP,1];
tp=fscanf(fileIDtp,formatSpecce,size1);
fclose(fileIDce);

%propago hacia adelante
    errorDePrueba=0;
    idRes=fopen('resultados.txt','w');
    for iv=1:tamCP
            pdc=cp(iv,1);
            vectorAPropagar=pdc;
            %%%
            for c=1:tamR
      
                switch v2(1,c)
                    case 1
                        vectorAPropagar=purelin(vectorAPropagar*red{c,1}+transpose(bias{c,1}));
                    case 2       
                        vectorAPropagar=logsig(vectorAPropagar*red{c,1}+transpose(bias{c,1}));
                    case 3
                        vectorAPropagar=tansig(vectorAPropagar*red{c,1}+transpose(bias{c,1}));
                end
                
            end
            fprintf(idRes,'%f\r\n',vectorAPropagar);
            errorU=tv(iv,1)-vectorAPropagar;
            errorDePrueba=errorDePrueba+abs(errorU);
    end
    fclose(idRes);
    fileIDRes = fopen('resultados.txt','r');
    formatSpecce='%f';
    size1=[tamCP,1];
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