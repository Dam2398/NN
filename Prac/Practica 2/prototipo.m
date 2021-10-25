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

while t<=50
if t==1
    
end


 plot(t,a2(:,:,:));
    


